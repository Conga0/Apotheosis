
local child_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(child_id)
local balance = false

local jump_vel = -55
local swim_vel = 1.1

--If this effect is from the "yggdrasil's Curse" entity, give the player extra jump strength to compensate for their permanent lack of levitation
if EntityGetName(child_id) == "apotheosis_curse_of_yggdrasil" then
    jump_vel = -105
    swim_vel = 1.6
end

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
        local comp2 = EntityGetFirstComponentIncludingDisabled(entity_id,"CharacterPlatformingComponent")

        --Grabs the player's current jump & swiming velocity to set back later
        local old_jump = ComponentGetValue2(comp2,"jump_velocity_y")
        local old_swim = ComponentGetValue2(comp2,"swim_up_buoyancy_coeff")

        --Adjust player's jump & swim velocity, letting them more reasonably traverse the environment when grounded
        ComponentSetValue2(comp2,"jump_velocity_y",old_jump + jump_vel)
        ComponentSetValue2(comp2,"swim_up_buoyancy_coeff",old_swim + swim_vel)

    else
        ComponentSetValue2(charactercomp, "flying_needs_recharge", true)
        ComponentSetValue2(charactercomp,"fly_time_max",3)
    end
end

-- Soaring + nothing  = Infinite Flight
-- Soaring + Grounded = Normal Flight
-- nothing + Grounded = Disabled Flight
