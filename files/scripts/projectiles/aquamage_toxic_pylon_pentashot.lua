dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local vx, vy = GameGetVelocityCompVelocity(entity_id)

for i=1, 2 do
    ---@diagnostic disable-next-line: undefined-global
    local vx1, vy1 = vec_rotate(vx, vy, math.rad(i*10))
    ---@diagnostic disable-next-line: undefined-global
    shoot_projectile_from_projectile(entity_id, "mods/Apotheosis/files/entities/projectiles/aquamage_toxic_pylon_pentashot_nolua.xml", x, y, vx1, vy1)
    ---@diagnostic disable-next-line: undefined-global
    local vx2, vy2 = vec_rotate(vx, vy, -math.rad(i*10))
    ---@diagnostic disable-next-line: undefined-global
    shoot_projectile_from_projectile(entity_id, "mods/Apotheosis/files/entities/projectiles/aquamage_toxic_pylon_pentashot_nolua.xml", x, y, vx2, vy2)
end