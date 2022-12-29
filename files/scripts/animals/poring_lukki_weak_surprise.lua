dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	eid = EntityLoad( "data/entities/animals/excavationsite/poring_lukki.xml", pos_x, pos_y )
	EntityLoad( "mods/Apotheosis/files/entities/particle_generators/jellopy_explosion.xml", pos_x, pos_y )
	
	GamePlaySound( "data/audio/Desktop/animals.bank", "animals/statue/appear", pos_x, pos_y )

	if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then
		local comp = EntityGetFirstComponent( eid, "DamageModelComponent" )

		local health = ComponentGetValue2( comp, "hp" )
		local health_max = ComponentGetValue2( comp, "max_hp" )

		health = health * 2
		health_max = health_max * 2

		ComponentSetValue( comp, "max_hp", tostring(health_max) )
		ComponentSetValue( comp, "hp", tostring(health) )
	end

	EntityKill( entity_id )
end