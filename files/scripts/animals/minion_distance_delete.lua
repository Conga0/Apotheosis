local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local plyr_check = EntityGetInRadiusWithTag(pos_x,pos_y,400,"player_unit")
if #plyr_check <= 0 then
	GameDropAllItems( entity_id )
	EntityKill(entity_id)
end

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LifetimeComponent")
local frame = GameGetFrameNum()
if (frame + 91) > ComponentGetValue2(comp,"kill_frame") then
	GameDropAllItems( entity_id )
	local comp2 = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemPickUpperComponent")
	EntitySetComponentIsEnabled(entity_id,comp2,false)
end
