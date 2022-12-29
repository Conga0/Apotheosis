dofile_once("data/scripts/lib/utilities.lua")



local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local how_many = 30
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 250 --Originally 200.. but needs to be artifically made faster to compensate for moist modifier decreasing projectile speed

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/fungus_smoke_maker.xml", pos_x, pos_y, vel_x, vel_y )
end

EntityKill(entity_id)