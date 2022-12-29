dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

-- check that we're only shooting every 10 frames
if script_wait_frames( entity_id, 10 ) then  return  end

local how_many = 3
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 300

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	shoot_projectile( entity_id, "data/entities/animals/boss_fire_lukki/projectiles/piercing_firebolt.xml", pos_x, pos_y, vel_x, vel_y )
end