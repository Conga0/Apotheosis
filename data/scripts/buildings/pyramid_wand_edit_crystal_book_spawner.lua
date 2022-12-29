dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local eid = EntityLoad( "mods/Apotheosis/files/entities/items/books/book_divine_liquid.xml", pos_x, pos_y )
	
	EntityKill( entity_id )
end