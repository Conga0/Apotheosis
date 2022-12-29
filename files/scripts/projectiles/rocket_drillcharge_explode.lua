dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local vel_x, vel_y = 0,0

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
end)

local angle = math.atan2( vel_y, vel_x ) + math.rad(math.random(-10,10))
local length = 20


local count = 2

for i=1,count do
    vel_x = math.cos(angle) * length
    vel_y = math.sin(angle) * length

	local px = pos_x + vel_x
	local py = pos_y + vel_y
	shoot_projectile_from_projectile( entity_id, "data/entities/animals/boss_fire_lukki/projectiles/enlightened_laser_fireball.xml", px + Random( -5, 5 ), py + Random( -5, 5 ), vel_x, vel_y )
    length = length + 20
end
