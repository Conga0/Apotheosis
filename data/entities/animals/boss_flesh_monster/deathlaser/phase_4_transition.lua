local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local storages = EntityGetComponentIncludingDisabled( root_id, "VariableStorageComponent" )[1]
ComponentSetValue2( storages, "value_int", 4)

--Set movement speed back to it's normal amount in phase 2
local comp = EntityGetComponentIncludingDisabled( root_id, "PhysicsAIComponent")[1]
ComponentSetValue2(comp, "force_coeff", 24)
ComponentSetValue2(comp, "force_max", 300)