
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 

ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent"), "flying_needs_recharge", false)

local comp = EntityGetFirstComponentIncludingDisabled(player, "PathFindingComponent")
if comp ~= nil then
    local cost = ComponentGetValue2(comp, "cost_of_flying")
    ComponentSetValue2(comp, "cost_of_flying", cost / 20)
end


