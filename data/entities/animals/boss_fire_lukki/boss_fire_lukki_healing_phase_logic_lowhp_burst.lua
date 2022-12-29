dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	

local angle_inc = 0
local angle_inc_set = false

local length = 400 + Random( -90, 90 )


angle = math.rad( Random( 1, 360 ) )

local vel_x = math.cos( angle ) * length
local vel_y = 0- math.sin( angle ) * length

shoot_projectile( entity_id, "data/entities/animals/boss_fire_lukki/projectiles/revenge_firebolt.xml", x, y, vel_x, vel_y )

--GameEntityPlaySound( entity_id, "shoot" )

