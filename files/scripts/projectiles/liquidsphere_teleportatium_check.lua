dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_success( pos_x, pos_y )
    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform(entity_id)

    -- Get projectile data
    local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    if vel_x == nil then
        vel_x = 0
        vel_y = 0
    end

    shoot_projectile_from_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/deck/liquidsphere_fire.xml", pos_x, pos_y, vel_x, vel_y )
    EntityKill(entity_id)
end