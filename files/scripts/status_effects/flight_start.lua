
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id )
local balance = false

--Scans for if the Grounded status is applied, if so, player is given normalised flight instead of infinite
local children = EntityGetAllChildren(player)
for k=1,#children
do local v = children[k]
    if EntityGetName(v) == "apotheosis_no_flight" then
        balance = true
        break
    end
end

local charactercomp = EntityGetFirstComponentIncludingDisabled(player, "CharacterDataComponent")

if balance == false then
    ComponentSetValue2(charactercomp, "flying_needs_recharge", false)

    local charactercomp = EntityGetFirstComponentIncludingDisabled(player, "PathFindingComponent")
    if charactercomp ~= nil then
        local cost = ComponentGetValue2(charactercomp, "cost_of_flying")
        ComponentSetValue2(charactercomp, "cost_of_flying", cost / 20)
    end
else
    if charactercomp ~= nil then
        ComponentSetValue2(charactercomp, "flying_needs_recharge", true)
        ComponentSetValue2(charactercomp,"fly_time_max",3)
    end
end

-- Soaring + nothing  = Infinite Flight
-- Soaring + Grounded = Normal Flight
-- nothing + Grounded = Disabled Flight
