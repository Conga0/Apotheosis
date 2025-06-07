local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local worldEntity = GameGetWorldStateEntity()
local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
local time = ComponentGetValue2(comp,"time")
local skylight = GameGetSkyVisibility( pos_x, pos_y )

if (time < 0.55 or time > 0.70) and (pos_y < 500 or skylight > 0.5) then
    local gamecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"GameEffectComponent")
    ComponentSetValue2(gamecomp,"frames",1)
end