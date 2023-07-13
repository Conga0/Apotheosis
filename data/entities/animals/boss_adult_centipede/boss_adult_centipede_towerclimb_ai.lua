
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

--Should rubberband if player is further than 200 units away, could be refined, still unsure what to do with this gooper
local targ EntityGetInRadiusWithTag(pos_x, pos_y, 200, "player_unit")
if #targ < 1 then
    ComponentSetValue2( wormAiComp, "speed", 6 )
    ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.25 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.55 )
else
    ComponentSetValue2( wormAiComp, "speed", 1 )
    ComponentSetValue2( wormAiComp, "speed_hunt", 3 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.15 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.45 )
end
