local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local plyr_check = EntityGetInRadiusWithTag(pos_x,pos_y,400,"player_unit")
if #plyr_check <= 0 then
	GameDropAllItems( entity_id )
	EntityKill(entity_id)
end