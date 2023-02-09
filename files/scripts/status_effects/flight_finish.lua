
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 
local children = EntityGetAllChildren( player )
local permitted = true

if children == nil or #children == 0 then return end

for k=1,#children
do v = children[k]
    local name = EntityGetName(v)
    if (name == "flight_buff") and (v ~= entity_id) then
        permitted = false
    end
end

if permitted == true then
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent"), "flying_needs_recharge", true)

    local comp = EntityGetFirstComponentIncludingDisabled(player, "PathFindingComponent")
    if comp ~= nil then
        local cost = ComponentGetValue2(comp, "cost_of_flying")
        ComponentSetValue2(comp, "cost_of_flying", cost * 20)
    end
end
