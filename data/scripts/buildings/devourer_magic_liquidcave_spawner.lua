dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	EntityLoad( "data/entities/animals/devourer_magic.xml", pos_x, pos_y )
	EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_small.xml", pos_x, pos_y )
	
	EntityKill( entity_id )
end