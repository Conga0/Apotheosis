dofile_once("data/scripts/lib/utilities.lua")

local child_id    = GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)
local x, y = EntityGetTransform( entity_id )
local speed = 120
SetRandomSeed( x, y * GameGetFrameNum() )

local spells = { "orb_manadrain", "orb_unstable_transmutation", "orb_tele", "orb_hearty", "orb_poly", "orb_neutral", "orb_homing" } --Homebringer curse of swapping would be evil... hmmm
local rnd = Random( 1, #spells )
--local path = "data/entities/animals/boss_flesh_monster/projectiles/bloodtentacle_flesh.xml"
local path = "mods/Apotheosis/files/entities/projectiles/bloodshot_BoC.xml"

local arc = math.pi * 0.25
local offset = math.pi * ( Random( 1, 10 ) * 0.1 )

for i=0,7 do
	local vel_x = math.cos( arc * i + offset ) * speed
	local vel_y = 0 - math.sin( arc * i + offset ) * speed
	local pid = shoot_projectile( entity_id, path, x, y, vel_x, vel_y )
	local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
	ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
end

--If we grab rootentityid here, couldn't we make it give kill credit to the Aesthete of Heat?

