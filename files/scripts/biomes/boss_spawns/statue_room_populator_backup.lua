
--I'll be honest, you caught me lackin
--These should be done through their own unique individual pixel scenes.. but there was so much code and I was tired, I just.. ugh..
--It'll only break if some other mod hijacks mountain_hall.lua and also hijacks the spawn_music_trigger function
--...No way anyone would *ever* use function spawn_music_trigger though.... right?

--PRANKED, check this code out, hijack it all you want nerds!!!

function collision_trigger()
	local entity_id = GetUpdatedEntityID()

    --More Creeps
    local apotheosis_worm_dead = HasFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm" )
    local apotheosis_music_dead = HasFlagPersistent( "apotheosis_card_unlocked_musical_boss" )
    local apotheosis_blob_dead = HasFlagPersistent( "apotheosis_card_unlocked_blob_boss" )
    local apotheosis_donated_beggar = HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar" )
    local apotheosis_enrage_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_rage_aura" )
    local apotheosis_cat_secret_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_cat_secret" )

    
    --1.1.0 unlocks
    local apotheosis_essence_fungus = HasFlagPersistent( "apotheosis_essence_fungus" )
    local apotheosis_pandora_rain = HasFlagPersistent( "apotheosis_misc_pandora_chest_rain" )
    local apotheosis_fire_lukki_dead = HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki" )

    --Apotheosis
    local apotheosis_heretic_dead = HasFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster" )
    local max_orbs = (GameGetOrbCountAllTime() > 44)
    local omega_death_quest = HasFlagPersistent( "apotheosis_card_unlocked_omega_cross" )





    --For reference, the pixel scene spawns at    X 4032    Y 1988


    --Boss Kills
    --Killing the Toxic Worm
    if apotheosis_worm_dead then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_toxic_worm.xml", 4152, 2115 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4152, 2115 )
    end

    --Killing the Abandoned Orchestra
    if apotheosis_music_dead then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_music_boss.xml", 4202, 2115 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4202, 2115 )
    end

    --Killing the Overgrown Blob
    if apotheosis_blob_dead then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_blob_titan.xml", 4262, 2115 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4262, 2115 )
    end

    --Killing the Aesthete of Heat
    if apotheosis_fire_lukki_dead then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_fire_lukki.xml", 4312, 2115 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4312, 2115 )
    end



    --Harder Challenge Unlocks
    --Killing the Heretic
    if apotheosis_heretic_dead then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_heretic_boss.xml", 4178, 2049 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4178, 2049 )
    end

    --Feeding the Rat Wand to a Cat
    --Not necessarily a 'harder challenge', especially compared to the Divine Liquid challenge, but it's an upperfloor filler for now.
    if apotheosis_cat_secret_unlocked then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_cat_secret.xml", 4288, 2049 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4288, 2049 )
    end



    --Lower Challenge Unlocks
    --Donating to a Homeless Hisii
    if apotheosis_donated_beggar then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_generous.xml", 4178, 2150 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4178, 2150 )
    end

    --Luring a Master of Trolling to his statue outline
    --Gold statue base if already done in normal mode? uncertain
    if apotheosis_enrage_unlocked then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_master_of_trolling.xml", 4288, 2150 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4288, 2150 )
        EntityLoad( "data/entities/buildings/trophy_room_trolling_check.xml", 4308, 2155 )
    end










    -- 1.1.0 Trophys, right side
    -- x + 284 for reference (OLD WIDE ROOM)

    
    -- y + 161 for reference

    

    --Harder Challenge Unlocks
    --Attaining 45 Orbs
    if max_orbs then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_orb_45.xml", 4178, 2210 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4178, 2210 )
    end

    --Finising the Omega Death quest
    if omega_death_quest then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_omega_death.xml", 4288, 2210 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4288, 2210 )
    end



    --Lower Challenge Unlocks
    --Causing Pandora's Chest Rain by bringing a Pandora's Chest to the mountain Altar
    if apotheosis_pandora_rain then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_pandora_rain.xml", 4178, 2331 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4178, 2331 )
    end

    --Attaining the Essence of Fungus
    if apotheosis_essence_fungus then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_essence_fungus.xml", 4288, 2331 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4288, 2331 )
    end





    EntityLoad( "data/entities/buildings/statue_room_fairy_populator.xml", 4256, 2100 ) -- North
    EntityLoad( "data/entities/buildings/statue_room_fairy_populator.xml", 4256, 2261 ) -- South

    EntityLoad( "data/entities/buildings/rat_unlock.xml", 4064, 2320 )
    EntityLoad( "data/entities/buildings/rat_create.xml", 4064, 2320 )

    EntityLoad( "data/entities/buildings/trophy_room_trolling_spawner.xml", 5318, 2037 )

    EntityKill(entity_id)
end