local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local worldEntity = GameGetWorldStateEntity()
local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
local time = ComponentGetValue2(comp,"time")

if time > 0.55 and time < 0.70 then
    --Within this range is night time for noita
    EntityKill(entity_id)
    EntityLoad("data/entities/animals/constellation_jellyfish.xml",pos_x,pos_y)
end