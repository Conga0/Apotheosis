local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if GameHasFlagRun("apotheosis_flesh_boss_released") then EntityKill(entity_id) return end

local players = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "player_unit")
if #players <= 0 then
    local plyr_x, plyr_y = EntityGetTransform(EntityGetClosestWithTag(pos_x, pos_y, "player_unit"))
    
    GameAddFlagRun("apotheosis_flesh_boss_released")
    EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster.xml", plyr_x, plyr_y - 300)
    EntityKill(entity_id)
end