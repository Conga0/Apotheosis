
function collision_trigger()
    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform(entity_id)

    local did_hit, hit_x, pos_y = Raytrace( pos_x, pos_y, pos_x, pos_y + 300 )

    if did_hit then
        EntityLoad("data/entities/animals/forest_monolith.xml", pos_x, pos_y)
    else
        EntityLoad("data/entities/animals/forest_monolith.xml", hit_x, hit_y)
    end

    EntityKill(entity_id)
end