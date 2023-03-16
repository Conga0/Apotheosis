function init( entity_id )
    if EntityGetParent(entity_id) == 0 then
        local pos_x, pos_y = EntityGetTransform(entity_id)
        SetRandomSeed( pos_x+666, pos_y+777)
        if Random(1,100) == 1 then
            EntityLoad("mods/apotheosis/files/entities/items/pickups/potion_rare.xml", pos_x, pos_y)
            EntityKill(entity_id)
        elseif Random(1,80) == 1 then
            local opts = {"fairy","mud","robot",}
            EntityLoad("data/entities/items/pickup/apotheosis/egg_" .. opts[Random(1,#opts)] .. ".xml", pos_x, pos_y)
            EntityKill(entity_id)
        end
    end
end