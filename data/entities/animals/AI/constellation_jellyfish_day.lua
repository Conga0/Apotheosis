dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if isDayTime(pos_x,pos_y) == false then
    --Within this range is night time for noita
    EntityKill(entity_id)
    EntityLoad("data/entities/animals/constellation_jellyfish.xml",pos_x,pos_y)
end