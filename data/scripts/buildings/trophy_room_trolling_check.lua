dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function collision_trigger()
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform( entity_id )
	local r = 256

	local targets = EntityGetInRadiusWithTag( x, y, r, "apotheosis_angrymage" )

	for i,v in ipairs( targets ) do
		EntityKill( v )
	end
	
	-- reward
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
	EntityLoad("mods/Apotheosis/files/entities/particle_generators/smoke_cloud_generator.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)

	if ModIsEnabled("raksa") == false then
		AddFlagPersistent( "apotheosis_card_unlocked_rage_aura" )

		if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
			AddFlagPersistent( "apotheosis_card_unlocked_rage_aura_goldmode" )
			EntityLoad("mods/Apotheosis/files/entities/props/goldmode/statue_master_of_trolling.xml", 4288, 2169)
		else
			EntityLoad("mods/Apotheosis/files/entities/props/statue_master_of_trolling.xml", 4288, 2169)
		end
	end

	--cleanup
	EntityKill( entity_id )
end



--EntityLoad("mods/Apotheosis/files/entities/props/statue_master_of_trolling.xml", 4288, 2169)