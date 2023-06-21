
function teleported( from_x, from_y, to_x, to_y, wasportal )

    local entity_id = GetUpdatedEntityID()
    local targets = EntityGetInRadiusWithTag(from_x, from_y, 128,"teleportable_NOT")
    for k=1,#targets
    do local v = targets[k]
        if EntityHasTag(v,"player_unit") == false then
            local x,y = EntityGetTransform(v)
            EntitySetTransform(v,to_x + (x - from_x), to_y + (y - from_y))
            --GameShootProjectile( v, to_x, to_y, to_x - (from_x - x), to_y - (from_y - y), EntityLoad("data/entities/projectiles/deck/teleport_projectile_short.xml", to_x, to_y), false)
        end
    end
end