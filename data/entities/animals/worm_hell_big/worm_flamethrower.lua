local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local r = 160

local target = EntityGetInRadiusWithTag(pos_x, pos_y, r, "player_unit")[1] or nil

if ( target ~= nil ) then
	dofile_once("data/scripts/lib/utilities.lua") --Tired sinning as they say

	local angle_inc = 0

	local length = 350

	local ex, ey = EntityGetTransform( target )
	
	if ( ex ~= nil ) and ( ey ~= nil ) then
		angle_inc = 0 - math.atan2( ( ey - pos_y ), ( ex - pos_x ) )
	end

	local angle = angle_inc

	local vel_x = math.cos( angle ) * length
	local vel_y = 0- math.sin( angle ) * length

	local proj_id = shoot_projectile( EntityGetRootEntity(entity_id), "data/entities/animals/worm_hell_big/projectiles/fire_trap.xml", pos_x, pos_y, vel_x, vel_y )
	local projcomp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
	ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("worm"))
end
