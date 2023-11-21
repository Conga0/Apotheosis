
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
--Changin it up so it's a bit more dynamic so it checks for distances instead of just being a get in radius - Spoop
-- local targ = EntityGetInRadiusWithTag(pos_x, pos_y, 200, "player_unit")

local targ = EntityGetClosestWithTag(pos_x, pos_y, "player_unit")

local targ_x, targ_y = EntityGetTransform(targ)

if targ ~= nil and (math.abs(pos_y - targ_y) + math.abs(pos_x - targ_x)) > 500 then
    ComponentSetValue2( wormAiComp, "speed", 10 )
    ComponentSetValue2( wormAiComp, "speed_hunt", 10 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.25 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.55 )
elseif targ ~= nil and (math.abs(pos_y - targ_y) + math.abs(pos_x - targ_x)) > 350 then
    ComponentSetValue2( wormAiComp, "speed", 5 )
    ComponentSetValue2( wormAiComp, "speed_hunt", 6 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.25 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.55 )
elseif targ ~= nil and (math.abs(pos_y - targ_y) + math.abs(pos_x - targ_x)) > 200 then
    ComponentSetValue2( wormAiComp, "speed", 3 )
    ComponentSetValue2( wormAiComp, "speed_hunt", 4 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.2 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.5 )
else
    ComponentSetValue2( wormAiComp, "speed", 1 )
    ComponentSetValue2( wormAiComp, "speed_hunt", 3 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.15 )
    ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.45 )
end
