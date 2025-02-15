dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/gun.lua")
local speed = 20

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )

-- velocity
local vel_x,vel_y = GameGetVelocityCompVelocity(entity_id)
vel_x, vel_y = vec_normalize(vel_x, vel_y)
if vel_x == nil then return end
vel_x = vel_x * speed
vel_y = vel_y * speed

local count = 5

SetRandomSeed( pos_x * vel_x, pos_y * vel_y )

for i=1,count do
	local px = pos_x + vel_x * 2
	local py = pos_y + vel_y * 2
	local pid = shoot_projectile_from_projectile( entity_id, "data/entities/animals/boss_flesh_monster/projectiles/enlightened_laser_shadowbeam.xml", px + Random( -5, 5 ), py + Random( -5, 5 ), vel_x, vel_y )
	local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
	ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
	velcomp = EntityGetFirstComponentIncludingDisabled( pid, "VelocityComponent" )
	ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
	ComponentSetValue2(velcomp, "mPrevVelocity", vel_x, vel_y)
	if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		EntityAddComponent(pid, "LuaComponent", {
			script_source_file="mods/Apotheosis/files/scripts/projectiles/proj_no_flip.lua",
			execute_every_n_frame=1
		})
	end
end

-- sound is played here instead of the projectiles to avoid duplicates
GamePlaySound( "data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_fire", pos_x, pos_y )

