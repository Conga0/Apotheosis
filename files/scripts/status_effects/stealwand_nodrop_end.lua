dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(entity_id)
local inventories = EntityGetAllChildren(victim_id)
local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local string_data = ComponentGetValue2(vsc_comp,"value_string")

local entities_to_enable = SplitStringOnCharIntoTable(string_data,",") or {}

if #entities_to_enable > 0 then
    for k=1,#entities_to_enable do
        local ability_comp = EntityGetFirstComponentIncludingDisabled(entities_to_enable[k],"AbilityComponent")
        ComponentSetValue2(ability_comp,"throw_as_item",true)
    end
end
