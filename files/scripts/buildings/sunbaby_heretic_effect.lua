dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), x + y + entity_id )

local angle = math.rad(Random(0,359))
local length = 340

local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length

shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/hexshot_bloodcurse_nohome.xml", x + vel_x * 0.25, y + vel_y * 0.25, vel_x, vel_y )
