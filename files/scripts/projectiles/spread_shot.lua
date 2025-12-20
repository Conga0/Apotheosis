dofile_once("data/scripts/lib/utilities.lua")

function spreadProjectile()
    local entity_id = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity_id)
    local vx, vy = GameGetVelocityCompVelocity(entity_id)

    if EntityHasTag(entity_id,"projectile_cloned") then return end

    local vsc_data = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    local total_count = 3
    local spread = 40
    for k=1,#vsc_data do
        if ComponentGetValue2(vsc_data[k],"name") == "spread_data" then
            total_count = ComponentGetValue2(vsc_data[k],"value_int")
            spread = ComponentGetValue2(vsc_data[k],"value_float")
            break
        end
    end

    local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
    local projectile_file = ""

    if ( variablestorages ~= nil ) then
        for j,storage_id in ipairs(variablestorages) do
            local var_name = ComponentGetValue( storage_id, "name" )
            if ( var_name == "projectile_file" ) then
                projectile_file = ComponentGetValue2( storage_id, "value_string" )
            end
        end
    end

    if projectile_file == "" then return end

    local min_rot = (spread / 2) * -1
    local max_rot = (spread / 2)
    local rot_step = spread / (total_count-1)
    local current_rot = min_rot

    for k=1,total_count do
        local vx1, vy1 = vec_rotate(vx, vy, math.rad(current_rot))
        local eid = shoot_projectile_from_projectile(entity_id, projectile_file, x, y, vx1, vy1)
        EntityAddTag( eid, "projectile_cloned" )
        current_rot = current_rot + rot_step
    end

    EntityKill(entity_id)
end

spreadProjectile()