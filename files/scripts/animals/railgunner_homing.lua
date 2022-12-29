dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "VelocityComponent" )

ComponentSetValue2( comp, "air_friction", 3 )
ComponentSetValue2( comp, "mass", 300 )