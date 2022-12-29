dofile_once("data/scripts/lib/utilities.lua")

local lerp_amount = 0.980

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local parent_id = EntityGetRootEntity(GetUpdatedEntityID())
	
-- move to parent when spawned if no other clouds present
if pos_x == 0 and pos_y == 0 then
	pos_x, pos_y = EntityGetTransform(parent_id)
	EntitySetTransform( entity_id, pos_x, pos_y, 0, 1, 1)
	return
end

-- lerp towards target
local target_x, target_y = EntityGetTransform(parent_id)
if target_x == nil then return end

-- move towards target
pos_x,pos_y = vec_lerp(pos_x, pos_y, target_x, target_y, lerp_amount)
EntitySetTransform( entity_id, pos_x, pos_y, 0, 1, 1)
