
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
EntitySetTransform(entity_id, pos_x, pos_y - 0.25)
