dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
local herd_id = 0

--Grabs herd id to revert back to later
local comp = EntityGetComponentIncludingDisabled(parent,"GenomeDataComponent")[1]
if comp ~= nil then
    herd_id = ComponentGetValue2(comp,"herd_id")
end

--Saves normal herd id in the targetter entity
local comp = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")[1]
if comp ~= nil then
    ComponentSetValue2(comp,"value_int",herd_id)
end

GenomeSetHerdId( parent, "helpless" )