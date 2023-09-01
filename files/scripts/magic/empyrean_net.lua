
local entity_id = GetUpdatedEntityID()
local player = EntityGetRootEntity(entity_id)

local pos_x, pos_y = EntityGetTransform(player)

if pos_y > -3900 then
    EntitySetTransform(player,pos_x,pos_y + -4100)
    local cam_x, cam_y =GameGetCameraPos()
    GameSetCameraPos(cam_x,cam_y + -4100)
end