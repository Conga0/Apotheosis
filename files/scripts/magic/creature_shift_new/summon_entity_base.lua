
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local filepath = ""
EntityLoad(filepath,pos_x,pos_y)
EntityKill(entity_id)