dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local how_many = 4
local angle_inc = math.pi * 0.5
local theta = 0
local length = 200
local length_base = 300

GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/magic_rocket_big", pos_x, pos_y )

for i=1,how_many do
	local r_boost = Random(0,20)
	length = 200 + r_boost
	length_base = 300 + r_boost
	for j=1,2 do
		local vel_x = math.cos( theta ) * (length * j + length_base)
		local vel_y = math.sin( theta ) * (length * j + length_base)

		local pid = shoot_projectile_from_projectile( entity_id, "data/entities/animals/boss_flesh_monster/deathlaser/death_cross_big_laser.xml", pos_x, pos_y, vel_x, vel_y )
		local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
		ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
	end
	
	theta = theta + angle_inc
end
