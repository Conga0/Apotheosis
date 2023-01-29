dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local pos_x,pos_y = EntityGetTransform(entity_id)

    EntityLoad( "data/entities/items/pickup/heart.xml", pos_x, pos_y )
    EntityLoad( "data/entities/items/wand_unshuffle_05.xml", pos_x, pos_y - 16 )
end