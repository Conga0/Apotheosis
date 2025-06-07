
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")

if GameHasFlagRun("apotheosis_free_statues") then
    EntityKill(entity_id)
    EntityLoad(ComponentGetValue2(vcomp,"value_string"), pos_x, pos_y-6)
end