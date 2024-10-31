-- This enemy is riddled with great intuitive systems :thumbsup:
local entity_id    = GetUpdatedEntityID()
local comp_id = EntityGetFirstComponentIncludingDisabled( entity_id, "LuaComponent", "enabled_by_liquid" )
local varcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local count = ComponentGetValue2( varcomp, "value_int")

ComponentSetValue2( varcomp, "value_int", 0)

EntitySetComponentIsEnabled( entity_id, comp_id, true)

