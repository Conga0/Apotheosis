
local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "HomingComponent" )

ComponentSetValue2( comp, "detect_distance", 700 )
