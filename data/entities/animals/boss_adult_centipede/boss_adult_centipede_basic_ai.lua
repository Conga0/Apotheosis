
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")

local angle = math.atan2(targ_y, targ_x)
local laser_cooldown_duration = 15 * 60
local current_frame = GameGetFrameNum()

local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
for k=1,#variablecomp
do local v = variablecomp[k]
    if ComponentGetValue2(v,"name") == "basic_ai" then
        variablecomp = v
        break
    end
end



--Keeps worm focused on the player if they're their target
if ComponentGetValue2( variablecomp, "value_string" ) == "player" then
    local player_id = EntityGetWithTag("player_unit")[1]
    if EntityHasTag(player_id,"mortal") then
        ComponentSetValue2(wormAiComp,"mTargetEntityId",player_id)
        --GamePrint("Test 1")
    else
        ComponentSetValue2( variablecomp, "value_string", "null" )
        --GamePrint("Test 2")
    end
else
    local target_id = ComponentGetValue2(wormAiComp,"mTargetEntityId")
    if EntityHasTag(target_id,"player_unit") then
        ComponentSetValue2( variablecomp, "value_string", "player" )
        --GamePrint("Test 3")
    end
end
