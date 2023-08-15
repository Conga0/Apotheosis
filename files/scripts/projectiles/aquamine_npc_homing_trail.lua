dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local angle = math.rad(Random(0,359))
local length = 40

local vel_x = math.cos( angle ) * length
local vel_y = -math.sin( angle ) * length

---@diagnostic disable-next-line: undefined-global
shoot_projectile_from_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/aquamine_npc.xml", pos_x, pos_y, vel_x, vel_y )