
local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "HomingComponent" )
ComponentSetValue2( comp, "detect_distance", 0 )

local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VelocityComponent")
ComponentSetValue2(velcomp,"air_friction",-1)
