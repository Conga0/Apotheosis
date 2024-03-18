dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/gun/gun_actions.lua" )

function make_random_card( x, y )
	-- this does NOT call SetRandomSeed() on purpouse. 
	-- SetRandomSeed( x, y )

	local item = ""
	local valid = false

	while ( valid == false ) do
		local itemno = math.random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then
				valid = true
			end

			-- 
			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end
			
		else
			valid = true
		end
	end


	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end


local pool = {
    "blindgazer",
    "blob_big",
    "blob_huge",
    "cat_apotheosis",
    "ccc_bat_psychic",
    "c_basebot_speeder_apotheosis",
    "hisii_giga_bomb",
    "devourer_ghost",
    "devourer_magic",
    "drone_mini",
    "fairy_big",
    "fairy_big_discord",
    "fairy_esoteric",
    "gazer_cold_apotheosis",
    "gazer_greater",
    "secret/gazer_greater_cold",
    "gazer_greater_sky",
    "gazer_robot",
    "ghost_bow",
    "giant_centipede",
    "goo_slug",
    "hideous_mass",
    "hideous_mass_red",
    "hisii_engineer",
    "hisii_hobo",
    "hisii_minecart",
    "hisii_minecart_tnt",
    "hisii_rocketshotgun",
    "locust_swarm",
    "longleg_pillar",
    "lukki_fungus",
    "mimic_explosive_box",
    "musical_being",
    "musical_being_weak",
    "musical_being_weak_healer",
    "poisonmushroom",
    "poring",
    "poring_holy",
    "poring_lukki",
    "poring_magic",
    "rat_birthday",
    "sentry",
    "shaman_greater_apotheosis",
    "star_child",
    "tank_flame_apotheosis",
    "tentacler_big",
    "tesla_turret",
    "triangle_gem",
    "whisp",
    "whisp_big",
    "wizard_ambrosia",
    "wizard_copeseethmald",
    "wizard_duck",
    "wizard_explosive",
    "wizard_firemage_greater",
    "wizard_jackofalltrades",
    "wizard_manaeater",
    "wizard_transmutation",
    "wizard_corrupt_wands",
    "watermage",
    "watermage_greater",
    "wizard_corrupt_wands",
    --"wizard_watermage_greater", --Early unused version of Greater Watermage who shoots out aquamines, visually it's a coloured Suur Stendari
    "wraith_returner_apotheosis",
    "wraith_weirdo_shield",
    "bubbles/acid/bubble_liquid",
    "bubbles/water/bubble_liquid",
    "bubbles/ambrosia/bubble_liquid",
    "bubbles/freezing_liquid/bubble_liquid",
    "boss_toxic_worm/boss_toxic_worm_minion",
    --End of apotheosis Monsters Here -- Vanilla Mobs Below--
    "alchemist",
    "assassin",
    "bigbat",
    "blob",
    "bloodcrystal_physics",
    "enlightened_alchemist",
    "flamer",
    "icer",
    "fungus_big",
    "fungus_giga",
    "necromancer",
    "skullfly",
    "spitmonster",
    "tank_rocket",
    "tank_super",
    "tentacler",
    "thundermage",
    "wizard_neutral",
    "wizard_dark",
    "wizard_returner",
    "spearbot",
    "worm",
    "worm_big",
    "basebot_hidden",
    "basebot_neutralizer",
    "basebot_sentry",
    "basebot_soldier",
}

-- A weighted table would be great here but when I tried to find a tutorial I found someone making his tutorial using black characters on a black background. I can't see any of that.
-- If you know how or know a decent tutorial, please let me know.
local prizePool = {
    "data/entities/items/pickup/potion_secret.xml", --1
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml",
    "data/entities/items/pickup/potion_random_material.xml", -- 8
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml",
    "data/entities/items/pickup/potion.xml", -- 15
    "data/entities/projectiles/rain_gold.xml",
    "data/entities/projectiles/rain_gold.xml", -- 2
}

