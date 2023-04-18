
function collision_trigger()
    local entity_id = GetUpdatedEntityID()
    local x,y = EntityGetTransform(entity_id)
    EntityLoad("data/entities/animals/worm_wall.xml",x,y)
    EntityKill(entity_id)
end