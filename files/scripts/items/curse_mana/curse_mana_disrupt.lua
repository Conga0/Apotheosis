
function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id = GetUpdatedEntityID()
	local pos_x,pos_y = EntityGetTransform(entity_id)

    local c = EntityLoad("mods/Apotheosis/files/entities/misc/curse_mana/mana_disrupt.xml", pos_x, pos_y)
    EntityAddChild(entity_id,c)

    local children = EntityGetAllChildren(entity_id)
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_curse_of_mana" then
            EntitySetComponentsWithTagEnabled(v,"disabled_by_liquid",false)
            break
        end
    end
end