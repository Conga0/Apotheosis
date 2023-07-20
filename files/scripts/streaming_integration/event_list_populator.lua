local ModEnabledCTEP = ModIsEnabled("Conga_Twitch_mod")


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_RANDOM_CATS",
		ui_name = "$integration_apotheosis_RANDOM_CATS_name",
		ui_description = "$integration_apotheosis_RANDOM_CATS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local players = get_players()
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() + 353 )

            local catcount = 20
			
			for i,entity_id in ipairs( players ) do
                repeat
                    local x, y = EntityGetTransform( entity_id )
                    
                    local angle = Random( 0, 31415 ) * 0.0001
                    local length = 35
                    
                    local ex = x + math.cos( angle ) * length
                    local ey = y - math.sin( angle ) * length

                    EntityLoad( "mods/Apotheosis/files/entities/special/conjurer_cat_spawner.xml", ex, ey )

                    catcount = catcount - 1
        
                until (catcount < 1)
			end
		end,
	})
    end


    table.insert(streaming_events,
	{
		id = "apotheosis_RANDOM_CREEPS",
		ui_name = "$integration_apotheosis_RANDOM_CREEPS_name",
		ui_description = "$integration_apotheosis_RANDOM_CREEPS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 300,
		action_delayed = function(event)
                
            local currentLevel = tonumber( GlobalsGetValue( "apotheosis_biome_level", "1" ) )
            local pool = {}
                            
            if currentLevel == 1 then --Mines
            
                pool = {
                    "cat_apotheosis",
                    "ceiling_fungus",
                    "drone_mini",
                    "drone_status_ailment",
                    "enchanted_duck",
                    "fairy_cheap",
                    "fairy_big",
                    "fairy_big_discord",
                    "fungus_smoking_creep",
                    "goo_slug",
                    "hisii_giga_bomb",
                    "hisii_hobo",
                    "hisii_minecart",
                    "hisii_minecart_tnt",
                    "hisii_minecart_weak",
                    "longleg_pillar",
                    "mimic_explosive_box",
                    "poring",
                    "excavationsite/poring_lukki_fake",
                    "rat_birthday",
                    "wizard_explosive",
                    "wraith_returner_apotheosis",
                    "bubbles/acid/bubble_liquid",
                    "bubbles/water/bubble_liquid",
                    "bubbles/ambrosia/bubble_liquid",
                    "boss_toxic_worm/boss_toxic_worm_minion",
                }
            
            elseif currentLevel == 2 then --Coal Pits
            
                pool = {
                    "cat_apotheosis",
                    "ccc_bat_psychic",
                    "ceiling_fungus",
                    "drone_mini",
                    "drone_status_ailment",
                    "enchanted_duck",
                    "fairy_cheap",
                    "fairy_big",
                    "fairy_big_discord",
                    "fungus_smoking_creep",
                    "goo_slug",
                    "hideous_mass_red",
                    "hisii_giga_bomb",
                    "hisii_hobo",
                    "hisii_minecart",
                    "hisii_minecart_tnt",
                    "hisii_minecart_weak",
                    "lukki_swarmling",
                    "longleg_pillar",
                    "mimic_explosive_box",
                    "poring",
                    "excavationsite/poring_lukki_fake",
                    "rat_birthday",
                    "wraith_returner_apotheosis",
                    "whisp",
                    "wizard_ambrosia",
                    "wizard_manaeater",
                    "bubbles/acid/bubble_liquid",
                    "bubbles/water/bubble_liquid",
                    "bubbles/ambrosia/bubble_liquid",
                    "bubbles/freezing_liquid/bubble_liquid",
                    "boss_toxic_worm/boss_toxic_worm_minion",
                }
            
            elseif currentLevel == 3 then --Snowy Depths/Hiisi Base
            
                pool = {
                    "blob_big",
                    "cat_apotheosis_golden",
                    "ccc_bat_psychic",
                    "devourer_ghost",
                    "drone_mini",
                    "drone_status_ailment",
                    "enchanted_duck",
                    "fairy_cheap",
                    "fairy_big",
                    "fairy_big_discord",
                    "forsaken_eye",
                    "fungus_smoking_creep",
                    "secret/gazer_greater_cold",
                    "ghost_bow",
                    "hideous_mass_red",
                    "hisii_engineer",
                    "hisii_giga_bomb",
                    "hisii_hobo",
                    "hisii_minecart",
                    "hisii_minecart_tnt",
                    "hisii_rocketshotgun",
                    "mimic_explosive_box",
                    "poring_magic",
                    "excavationsite/poring_lukki_fake",
                    "rat_birthday",
                    "sentry",
                    "shaman_greater_apotheosis",
                    "tank_flame_apotheosis",
                    "tentacler_big",
                    "tesla_turret",
                    "whisp",
                    "wizard_ambrosia",
                    "wizard_copeseethmald",
                    "wizard_duck",
                    "wizard_manaeater",
                    "bubbles/acid/bubble_liquid",
                    "bubbles/ambrosia/bubble_liquid",
                    "bubbles/freezing_liquid/bubble_liquid",
                    "boss_toxic_worm/boss_toxic_worm_minion",
                }
            
            elseif currentLevel == 4 then --Jungle
            
                pool = {
                    "blob_big",
                    "cat_mocreeps_sorako",
                    "devourer_ghost",
                    "devourer_magic",
                    "fairy_cheap",
                    "fairy_big",
                    "forsaken_eye",
                    "fungus_smoking_creep",
                    "secret/gazer_greater_cold",
                    "ghost_bow",
                    "giant_centipede",
                    "hideous_mass_red",
                    "hisii_engineer",
                    "hisii_giga_bomb",
                    "hisii_rocketshotgun",
                    "locust_swarm",
                    "lukki_fungus",
                    "lukki_swarmling",
                    "mimic_explosive_box",
                    "poring_magic",
                    "poring_lukki",
                    "rat_birthday",
                    "sentry",
                    "shaman_greater_apotheosis",
                    "tank_flame_apotheosis",
                    "tentacler_big",
                    "tesla_turret",
                    "wizard_ambrosia",
                    "wizard_copeseethmald",
                    "wizard_duck",
                    "wizard_jackofalltrades",
                    "wizard_manaeater",
                    "wizard_transmutation",
                    "wizard_watermage_greater",
                    "bubbles/acid/bubble_liquid",
                    "bubbles/ambrosia/bubble_liquid",
                    "bubbles/freezing_liquid/bubble_liquid",
                }
            
            elseif currentLevel == 5 then --Vault
            
                pool = {
                    "blindgazer",
                    "blob_big",
                    "blob_huge",
                    "cat_apotheosis_skateboard",
                    "devourer_ghost",
                    "devourer_magic",
                    "esoteric_being",
                    "fairy_cheap",
                    "secret/gazer_greater_cold",
                    "gazer_greater",
                    "ghost_bow",
                    "giant_centipede",
                    "hideous_mass_red",
                    "hisii_engineer",
                    "hisii_giga_bomb",
                    "hisii_rocketshotgun",
                    "locust_swarm",
                    "lukki_fungus",
                    "lukki_swarmling",
                    "vault/mimic_explosive_box",
                    "musical_being_weak",
                    "poring_magic",
                    "poring_lukki",
                    "rat_birthday",
                    "sentry",
                    "shaman_greater_apotheosis",
                    "star_child",
                    "tank_flame_apotheosis",
                    "tentacler_big",
                    "tesla_turret",
                    "triangle_gem",
                    "wizard_ambrosia",
                    "wizard_copeseethmald",
                    "wizard_duck",
                    "wizard_jackofalltrades",
                    "wizard_manaeater",
                    "wizard_transmutation",
                    "wizard_watermage_greater",
                    "wizard_z_poly_miniboss",
                    "wraith_weirdo_shield",
                    "bubbles/acid/bubble_liquid",
                    "bubbles/ambrosia/bubble_liquid",
                    "bubbles/freezing_liquid/bubble_liquid",
                }
            
            elseif currentLevel == 6 then --Temple of the Art
            
                pool = {
                    "blindgazer",
                    "blob_huge",
                    "c_basebot_speeder_apotheosis",
                    "cat_apotheosis_esoteric",
                    "devourer_magic",
                    "esoteric_being",
                    "fairy_esoteric",
                    "gazer_greater",
                    "ghost_bow",
                    "giant_centipede",
                    "hideous_mass_red",
                    "hideous_mass",
                    "hisii_engineer",
                    "hisii_giga_bomb",
                    "lukki_fungus",
                    "lukki_swarmling",
                    "vault/mimic_explosive_box",
                    "musical_being",
                    "musical_being_weak",
                    "poring_magic",
                    "poring_holy",
                    "rat_birthday",
                    "sentry",
                    "fungiforest/shaman_greater_apotheosis",
                    "star_child",
                    "tank_flame_apotheosis",
                    "vault/tentacler_big",
                    "triangle_gem",
                    "wizard_ambrosia",
                    "wizard_copeseethmald",
                    "wizard_duck",
                    "wizard_firemage_greater",
                    "wizard_jackofalltrades",
                    "wizard_manaeater",
                    "wizard_transmutation",
                    "wizard_watermage_greater",
                    "wizard_z_poly_miniboss",
                    "wraith_returner_apotheosis",
                    "wraith_weirdo_shield",
                    "bubbles/ambrosia/bubble_liquid",
                    "bubbles/freezing_liquid/bubble_liquid",
                }
            
            elseif currentLevel == 7 then --Heaven, Hell & Beyond
            
                pool = {
                    "the_end/blindgazer",
                    "c_basebot_speeder_apotheosis",
                    "cat_apotheosis_esoteric",
                    "the_end/devourer_magic",
                    "esoteric_being",
                    "fairy_esoteric",
                    "the_end/gazer_greater",
                    "the_end/gazer_greater_cold",
                    "the_end/gazer_greater_sky",
                    "the_end/ghost_bow",
                    "giant_centipede",
                    "hideous_mass_red",
                    "hideous_mass",
                    "lukki_fungus",
                    "the_end/musical_being",
                    "poring_devil",
                    "poring_holy",
                    "rat_birthday",
                    "the_end/sentry",
                    "fungiforest/shaman_greater_apotheosis",
                    "the_end/star_child",
                    "vault/tentacler_big",
                    "wizard_ambrosia",
                    "wizard_copeseethmald",
                    "the_end/wizard_firemage_greater",
                    "wizard_jackofalltrades",
                    "wizard_manaeater",
                    "wizard_transmutation",
                    "wizard_watermage_greater",
                    "the_end/wraith_returner_apotheosis",
                    "wraith_weirdo_shield",
                    "bubbles/ambrosia/bubble_liquid",
                    "bubbles/healthium/bubble_liquid",
                    "bubbles/healthium/bubble_liquid",
                    "boss_toxic_worm",
                }
            
            end

			local players = get_players()
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() + 353 )

            local catcount = 6
			
			for i,entity_id in ipairs( players ) do
                repeat
                    local x, y = EntityGetTransform( entity_id )
                    
                    local angle = Random( 0, 31415 ) * 0.0001
                    local length = 200
                    
                    local ex = x + math.cos( angle ) * length
                    local ey = y - math.sin( angle ) * length

                    EntityLoad( "data/entities/animals/"..pool[Random(1, #pool)]..".xml", ex, ey )
                    EntityLoad( "data/scripts/streaming_integration/entities/empty_circle.xml", ex, ey )

                    catcount = catcount - 1
            
                until (catcount < 1)
			end
		end,
	})


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_WAND_WONDERS",
		ui_name = "$integration_apotheosis_WAND_WONDERS_name",
		ui_description = "$integration_apotheosis_WAND_WONDERS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.8,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )

                EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml", x, y )
                EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_blue.xml", x, y)
                GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
			end
		end,
	})
    end


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_PANDORA_CHEST",
		ui_name = "$integration_apotheosis_PANDORA_CHEST_name",
		ui_description = "$integration_apotheosis_PANDORA_CHEST_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.75,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )

                EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_random_cursed.xml", x, y - 32 )
                GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
			end
		end,
	})
    end


    table.insert(streaming_events,
	{
		id = "apotheosis_RANDOM_CREEPS_BOSS",
		ui_name = "$integration_apotheosis_RANDOM_CREEPS_BOSS_name",
		ui_description = "$integration_apotheosis_RANDOM_CREEPS_BOSS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.1,
		kind = STREAMING_EVENT_AWFUL,
		delay_timer = 600,
		action_delayed = function(event)
            local pool

            if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then
                pool = {
                    "animals/gold_bosses/angel/angel",
                    "animals/gold_bosses/boss_blob/blob_titan",
                    "buildings/toxic_worm_nest_populator_big_detector",
                    "buildings/boss_musical_ghost_sandcave_populator_big_detector",
                    "animals/gold_bosses/boss_fire_lukki/boss_fire_lukki",
                }
            else
                pool = {
                    "animals/angel",
                    "animals/boss_blob/blob_titan",
                    "buildings/toxic_worm_nest_populator_big_detector",
                    "buildings/boss_musical_ghost_sandcave_populator_big_detector",
                    "animals/boss_fire_lukki/boss_fire_lukki",
                }
            end

			local players = get_players()
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() + 353 )
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )
                
                local angle = Random( 0, 31415 ) * 0.0001
                local length = 200
                
                local ex = x + math.cos( angle ) * length
                local ey = y - math.sin( angle ) * length

                local creep_id = EntityLoad( "data/entities/"..pool[Random(1, #pool)]..".xml", ex, ey )
                add_text_above_head( creep_id, StreamingGetRandomViewerName() )
                EntityLoad( "data/scripts/streaming_integration/entities/empty_circle.xml", ex, ey )
			end
		end,
	})


    table.insert(streaming_events,
	{
		id = "apotheosis_STONE_FUNGUS",
		ui_name = "$integration_apotheosis_STONE_FUNGUS_name",
		ui_description = "$integration_apotheosis_STONE_FUNGUS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.8,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )

                EntityLoad( "mods/Apotheosis/files/entities/items/pickups/stone_fungus.xml", x, y )
                EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_blue.xml", x, y)
                GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
			end
		end,
	})


    table.insert(streaming_events,
	{
		id = "apotheosis_CREATURE_SHIFT",
		ui_name = "$integration_apotheosis_CREATURE_SHIFT_name",
		ui_description = "$integration_apotheosis_CREATURE_SHIFT_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 1.0,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			dofile("mods/Apotheosis/files/scripts/magic/creature_shift_file.lua")
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				creature_shift( entity_id, x, y, true )
			end
		end,
	})


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_TRANSFORM_WORMS",
		ui_name = "$integration_apotheosis_TRANSFORM_WORMS_name",
		ui_description = "$integration_apotheosis_TRANSFORM_WORMS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.6,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 180,
		action_delayed = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/Apotheosis/files/scripts/streaming_integration/entities/effect_spells_to_worms.xml", x, y )
				set_lifetime( effect_id )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/Apotheosis/files/ui_gfx/status_indicators/worm.png", event )
			end
		end,
	})
    end

    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_MUD_MEN",
		ui_name = "$integration_apotheosis_MUD_MEN_name",
		ui_description = "$integration_apotheosis_MUD_MEN_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.75,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local players = get_players()
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() + 353 )

            local count = 10
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )
                repeat
                    
                    local angle = Random( 0, 31415 ) * 0.0001
                    local length = 45
                    
                    local ex = x + math.cos( angle ) * length
                    local ey = y - math.sin( angle ) * length

                    local creep_id = EntityLoad( "mods/Apotheosis/files/scripts/materials/mudman_spawner.xml", ex, ey )
                    add_text_above_head( creep_id, StreamingGetRandomViewerName() )

                    count = count - 1
        
                until (count < 1)
				local effect_id = EntityLoad( "mods/Apotheosis/files/scripts/streaming_integration/entities/effect_protection_all_mud.xml", x, y )
				--set_lifetime( effect_id, 0.75 )
				EntityAddChild( entity_id, effect_id )
			end
		end,
	})
    end

    --I don't wanna add events for vanilla stuff, I'll keep that to CTEP
    --[[
    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_SUMMON_SKOUDE",
		ui_name = "$integration_apotheosis_SUMMON_SKOUDE_name",
		ui_description = "$integration_apotheosis_SUMMON_SKOUDE_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.4,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )
                EntityLoad( "mods/Apotheosis/files/scripts/streaming_integration/entities/portal_skoude.xml", x, y - 16 )
			end
		end,
	})
    end
    ]]--


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_HUNGRY_ORB",
		ui_name = "$integration_apotheosis_HUNGRY_ORB_name",
		ui_description = "$integration_apotheosis_HUNGRY_ORB_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.05,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )

                EntityLoad( "mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml", x, y - 16 )
                GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
			end
		end,
	})
    end


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_DELUSIONAL",
		ui_name = "$integration_apotheosis_DELUSIONAL_name",
		ui_description = "$integration_apotheosis_DELUSIONAL_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.9,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )

                EntityLoad( "mods/Apotheosis/files/entities/projectiles/orb_psychotic_nodmg.xml", x, y )
                GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )
			end
		end,
	})
    end


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_CLOWNS",
		ui_name = "$integration_apotheosis_CLOWNS_name",
		ui_description = "$integration_apotheosis_CLOWNS_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.7,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local players = get_players()
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() + 353 )

            local catcount = 7
			
			for i,entity_id in ipairs( players ) do
                repeat
                    local x, y = EntityGetTransform( entity_id )
                    
                    local angle = Random( 0, 31415 ) * 0.0001
                    local length = 50
                    
                    local ex = x + math.cos( angle ) * length
                    local ey = y - math.sin( angle ) * length

                    local creep_id = EntityLoad( "data/entities/animals/seasonal/hisii_hobo.xml", ex, ey )
                    add_text_above_head( creep_id, StreamingGetRandomViewerName() )

                    catcount = catcount - 1
        
                until (catcount < 1)
			end
		end,
	})
    end


    if ModEnabledCTEP ~= true then
    table.insert(streaming_events,
	{
		id = "apotheosis_SWAPPER_CURSE",
		ui_name = "$integration_apotheosis_SWAPPER_CURSE_name",
		ui_description = "$integration_apotheosis_SWAPPER_CURSE_desc",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Conga Lyne - Mo Creeps",
		weight = 0.9,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
                local x, y = EntityGetTransform( entity_id )

                local cid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_plagiarize_swapper.xml", x, y )
                EntityAddChild( entity_id, cid )
                GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )
			end
		end,
	})
    end


