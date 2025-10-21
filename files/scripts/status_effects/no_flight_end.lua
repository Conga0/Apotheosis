
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 
local children = EntityGetAllChildren( player )
local permitted = true
local balance = false

local jump_vel = -55
local swim_vel = 1.1

--If this effect is from the "yggdrasil's Curse" entity, give the player extra jump strength to compensate for their permanent lack of levitation
if EntityHasTag(child_id,"watermage") then
    jump_vel = -105
    swim_vel = 1.6
end

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

    --Restore player's jump & swim velocity back to normal
    local comp2 = EntityGetFirstComponentIncludingDisabled(player,"CharacterPlatformingComponent")

    local old_jump = ComponentGetValue2(comp2,"jump_velocity_y")
    local old_swim = ComponentGetValue2(comp2,"swim_up_buoyancy_coeff")

    ComponentSetValue2(comp2,"jump_velocity_y",math.max(old_jump - jump_vel,-95))
    ComponentSetValue2(comp2,"swim_up_buoyancy_coeff",math.max(old_swim - swim_vel,swim_vel))
end
