
local entity_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(entity_id)
local inventories = EntityGetAllChildren(victim_id)

local entities_to_disable = {}

for inventory_index = 1, #inventories do
    if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
        -- Find last potion tagged item
        local children = EntityGetAllChildren(inventories[inventory_index]) or {}
        for i = 1, #children do
            local ability_comp = EntityGetFirstComponentIncludingDisabled(children[i],"AbilityComponent") or 0
            if ability_comp ~= 0 and ability_comp ~= nil then
                local is_throwable = ComponentGetValue2(ability_comp,"throw_as_item") or false
                if is_throwable then
                    ComponentSetValue2(ability_comp,"throw_as_item",false)
                    table.insert(entities_to_disable,children[i])
                end
            end
        end
        break
    end
end

if #entities_to_disable > 0 then
    local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    ComponentSetValue2(vsc_comp,"value_string",table.concat(entities_to_disable,","))
end