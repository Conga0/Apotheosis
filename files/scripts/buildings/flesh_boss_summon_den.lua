
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local players = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "player_unit")
if #players > 0 then
    local plyr_x, plyr_y = EntityGetTransform(EntityGetClosestWithTag(pos_x, pos_y, "player_unit"))
    
    GameAddFlagRun("apotheosis_flesh_boss_released")
    EntityLoad( "mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster.xml", pos_x + 257, pos_y + 140 )
    EntityKill(entity_id)
end