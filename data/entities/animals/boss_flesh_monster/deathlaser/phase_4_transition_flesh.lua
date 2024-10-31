local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local storages = EntityGetComponentIncludingDisabled( root_id, "VariableStorageComponent" )[1]
ComponentSetValue2( storages, "value_int", 4)

--Set movement speed back to it's normal amount in phase 2
local comp = EntityGetComponentIncludingDisabled( root_id, "PhysicsAIComponent")[1]
if not GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
	ComponentSetValue2(comp, "force_coeff", 32)
end