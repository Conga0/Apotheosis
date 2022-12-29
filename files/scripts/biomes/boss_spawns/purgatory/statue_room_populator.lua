

function collision_trigger()
	local entity_id = GetUpdatedEntityID()

    --Normal Mode Unlocks
    local apotheosis_angel_dead = HasFlagPersistent( "apotheosis_card_unlocked_divinebeing" )
    local apotheosis_worm_dead = HasFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm" )
    local apotheosis_music_dead = HasFlagPersistent( "apotheosis_card_unlocked_musical_boss" )
    local apotheosis_blob_dead = HasFlagPersistent( "apotheosis_card_unlocked_blob_boss" )
    local apotheosis_divine_created = HasFlagPersistent( "apotheosis_card_unlocked_divine_liquid" )
    local apotheosis_donated_beggar = HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar" )
    local apotheosis_enrage_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_rage_aura" )
    local apotheosis_cat_secret_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_cat_secret" )

    --Nightmare/Purgatory Unlocks
    local apotheosis_angel_dead_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_divinebeing_goldmode" )
    local apotheosis_worm_dead_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm_goldmode" )
    local apotheosis_music_dead_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_musical_boss_goldmode" )
    local apotheosis_blob_dead_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_blob_boss_goldmode" )
    local apotheosis_divine_created_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_divine_liquid_goldmode" )
    local apotheosis_donated_beggar_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar_goldmode" )
    local apotheosis_enrage_unlocked_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_rage_aura_goldmode" )
    local apotheosis_cat_secret_unlocked_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_cat_secret_goldmode" )


    --1.1.0 unlocks

    --Normal Mode Unlocks
    local apotheosis_essence_fungus = HasFlagPersistent( "apotheosis_essence_fungus" )
    local apotheosis_essence_fungus_moon = HasFlagPersistent( "apotheosis_moon_fungus_unlock" )
    local apotheosis_pandora_rain = HasFlagPersistent( "apotheosis_misc_pandora_chest_rain" )
    local apotheosis_fire_lukki = HasFlagPersistent( "apotheosis_card_unlocked_boss_fire_lukki" )

    --Nightmare/Purgatory Unlocks
    local apotheosis_essence_fungus_goldmode = HasFlagPersistent( "apotheosis_essence_fungus_goldmode" )
    local apotheosis_essence_fungus_moon_goldmode = HasFlagPersistent( "apotheosis_moon_fungus_unlock_goldmode" )
    local apotheosis_pandora_rain_goldmode = HasFlagPersistent( "apotheosis_misc_pandora_chest_rain_goldmode" )
    local apotheosis_fire_lukki_goldmode = HasFlagPersistent( "apotheosis_card_unlocked_boss_fire_lukki_goldmode" )

    --For reference, the pixel scene spawns at    X 4032    Y 1988
    --Purgatory pixel scene spawns at           X 4555     Y 787
    --Difference                               X 523      Y -1202


    --Boss Kills
    --Killing the Divine Being
    if apotheosis_angel_dead_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_divine_being.xml", 4675, 853 )
    elseif apotheosis_angel_dead then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_divine_being.xml", 4675, 853 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4675, 853 )
    end

    --Killing the Toxic Worm
    if apotheosis_worm_dead_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_toxic_worm.xml", 4725, 853 )
    elseif apotheosis_worm_dead then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_toxic_worm.xml", 4725, 853 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4725, 853 )
    end

    --Killing the Abandoned Orchestra
    if apotheosis_music_dead_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_music_boss.xml", 4785, 853 )
    elseif apotheosis_music_dead then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_music_boss.xml", 4785, 853 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4785, 853 )
    end

    --Killing the Overgrown Blob
    if apotheosis_blob_dead_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_blob_titan.xml", 4835, 853 )
    elseif apotheosis_blob_dead then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_blob_titan.xml", 4835, 853 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4835, 853 )
    end




    --Harder Challenge Unlocks
    --Creating Divine Liquid
    if apotheosis_divine_created_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_divine_liquid.xml", 4701, 787 )
    elseif apotheosis_divine_created then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_divine_liquid.xml", 4701, 787 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4701, 787 )
    end

    --Feeding the Rat Wand to a Cat
    --Not necessarily a 'harder challenge', especially compared to the Divine Liquid challenge, but it's an upperfloor filler for now.
    if apotheosis_cat_secret_unlocked_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_cat_secret.xml", 4811, 787 )
    elseif apotheosis_cat_secret_unlocked then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_cat_secret.xml", 4811, 787 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4811, 787 )
    end



    --Lower Challenge Unlocks
    --Donating to a Homeless Hisii
    if apotheosis_donated_beggar_goldmode then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_generous.xml", 4703, 888 )
    elseif apotheosis_donated_beggar then
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_generous.xml", 4703, 888 )
    else
        entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4703, 888 )
    end

    --Luring a Master of Trolling to his statue outline
    --Gold statue base if already done in normal mode? uncertain
    if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
        if apotheosis_enrage_unlocked_goldmode then
            entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_master_of_trolling.xml", 4811, 888 )
        else
            if apotheosis_enrage_unlocked then
                entity = EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_empty.xml", 4811, 888 )
                entity = EntityLoad( "data/entities/buildings/trophy_room_trolling_check.xml", 4831, 893 )
            else
                entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4811, 888 )
                entity = EntityLoad( "data/entities/buildings/trophy_room_trolling_check.xml", 4831, 893 )
            end
        end
    else
        if apotheosis_enrage_unlocked then
            entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_master_of_trolling.xml", 4811, 888 )
        else
            entity = EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4811, 888 )
            entity = EntityLoad( "data/entities/buildings/trophy_room_trolling_check.xml", 4831, 893 )
        end
    end









    -- 1.1.0 Trophys, right side
    -- x + 284 for reference (OLD WIDE ROOM)

    
    -- y + 161 for reference

    

    --Harder Challenge Unlocks
    --Attaining the Essence of Fungus
    if apotheosis_essence_fungus_goldmode then
        EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_essence_fungus.xml", 4701, 948 )
    elseif apotheosis_essence_fungus then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_essence_fungus.xml", 4701, 948 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4701, 948 )
    end

    --Bringing the Essence of Fungus to either moon
    if apotheosis_essence_fungus_moon_goldmode then
        EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_essence_fungus_moon.xml", 4811, 948 )
    elseif apotheosis_essence_fungus_moon then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_essence_fungus_moon.xml", 4811, 948 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4811, 948 )
    end



    --Lower Challenge Unlocks
    --Causing Pandora's Chest Rain by bringing a Pandora's Chest to the mountain Altar
    if apotheosis_pandora_rain_goldmode then
        EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_pandora_rain.xml", 4703, 1049 )
    elseif apotheosis_pandora_rain then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_pandora_rain.xml", 4703, 1049 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4703, 1049 )
    end

    --Killing the Aesthete of Heat
    if apotheosis_fire_lukki_goldmode then
        EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_fire_lukki.xml", 4831, 1049 )
    elseif apotheosis_fire_lukki then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_fire_lukki.xml", 4831, 1049 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4831, 1049 )
    end



    EntityLoad( "data/entities/buildings/statue_room_fairy_populator.xml", 4779, 839 )

    EntityLoad( "data/entities/buildings/rat_unlock.xml", 4518, 540 )
    EntityLoad( "data/entities/buildings/rat_create.xml", 4518, 540 )
    EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_tiny.xml", 4518, 540 )

    EntityLoad( "data/entities/buildings/trophy_room_trolling_spawner.xml", 3735, 560 )


    EntityLoad( "data/entities/buildings/statue_room_noitavania_deleter.xml", 4779, 839 )
    EntityLoad( "data/entities/buildings/statue_room_noitavania_deleter.xml", 4256, 999 )

    EntityKill(entity_id)
end