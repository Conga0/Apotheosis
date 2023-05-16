
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 
local children = EntityGetAllChildren( player )
local permitted = true
local balance = false

if children == nil or #children == 0 then return end

--If the player has another source of grounding applied, do not cancel grounding's effects
--If the player has "soaring" applied, then let soaring's effects resume when grounded expires
for k=1,#children
do v = children[k]
    local name = EntityGetName(v)
    if (name == "apotheosis_no_flight") and (v ~= entity_id) then
        permitted = false
    elseif name == "flight_buff" then
        balance = true
    end
end

if permitted == true then
    local comp = EntityGetFirstComponentIncludingDisabled(player,"CharacterDataComponent")

    if comp ~= nil then
        if balance == false then
            ComponentSetValue2(comp,"fly_time_max",3)
        else
            ComponentSetValue2(comp, "flying_needs_recharge", false)
        end
    end
end
