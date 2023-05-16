
local child_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(child_id)
local balance = false

--Scans for if the Soaring status is applied, if so, player is given normalised flight instead of infinite
local children = EntityGetAllChildren(entity_id)
for k=1,#children
do local v = children[k]
    if EntityGetName(v) == "flight_buff" then
        balance = true
        break
    end
end

local charactercomp = EntityGetFirstComponentIncludingDisabled(entity_id,"CharacterDataComponent")

if charactercomp then
    if balance == false then

        --Disable player's flight
        ComponentSetValue2(charactercomp,"fly_time_max",0)

    else
        ComponentSetValue2(charactercomp, "flying_needs_recharge", true)
        ComponentSetValue2(charactercomp,"fly_time_max",3)
    end
end

-- Soaring + nothing  = Infinite Flight
-- Soaring + Grounded = Normal Flight
-- nothing + Grounded = Disabled Flight
