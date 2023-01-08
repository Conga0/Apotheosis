dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
local herd_id = 0

--Grabs the original herd id from the targetter entity
local comp = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")[1]
if comp ~= nil then
    herd_id = ComponentGetValue2(comp,"value_int")
end

--Reverts the target's herd id back to their original one
local comp = EntityGetComponentIncludingDisabled(parent,"GenomeDataComponent")[1]
if comp ~= nil then
    ComponentSetValue2(comp,"herd_id", herd_id)
end
