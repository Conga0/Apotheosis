--dofile_once("data/scripts/lib/utilities.lua")
--Skedaddle towards player until tries to attack once

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local player_id = EntityGetClosestWithTag(pos_x,pos_y,"player_unit")
local player_far = false

local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
local limbstate = ComponentGetValue2(limbbosscomp, "state")

if player_id ~= 0 then
    local p_x, p_y = EntityGetTransform(player_id)
    local dis_x = p_x - pos_x
    local dis_y = p_y - pos_y

    local distance = get_magnitude(dis_x, dis_y)
if distance <= 500 and RaytracePlatforms(pos_x, pos_y, p_x, p_y) == false then
    ComponentSetValue2(limbbosscomp, "state", 5)

    --[[
    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, false )
    local physaicomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent" )
    ComponentSetValue2(physaicomp, "mLastPositionWhenHadPath", p_x, p_y)
    ]]--
else
    player_far = true
end
else
    player_far = true
end

if player_far == true and limbstate == 5 then
    ComponentSetValue2(limbbosscomp, "state", 1)
    --[[
    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    if (ComponentGetIsEnabled(pathfindcomp) == false) then
	EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )
    end
    ]]--
end