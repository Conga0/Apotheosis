
--Checks if certain creatures were spawned inside a wall, if so, try to unstuck them.
--Used for Magic Devouerer & Devouring Phantom

local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity_id )
  
local did_hit = RaytraceSurfaces(x, y, x, y - 1)
  
if did_hit then
	
	local failsafe = 20
	local success = false

	repeat
		local new_x = x + math.random(-100,100)
		local new_y = y + math.random(-100,100)

		local did_hit = RaytraceSurfaces(new_x, new_y, new_x, new_y - 1)
		failsafe = failsafe - 1

		if not did_hit then
			EntityApplyTransform(entity_id, new_x, new_y)
			success = true
		end

	until failsafe <= 1 or success

end
