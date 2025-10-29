
function item_pickup( entity_item, entity_who_picked, name )
	local player_id = EntityGetWithTag("player_unit")[1]
    local orb_count = GameGetOrbCountThisRun()
    local heretic_id = EntityGetWithTagInRadius(pos_x,pos_y,512,"apotheosis_heretic") or {}
    local pos_x, pos_y = EntityGetTransform(entity_item)
    local knowledge = EntityGetWithTagInRadius(pos_x,pos_y,512,"apotheosis_knowledge") or {}
	local time_in_seconds = tonumber( StatsGetValue("playtime") )

    --Uhhh, do stuff

    --Conga: Might need to make a script that unmakes the player (kills or disables them?) so we can handle the ending credits after they're dead but Without triggering the vanilla credits sequence


    --Have a buildup phase for every ending where the world rumbles & particles follow the player similar to the work (lava) ending
    --Then for ending 1, instantly polymorph the player (permanently), slowly scroll the camera upwards, roll credits (can reuse intro cutscene code for this)

    --For ending 2, have some fancy particle effects on the player, maybe they turn to smoke which flies upwards? Then wands & potions appear in the sky to join the other symbols
    --Only need to do this locally where the camera will be focused

    --For Ending 3, have the sky slowly turn red as the rumbling continues
    --Other god-symbols fade away as the sky continues to redden
    --The ground turns fleshy
    --After a short moment, Mina dies
    --Heretic symbols appear in the sky afterwards, and then roll credits


    --Ascending in less than 5 hours (or at least trying to)
    if time_in_seconds < 60 * 60 * 5 then
        AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_speedrun")
    end

    --Ascending in less than 1 hour
    if time_in_seconds < 60 * 60 * 1 then
        AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_speedrun_1hr")
    end

    --Winning in hardcore or nightcore mode
    if GameHasFlagRun("apotheosis_hardmode") then
        AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_hardcore")
    end

    --Winning in everything mode
    if GameHasFlagRun("apotheosis_everything") then
        AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_everything")
        AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_hardcore")
    end


    --Let's just make 3 seperate ents to handle it
    --Maybe reduce true orb knowledge requirement to 15? (maximum orbs possible in world 1, doesn't include corrupt orbs, forces player to stay in main world)

    --Conga: None of the 3 entities below currently exist, please keep track of whether they're taken care of or not IN FULL future me and/or other inspiring coders
    if #knowledge < 1 then
        --Ending 1
        --No kingly knowledge
        --Finished
        EntityLoad("mods/Apotheosis/files/entities/buildings/ending/ending_handler_01.xml", pos_x, pos_y)
    elseif #heretic_id < 1 then
        --Ending 2
        --Kingly knowledge but no heretic
        --Finished
        EntityLoad("mods/Apotheosis/files/entities/buildings/ending/ending_handler_02.xml", pos_x, pos_y)
    else
        --Ending 3
        --Kingly knowledge and heretic
        --Finished
        EntityLoad("mods/Apotheosis/files/entities/buildings/ending/ending_handler_03.xml", pos_x, pos_y)
    end

	EntityKill( entity_item )
end
