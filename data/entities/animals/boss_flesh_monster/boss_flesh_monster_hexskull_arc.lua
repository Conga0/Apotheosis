dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )


local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

target = targets[1]


local angle_inc = 0
local angle_inc_set = false

local length = 85

if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
	local ex, ey = EntityGetTransform( target )
	
	if ( ex ~= nil ) and ( ey ~= nil ) then
		angle_inc = 0 - math.atan2( ( ey - pos_y ), ( ex - pos_x ) )
		angle_inc_set = true
	end
end

local angle = 0
if angle_inc_set then
	angle = angle_inc
else
	angle = math.rad( Random( 1, 360 ) )
end

local vel_x = math.cos( angle ) * length
local vel_y = 0- math.sin( angle ) * length

local proj_id = shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x, vel_y )
local projcomp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))

local vel_x1, vel_y1 = vec_rotate(vel_x, vel_y, math.rad(10))
local pid1 = shoot_projectile_from_projectile(proj_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x1, vel_y1)
projcomp = EntityGetFirstComponentIncludingDisabled( pid1, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
local vel_x2, vel_y2 = vec_rotate(vel_x, vel_y, -math.rad(10))
local pid2 = shoot_projectile_from_projectile(proj_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x2, vel_y2)
projcomp = EntityGetFirstComponentIncludingDisabled( pid2, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
local vel_x1, vel_y1 = vec_rotate(vel_x, vel_y, math.rad(20))
local pid3 = shoot_projectile_from_projectile(proj_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x1, vel_y1)
projcomp = EntityGetFirstComponentIncludingDisabled( pid3, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
local vel_x2, vel_y2 = vec_rotate(vel_x, vel_y, -math.rad(20))
local pid4 = shoot_projectile_from_projectile(proj_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x2, vel_y2)
projcomp = EntityGetFirstComponentIncludingDisabled( pid4, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
