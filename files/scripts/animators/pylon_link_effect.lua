dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local parent = ComponentGetValue2(vsccomp,"value_int")
if EntityHasTag(parent,"mortal") == false then EntityKill(entity_id) return end
local time = GameGetFrameNum()

-- "arms" particle fx position.
-- sets the fx entity position to between hand and body and wobbles it!
do
	local children = EntityGetAllChildren(entity_id)
	if children == nil or #children == 0 then return end
	
	-- "shoulder" position
	local parent_x,parent_y = EntityGetTransform(parent)
	parent_y = parent_y - 10

	for k=1,#children
	do local fx_entity = children[k]
		if EntityHasTag(fx_entity, "arm_fx") then

			-- pick a position between body and hand. 0 is body, 1 is hand
			local pos = ProceduralRandomf(time, fx_entity)

			-- figure out how much to distort the position
			-- middle distorts most so we want a range of 0 to 1 to 0
			local amount = pos * 2 - 1 -- 0...1 -> -1...0...1
			amount = -math.abs(amount) -- -1...0...-1
			amount = amount + 1 -- 0...1...0

			local distort_x = math.sin((x + time) * 0.03) * 8 * amount
			local distort_y = math.sin((y + time) * 0.05734 + 40) * 4 * amount

			x, y = vec_lerp(parent_x, parent_y, x, y, pos)
			x = x + distort_x
			y = y + distort_y
			EntitySetTransform(fx_entity, x, y)
		end
	end
end


