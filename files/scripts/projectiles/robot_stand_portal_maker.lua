dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

shoot_projectile_from_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/robot_stand_portal.xml", pos_x, pos_y, 0, 0 )