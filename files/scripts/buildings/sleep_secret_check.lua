
--GamePrint("time is " .. GameGetRealWorldTimeSinceStarted())

if GameGetRealWorldTimeSinceStarted() < 12 then
    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform(entity_id)
    local players = EntityGetInRadiusWithTag(pos_x, pos_y, 72, "player_unit") or {}
    if #players > 0 then
        --GamePrint("Secret Success")
        --Seeded RNG
        SetRandomSeed(pos_x + 666,777)
        local lootpool = {
            "data/entities/items/wand_level_03.xml",
            "data/entities/items/wand_level_02.xml",
            "data/entities/items/wand_unshuffle_02.xml",
            "data/entities/items/wand_unshuffle_01.xml",
        }
        EntityLoad(lootpool[Random(1,#lootpool)], pos_x, pos_y)
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb/create", pos_x, pos_y )
        EntityKill(entity_id)
    end
end