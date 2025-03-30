
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)
local pos_x = EntityGetTransform(player_id)

pos_x = math.max(math.min(1,pos_x),-1)
EntitySetTransform(player_id,23000 * pos_x,-600)

