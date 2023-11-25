dofile_once("data/scripts/lib/utilities.lua")

-- kill self
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	-- do some kind of an effect? throw some particles into the air?
	EntityLoad( "data/entities/animals/fairy.xml", pos_x+5, pos_y )
	EntityLoad( "data/entities/animals/fairy.xml", pos_x-5, pos_y )
	EntityLoad( "data/entities/animals/fairy.xml", pos_x, pos_y+5 )
	EntityLoad( "data/entities/animals/fairy.xml", pos_x, pos_y-5 )
	EntityLoad( "data/entities/animals/fairy_big.xml", pos_x, pos_y )
end