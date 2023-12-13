
local entity_id = GetUpdatedEntityID()

local x,y,r = EntityGetTransform( entity_id )
EntitySetTransform( entity_id, x, y, r + 0.81)
