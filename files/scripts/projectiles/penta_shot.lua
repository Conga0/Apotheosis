dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local vx, vy = GameGetVelocityCompVelocity(entity_id)
local comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent") or {}
local projectile_filepath = ""
local p_id = 0
for k=1,#comps do
    if ComponentGetValue2(comps[k],"name") == "projectile_file" then
        projectile_filepath = ComponentGetValue2(comps[k],"value_string")
        break
    end
end

if projectile_filepath ~= "" then
    for i=1, 2 do
        ---@diagnostic disable-next-line: undefined-global
        local vx1, vy1 = vec_rotate(vx, vy, math.rad(i*15))
        ---@diagnostic disable-next-line: undefined-global
        p_id = shoot_projectile_from_projectile(entity_id, projectile_filepath, x, y, vx1, vy1)

        local lcomp = EntityGetComponentIncludingDisabled(p_id,"LuaComponent")
        for k=1,#lcomp do
            if ComponentGetValue2(lcomp[k],"script_source_file") == "mods/apotheosis/files/scripts/projectiles/penta_shot.lua" then
                EntitySetComponentIsEnabled( entity_id, lcomp[k], false )
                break
            end
        end

        ---@diagnostic disable-next-line: undefined-global
        local vx2, vy2 = vec_rotate(vx, vy, -math.rad(i*15))
        ---@diagnostic disable-next-line: undefined-global
        p_id = shoot_projectile_from_projectile(entity_id, projectile_filepath, x, y, vx2, vy2)

        local lcomp = EntityGetComponentIncludingDisabled(p_id,"LuaComponent")
        for k=1,#lcomp do
            if ComponentGetValue2(lcomp[k],"script_source_file") == "mods/apotheosis/files/scripts/projectiles/penta_shot.lua" then
                EntitySetComponentIsEnabled( entity_id, lcomp[k], false )
                break
            end
        end
    end
end
