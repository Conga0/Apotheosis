dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger( player_id )

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	EntityLoad( "data/entities/particles/poof_blue.xml", pos_x, pos_y )
	local cid = EntityLoad( "mods/Apotheosis/files/entities/herobrine/message_approach_01.xml", pos_x, pos_y )
	EntityAddChild( player_id, cid )


	EntityKill( entity_id )
end