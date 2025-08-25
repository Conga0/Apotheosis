dofile_once("data/scripts/lib/utilities.lua")

local lerp_amount = 0.993

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local target_id = ComponentGetValue2(comp,"value_int")
local age = ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted")

-- lerp towards target
local target_x, target_y = EntityGetTransform(target_id)
if target_x == nil then return end

-- move towards target
pos_x,pos_y = vec_lerp(pos_x, pos_y, target_x, target_y, lerp_amount)
EntitySetTransform( entity_id, pos_x, pos_y, 0, 1, 1)