if ModIsEnabled("twitch_extended") then
    enemies_list = {
        "data/entities/animals/blindgazer.xml",
        "data/entities/animals/blob_big.xml",
        "data/entities/animals/blob_huge.xml",
        "data/entities/animals/c_basebot_speeder_apotheosis.xml",
        "data/entities/animals/cat_apotheosis.xml",
        "data/entities/animals/ccc_bat_psychic.xml",
        "data/entities/animals/ceiling_fungus.xml",
        "data/entities/animals/devourer_ghost.xml",
        "data/entities/animals/devourer_magic.xml",
        "data/entities/animals/drone_mini.xml",
        "data/entities/animals/drone_status_ailment.xml",
        "data/entities/animals/enchanted_duck.xml",
        "data/entities/animals/fairy_cheap.xml",
        "data/entities/animals/fairy_big.xml",
        "data/entities/animals/fairy_big_discord.xml",
        "data/entities/animals/fairy_esoteric.xml",
        "data/entities/animals/forsaken_eye.xml",
        "data/entities/animals/gazer_greater.xml",
        "data/entities/animals/secret/gazer_greater_cold.xml",
        "data/entities/animals/gazer_greater_sky.xml",
        "data/entities/animals/gazer_robot.xml",
        "data/entities/animals/ghost_bow.xml",
        "data/entities/animals/giant_centipede.xml",
        "data/entities/animals/goo_slug.xml",
        "data/entities/animals/hideous_mass.xml",
        "data/entities/animals/hideous_mass_red.xml",
        "data/entities/animals/hisii_engineer.xml",
        "data/entities/animals/hisii_giga_bomb.xml",
        "data/entities/animals/hisii_hobo.xml",
        "data/entities/animals/hisii_minecart.xml",
        "data/entities/animals/hisii_rocketshotgun.xml",
        "data/entities/animals/locust_swarm.xml",
        "data/entities/animals/longleg_pillar.xml",
        "data/entities/animals/lukki_fungus.xml",
        "data/entities/animals/lukki_swarmling.xml",
        "data/entities/animals/mimic_explosive_box.xml",
        "data/entities/animals/musical_being.xml",
        "data/entities/animals/musical_being_weak.xml",
        "data/entities/animals/musical_being_weak_healer.xml",
        "data/entities/animals/poisonmushroom.xml",
        "data/entities/animals/poring.xml",
        "data/entities/animals/poring_devil.xml",
        "data/entities/animals/poring_holy.xml",
        "data/entities/animals/poring_lukki.xml",
        "data/entities/animals/poring_magic.xml",
        "data/entities/animals/rat_birthday.xml",
        "data/entities/animals/sentry.xml",
        "data/entities/animals/star_child.xml",
        "data/entities/animals/tank_flame_apotheosis.xml",
        "data/entities/animals/tentacler_big.xml",
        "data/entities/animals/tesla_turret.xml",
        "data/entities/animals/triangle_gem.xml",
        "data/entities/animals/whisp.xml",
        "data/entities/animals/wizard_ambrosia.xml",
        "data/entities/animals/wizard_copeseethmald.xml",
        "data/entities/animals/wizard_duck.xml",
        "data/entities/animals/wizard_explosive.xml",
        "data/entities/animals/wizard_firemage_greater.xml",
        "data/entities/animals/wizard_jackofalltrades.xml",
        "data/entities/animals/wizard_manaeater.xml",
        "data/entities/animals/wizard_transmutation.xml",
        "data/entities/animals/wizard_watermage_greater.xml",
        "data/entities/animals/wraith_returner_apotheosis",
        "data/entities/animals/wraith_weirdo_shield.xml",
        "data/entities/animals/bubbles/acid/bubble_liquid.xml",
        "data/entities/animals/bubbles/water/bubble_liquid.xml",
        "data/entities/animals/bubbles/ambrosia/bubble_liquid.xml",
        "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml",
        "data/entities/animals/boss_toxic_worm/boss_toxic_worm_minion.xml",
        "data/entities/animals/angel.xml",
        "data/entities/animals/boss_toxic_worm/boss_toxic_worm.xml",
        "data/entities/animals/boss_musical_ghost/boss_musical_ghost.xml",
        "data/entities/animals/boss_blob/blob_titan.xml",  -- apotheosis ENDS HERE ----------------------------------------------------------------------------------
        "data/entities/animals/acidshooter.xml",
        "data/entities/animals/acidshooter_weak.xml",
        "data/entities/animals/alchemist.xml",
        "data/entities/animals/ant.xml",
        "data/entities/animals/assassin.xml",
        "data/entities/animals/barfer.xml",
        "data/entities/animals/bat.xml",
        "data/entities/animals/bigbat.xml",
        "data/entities/animals/bigfirebug.xml",
        "data/entities/animals/bigzombie.xml",
        "data/entities/animals/bigzombiehead.xml",
        "data/entities/animals/bigzombietorso.xml",
        "data/entities/animals/blob.xml",
        "data/entities/animals/bloodcrystal_physics.xml",
        "data/entities/animals/bloom.xml",
        "data/entities/animals/boss_dragon.xml",
        "data/entities/animals/chest_leggy.xml",
        "data/entities/animals/chest_mimic.xml",
        "data/entities/animals/crystal_physics.xml",
        "data/entities/animals/deer.xml",
        "data/entities/animals/drone_lasership.xml",
        "data/entities/animals/drone_physics.xml",
        "data/entities/animals/duck.xml",
        "data/entities/animals/eel.xml",
        "data/entities/animals/elk.xml",
        "data/entities/animals/enlightened_alchemist.xml",
        "data/entities/animals/failed_alchemist.xml",
        "data/entities/animals/failed_alchemist_b.xml",
        "data/entities/animals/firebug.xml",
        "data/entities/animals/firemage.xml",
        "data/entities/animals/firemage_weak.xml",
        "data/entities/animals/fireskull.xml",
        "data/entities/animals/fireskull_weak.xml",
        "data/entities/animals/fish.xml",
        "data/entities/animals/fish_large.xml",
        "data/entities/animals/flamer.xml",
        "data/entities/animals/fly.xml",
        "data/entities/animals/frog.xml",
        "data/entities/animals/frog_big.xml",
        "data/entities/animals/fungus.xml",
        "data/entities/animals/fungus_big.xml",
        "data/entities/animals/gazer.xml",
        "data/entities/animals/ghost.xml",
        "data/entities/animals/ghoul.xml",
        "data/entities/animals/giant.xml",
        "data/entities/animals/giantshooter.xml",
        "data/entities/animals/giantshooter_weak.xml",
        "data/entities/animals/goblin_bomb.xml",
        "data/entities/animals/healerdrone_physics.xml",
        "data/entities/animals/icer.xml",
        "data/entities/animals/iceskull.xml",
        "data/entities/animals/lasershooter.xml",
        "data/entities/animals/longleg.xml",
        "data/entities/animals/lurker.xml",
        "data/entities/animals/maggot.xml",
        "data/entities/animals/mimic_physics.xml",
        "data/entities/animals/miner.xml",
        "data/entities/animals/miner_fire.xml",
        "data/entities/animals/miner_santa.xml",
        "data/entities/animals/miner_weak.xml",
        "data/entities/animals/miniblob.xml",
        "data/entities/animals/missilecrab.xml",
        "data/entities/animals/monk.xml",
        "data/entities/animals/pebble_physics.xml",
        "data/entities/animals/phantom_a.xml",
        "data/entities/animals/phantom_b.xml",
        "data/entities/animals/playerghost.xml",
        "data/entities/animals/rat.xml",
        "data/entities/animals/roboguard.xml",
        "data/entities/animals/scavenger_clusterbomb.xml",
        "data/entities/animals/scavenger_grenade.xml",
        "data/entities/animals/scavenger_heal.xml",
        "data/entities/animals/scavenger_invis.xml",
        "data/entities/animals/scavenger_leader.xml",
        "data/entities/animals/scavenger_mine.xml",
        "data/entities/animals/scavenger_poison.xml",
        "data/entities/animals/scavenger_shield.xml",
        "data/entities/animals/scavenger_smg.xml",
        "data/entities/animals/scorpion.xml",
        "data/entities/animals/shaman.xml",
        "data/entities/animals/sheep.xml",
        "data/entities/animals/sheep_bat.xml",
        "data/entities/animals/sheep_fly.xml",
        "data/entities/animals/shooterflower.xml",
        "data/entities/animals/shotgunner.xml",
        "data/entities/animals/shotgunner_weak.xml",
        "data/entities/animals/skullfly.xml",
        "data/entities/animals/skullrat.xml",
        "data/entities/animals/skycrystal_physics.xml",
        "data/entities/animals/slimeshooter.xml",
        "data/entities/animals/slimeshooter_nontoxic.xml",
        "data/entities/animals/slimeshooter_weak.xml",
        "data/entities/animals/sniper.xml",
        "data/entities/animals/spearbot.xml",
        "data/entities/animals/spitmonster.xml",
        "data/entities/animals/tank.xml",
        "data/entities/animals/tank_rocket.xml",
        "data/entities/animals/tank_super.xml",
        "data/entities/animals/tentacler.xml",
        "data/entities/animals/tentacler_small.xml",
        "data/entities/animals/thundermage.xml",
        "data/entities/animals/thunderskull.xml",
        "data/entities/animals/turret_left.xml",
        "data/entities/animals/turret_right.xml",
        "data/entities/animals/ultimate_killer.xml",
        "data/entities/animals/wand_ghost.xml",
        "data/entities/animals/wand_ghost_charmed.xml",
        "data/entities/animals/wizard_dark.xml",
        "data/entities/animals/wizard_neutral.xml",
        "data/entities/animals/wizard_poly.xml",
        "data/entities/animals/wizard_returner.xml",
        "data/entities/animals/wizard_tele.xml",
        "data/entities/animals/wolf.xml",
        "data/entities/animals/wraith.xml",
        "data/entities/animals/wraith_glowing.xml",
        "data/entities/animals/wraith_storm.xml",
        "data/entities/animals/zombie.xml",
        "data/entities/animals/zombie_weak.xml",
        "data/entities/animals/lukki/lukki.xml",
        "data/entities/animals/lukki/lukki_creepy.xml",
        "data/entities/animals/lukki/lukki_creepy_long.xml",
        "data/entities/animals/lukki/lukki_longleg.xml",
        "data/entities/animals/lukki/lukki_tiny.xml",
        "data/entities/animals/boss_centipede/boss_centipede.xml",
    }
end

