
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local players = EntityGetWithTag("player_unit")

for k=1,#players
do v = players[k]
    local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_protection_all_short_invisible.xml", pos_x, pos_y)
    EntityAddChild(v,c)
end