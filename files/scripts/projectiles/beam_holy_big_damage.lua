dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "DamageNearbyEntitiesComponent" )

ComponentSetValue2( comp, "radius", 0 )