dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform(entity_id)

    perk_spawn( pos_x, pos_y - 2, "EDIT_WANDS_EVERYWHERE" )

end