dofile_once("data/scripts/lib/utilities.lua")

local child_id    = GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y * GameGetFrameNum() )

local spells = { "orb_corrupt_manadrain", "orb_unstable_transmutation", "orb_tele", "orb_hearty", "orb_poly", "orb_neutral", "orb_homing" } --Homebringer curse of swapping would be evil... hmmm
local rnd = Random( 1, #spells )
local path = "data/entities/animals/boss_flesh_monster/projectiles/master_orbs/" .. spells[rnd] .. ".xml"

local arc = math.pi * 0.25
local offset = math.pi * ( Random( 1, 10 ) * 0.1 )

for i=0,7 do
	local vel_x = math.cos( arc * i + offset ) * 300
	local vel_y = 0 - math.sin( arc * i + offset ) * 300
	shoot_projectile( entity_id, path, x, y, vel_x, vel_y )
end

--If we grab rootentityid here, couldn't we make it give kill credit to the Aesthete of Heat?

