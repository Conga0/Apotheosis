
--Checks if certain creatures were spawned inside a wall, if so, try to unstuck them.
--Used for Magic Devouerer & Devouring Phantom

local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity_id )
  
local did_hit = RaytraceSurfaces(x, y, x, y - 1)
  
if did_hit then
	
	EntityKill(entity_id)

end
