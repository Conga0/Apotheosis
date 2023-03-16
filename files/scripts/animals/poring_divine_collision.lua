dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform( entity_id )
local r = 64

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "poring_holy" )

for k=1, #targets
do local v = targets[k];
	EntityLoad( "data/entities/particles/image_emitters/magical_symbol_fast_holy.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/greed_curse/create", pos_x, pos_y)
	GamePlaySound( "data/audio/Desktop/misc.snd", " misc/sun/supernova", pos_x, pos_y)
	EntityLoad( "mods/Apotheosis/files/entities/projectiles/circle_divine_liquid.xml", pos_x, pos_y )
	EntityLoad( "data/entities/particles/supernova.xml", pos_x, pos_y )
	EntityKill( v )
	EntityKill( entity_id )
	
	if ModIsEnabled("raksa") == false then
		AddFlagPersistent( "apotheosis_card_unlocked_divine_liquid" )

		if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
			AddFlagPersistent( "apotheosis_card_unlocked_divine_liquid_goldmode" )
		end

		if GameHasFlagRun("apotheosis_hardmode") and HasFlagPersistent( "apotheosis_card_unlocked_divine_liquid_goldmode") == false then
			EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_divine_liquid.xml", 4178, 2049 )
		elseif HasFlagPersistent( "apotheosis_card_unlocked_divine_liquid" ) == false then
			EntityLoad( "mods/Apotheosis/files/entities/props/statue_divine_liquid.xml", 4178, 2049 )
		end
	end

end