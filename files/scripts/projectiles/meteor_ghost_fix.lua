dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" )

ComponentSetValue2( comp, "on_collision_die", true )