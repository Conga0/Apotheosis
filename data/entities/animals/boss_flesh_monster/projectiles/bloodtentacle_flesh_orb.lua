dofile_once("data/scripts/lib/utilities.lua")

local child_id    = GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)
local x, y = EntityGetTransform( child_id )
local speed = 120
SetRandomSeed( x, y * GameGetFrameNum() )

local arc = math.pi * 0.25
local offset = math.pi * ( Random( 1, 10 ) * 0.1 )

local vel_x = math.cos( arc * 1 + offset ) * speed
local vel_y = 0 - math.sin( arc * 1 + offset ) * speed
shoot_projectile( entity_id, "data/entities/animals/boss_flesh_monster/projectiles/master_orbs/orb_magicslime.xml", x, y, vel_x, vel_y )

