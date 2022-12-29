dofile_once("data/scripts/lib/utilities.lua")



	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	EntityLoad( "data/entities/particles/poof_green.xml", pos_x, pos_y )
	EntityLoad( "data/entities/animals/alchemist_warping.xml", pos_x, pos_y )

	EntityKill( entity_id )