function item_pickup( entity_item, entity_who_picked, name )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)
    local loot_level = 4
    local currbiome = BiomeMapGetName( x, y )
    currbiome = tostring(currbiome)
    local prefix = "$biome_"

    --[[
    elseif (currbiome == "rainforest") or (currbiome == "rainforest_open") or (currbiome == "rainforest_dark") or (currbiome == "fungicave") or (currbiome == "fungiforest") or (currbiome == "vault") then
        loot_level = 4
    ]]--

    if (currbiome == prefix .. "coalmine") or (currbiome == prefix .. "coalmine_alt") or (currbiome == prefix .. "forest") or (currbiome == prefix .. "excavationsite") then
        loot_level = 2
    elseif (currbiome == prefix .. "snowcave") or (currbiome == prefix .. "snowcastle") or (currbiome == prefix .. "desert") then
        loot_level = 3
    elseif (currbiome == prefix .. "crypt") or (currbiome == prefix .. "robobase") or (currbiome == prefix .. "wizardcave") or (currbiome == prefix .. "clouds") then
        loot_level = 5
    elseif (currbiome == prefix .. "boss_victoryroom") then
        loot_level = 8
    end

    --Make this based on x,y position? -Conga
    SetRandomSeed( GameGetFrameNum(), x, calcVar )
    local rnd = Random(1, #pool)

    local enemyCount = 25
    if pool[rnd] == "giant_centipede" then
        enemyCount = 8
    end
    local calcVar = 77

    repeat
        local x, y = EntityGetTransform( entity_id )
        
        local angle = Random( 0, 31415 ) * 0.0001
        local length = 200
        
        local ex = x + math.cos( angle ) * length
        local ey = y - math.sin( angle ) * length

        EntityLoad( "data/entities/animals/" .. pool[rnd] .. ".xml", ex, ey )
        --EntityLoad( "data/entities/particles/poof_red_sparse.xml", ex, ey )  Wasn't very noticable, may as well save performance
        EntityLoad( "data/scripts/streaming_integration/entities/empty_circle.xml", ex, ey )

        enemyCount = enemyCount - 1
        calcVar = calcVar * 1.57

    until (enemyCount < 1)


	-- Copi: 
	--  Removed spells from pool which have been disabled from copi's things for now. TODO: Revisit this file and remake the loot system possibly?


    -- reward

    if ModIsEnabled("copis_things") then
        prizeSpells = {"ROCKET_TIER_2", "GRENADE_TIER_2", "ROCKET_TIER_3", "GRENADE_TIER_3", "SPITTER_TIER_2", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "ROCKET", "GRENADE", "SWAPPER_PROJECTILE", "BUCKSHOT", "SHIELD_FIELD", "SEA_ACID", "FREEZE", "CHAOS_POLYMORPH_FIELD", "LIFETIME", "LIFETIME_DOWN", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "BLOODLUST", "APOTHEOSIS_BOMB_GIGA", "APOTHEOSIS_AQUA_MINE", "APOTHEOSIS_MASS_MATERIA_CONVERSION", "APOTHEOSIS_BUNGAL_SHIFT", "APOTHEOSIS_WATER_POWER", "COPITH_SUMMON_HAMIS", --[["COPITH_UPGRADE_MANA_CHARGE_SPEED", "COPITH_UPGRADE_MANA_MAX", "COPITH_UPGRADE_FIRE_RATE_WAIT", "COPITH_UPGRADE_RELOAD_TIME",]] "COPITH_ARCANE_TURRET", "COPITH_ANCHORED_SHOT", "COPITH_LUNGE", "COPITH_SLOW", "COPITH_CONCRETEBALL", "COPITH_SLOW_BULLET_TIMER_N", "COPITH_AUTO_FRAME", "COPITH_ZAP", "COPITH_SCATTER_6", "COPITH_CAUSTIC_CLAW", "COPITH_LUMINOUS_BLADE", "COPITH_ASTRAL_VORTEX", "COPITH_LARPA_FORWARDS", "COPITH_SEA_RANDOM", "COPITH_CIRCLE_RANDOM", "apotheosis_AQUA_MINE", }
    elseif ModIsEnabled("variaAddons") then
        prizeSpells = {"ROCKET_TIER_2", "GRENADE_TIER_2", "ROCKET_TIER_3", "GRENADE_TIER_3", "SPITTER_TIER_2", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "ROCKET", "GRENADE", "SWAPPER_PROJECTILE", "BUCKSHOT", "SHIELD_FIELD", "SEA_ACID", "FREEZE", "CHAOS_POLYMORPH_FIELD", "LIFETIME", "LIFETIME_DOWN", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "BLOODLUST", "APOTHEOSIS_BOMB_GIGA", "APOTHEOSIS_AQUA_MINE", "apotheosis_MASS_MATERIA_CONVERSION", "APOTHEOSIS_BUNGAL_SHIFT", "APOTHEOSIS_WATER_POWER", "VARIA_SLASH", "VARIA_BULLET", "VARIA_BULLET_TRIGGER", "VARIA_SHOTGUN_SHELL", "VARIA_CRIT_ON_CHARM", "VARIA_GATLING_RAY_ENEMY", "VARIA_RE_ADDED_CHARM_FIELD", "VARIA_JUMPER_BLAST", "VARIA_LUKKI_BOMB", "VARIA_CRESCENT_WAVE_POISON", "VARIA_BLINK", "VARIA_BEES", "apotheosis_AQUA_MINE", }
    else
        prizeSpells = {"ROCKET_TIER_2", "GRENADE_TIER_2", "ROCKET_TIER_3", "GRENADE_TIER_3", "SPITTER_TIER_2", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "ROCKET", "GRENADE", "SWAPPER_PROJECTILE", "BUCKSHOT", "SHIELD_FIELD", "SEA_ACID", "FREEZE", "CHAOS_POLYMORPH_FIELD", "LIFETIME", "LIFETIME_DOWN", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "BLOODLUST", "APOTHEOSIS_BOMB_GIGA", "APOTHEOSIS_AQUA_MINE", "APOTHEOSIS_MASS_MATERIA_CONVERSION", "APOTHEOSIS_BUNGAL_SHIFT", "APOTHEOSIS_WATER_POWER" }
    end

    local spellCount = 7

    for i = 1, spellCount do
        SetRandomSeed( GameGetFrameNum() + i, x, calcVar )
        local rnd = Random(1, #prizeSpells)
        if math.random(1,5) == 1 then
            make_random_card(x - 8 * spellCount + (i - 0.5) * 16, y)
        else
            CreateItemActionEntity(prizeSpells[rnd], x - 8 * spellCount + (i - 0.5) * 16, y)
        end
        table.remove(prizeSpells, rnd)

        if math.random(1,spellCount) == 1 then
            spellCount = spellCount + 1
        end
    end

    --[[
    --This spawns Cursed Orb Barrage is the divine being is defeated at a 50% chance, removed since it didn't feel.. right
	local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_divinebeing" )

    if flag_status then
        if Random(0,1) == 1 then
            CreateItemActionEntity("apotheosis_HOLYORB_SHOTGUN_CURSED", x , y - 8)
        end
    end
    --]]

    local rewardCount = 18
    local calcVar = 77
    EntityLoad( "data/entities/projectiles/rain_gold.xml", ex, ey )

    repeat
        local x, y = EntityGetTransform( entity_id )
        
        local angle = Random( 0, 31415 ) * 0.0001
        local length = 150
        
        local ex = x + math.cos( angle ) * length
        local ey = y - math.sin( angle ) * length
        local rnd = Random(1, #prizePool)

        EntityLoad( prizePool[rnd], ex, ey )
        EntityLoad( "data/scripts/streaming_integration/entities/empty_circle.xml", ex, ey )

        rewardCount = rewardCount - 1
        calcVar = calcVar * 1.57

    until (rewardCount < 1)

	EntityLoad("data/entities/particles/image_emitters/magical_symbol_fast.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/greed_curse/create", x, y)
    EntityLoad( "data/entities/items/pickup/heart.xml", x, y )
    EntityLoad( "data/entities/items/pickup/heart.xml", x, y )
    EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  x, y )
    EntityLoad( "data/entities/animals/worm_big.xml",  x + 100, y + 250 )

    --Deprecated code, Apotheosis should never be played alongside Purgatory or Nightmare
    if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then
        loot_level = loot_level + 2
        if loot_level >= 10 then
            EntityLoad( "data/entities/items/wand_unshuffle_10.xml", x, y - 16 )
        else
            EntityLoad( "data/entities/items/wand_unshuffle_0" .. loot_level .. ".xml", x, y - 16 )
        end
    else
        if loot_level >= 10 then
            EntityLoad( "data/entities/items/wand_unshuffle_10.xml", x, y - 16 )
        else
            EntityLoad( "data/entities/items/wand_unshuffle_0" .. loot_level .. ".xml", x, y - 16 )
        end
    end


    GameAddFlagRun( "apotheosis_pandora_unleashed" )
    --[[
    --Debugging Data
    GamePrint("Loot Level is " .. loot_level)
    GamePrint("Current biome name is `" .. currbiome .. "`")
    ]]--

    EntityKill( entity_item )

end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
end