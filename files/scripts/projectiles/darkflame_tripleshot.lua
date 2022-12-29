dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local vx, vy = GameGetVelocityCompVelocity(entity_id)


local vx1, vy1 = vec_rotate(vx, vy, math.rad(25))
shoot_projectile_from_projectile(entity_id, "data/entities/projectiles/darkflame.xml", x, y, vx1, vy1)
local vx2, vy2 = vec_rotate(vx, vy, -math.rad(25))
shoot_projectile_from_projectile(entity_id, "data/entities/projectiles/darkflame.xml", x, y, vx2, vy2)