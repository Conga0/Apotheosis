
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
    entity_id = EntityGetRootEntity(entity_id)

    local children = EntityGetAllChildren(entity_id)
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_curse_of_mana" then
            EntitySetComponentsWithTagEnabled(v,"disabled_by_liquid",true)
            break
        end
    end
end