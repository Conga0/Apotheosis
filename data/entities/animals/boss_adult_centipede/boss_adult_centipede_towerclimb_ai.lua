
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")

--Keeps worm focused on the player
local player_id = EntityGetWithTag("player_unit")[1]
if EntityHasTag(player_id,"mortal") then
    ComponentSetValue2(wormAiComp,"mTargetEntityId",player_id)
    --GamePrint("Test 1")
else
    ComponentSetValue2( variablecomp, "value_string", "null" )
    --GamePrint("Test 2")
end

