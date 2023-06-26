dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local how_many = 16
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 100

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc
	
	local px = pos_x + vel_x * 0.1
	local py = pos_y + vel_y * 0.1

	GameEntityPlaySound( entity_id, "duplicate" )
	shoot_projectile( entity_id, "data/entities/animals/boss_adult_centipede/projectiles/acidshot.xml", px, py, vel_x, vel_y )
end
