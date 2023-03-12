

local entity_id    = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform( entity_id )

if EntityHasTag(entity_id,"touchmagic_immunity") == false and EntityHasTag(entity_id,"polymorphable_NOT") == false and EntityGetName(entity_id) ~= "Mutamies" then

	eid = EntityLoad( "data/entities/animals/mudman_friendly.xml", x, y )
	local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
	if( charm_component ~= nil ) then
		ComponentSetValue( charm_component, "frames", -1 )
	end
	EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_mud.xml", x, y )
	EntityLoad( "mods/Apotheosis/files/entities/particles/image_emitters/chest_effect_mud.xml", x, y )
	GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/polymorph/create", x, y )
	EntityKill( entity_id )

end
