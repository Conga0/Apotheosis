
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 
local children = EntityGetAllChildren( player )
local permitted = true
local balance = false

if children == nil or #children == 0 then return end

--If the player has another source of soaring applied, do not cancel soaring's effects
--If the player has "grounded" applied, then let grounded's effects resume when grounded expires
for k=1,#children
do v = children[k]
    local name = EntityGetName(v)
    if (name == "flight_buff") and (v ~= entity_id) then
        permitted = false
    elseif name == "apotheosis_no_flight" then
        balance = true
    end
end

if permitted == true then
    local charactercomp = EntityGetFirstComponentIncludingDisabled(player,"CharacterDataComponent") --[[@cast charactercomp number]]

    if balance == false then

        ComponentSetValue2(charactercomp, "flying_needs_recharge", true)

        local comp = EntityGetFirstComponentIncludingDisabled(player, "PathFindingComponent")
        if comp ~= nil then
            local cost = ComponentGetValue2(comp, "cost_of_flying")
            ComponentSetValue2(comp, "cost_of_flying", cost * 20)
        end
    else
        ComponentSetValue2(charactercomp, "flying_needs_recharge", true)
        ComponentSetValue2(charactercomp,"fly_time_max",0)
    end
end
