dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_success( pos_x, pos_y )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )


    if ModIsEnabled("copis_things") then
        opts = {"ROCKET_TIER_2", "GRENADE_TIER_2", "SPITTER_TIER_2", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "DISC_BULLET", "ROCKET", "GRENADE", "SWAPPER_PROJECTILE", "LIGHT", "BUCKSHOT", "SHIELD_FIELD", "SEA_LAVA", "FREEZE", "BALL_LIGHTNING", "AIR_BULLET", "CHAOS_POLYMORPH_FIELD", "LIFETIME", "LIFETIME_DOWN", "HEAVY_SPREAD", "TINY_GHOST", "DYNAMITE", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "BLOODLUST", "DELAYED_SPELL", "apotheosis_BOMB_GIGA", "COPIS_THINGS_SUMMON_HAMIS", "COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED", "COPIS_THINGS_UPGRADE_MANA_MAX", "COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT", "COPIS_THINGS_UPGRADE_RELOAD_TIME", "COPIS_THINGS_ARCANE_TURRET", "COPIS_THINGS_ANCHORED_SHOT", "COPIS_THINGS_LUNGE", "COPIS_THINGS_SLOW", "COPIS_THINGS_CONCRETEBALL", "COPIS_THINGS_SLOW_BULLET_TIMER_N", "COPIS_THINGS_AUTO_FRAME", "COPIS_THINGS_ZAP", "COPIS_THINGS_SCATTER_6", "COPIS_THINGS_CAUSTIC_CLAW", "COPIS_THINGS_LUMINOUS_BLADE", "COPIS_THINGS_ASTRAL_VORTEX", "COPIS_THINGS_LARPA_FORWARDS", "apotheosis_AQUA_MINE", "apotheosis_ALT_FIRE_TELEPORT_SHORT", "BURST_8"}
    elseif ModIsEnabled("variaAddons") then
        opts = {"ROCKET_TIER_2", "GRENADE_TIER_2", "SPITTER_TIER_2", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "DISC_BULLET", "ROCKET", "GRENADE", "SWAPPER_PROJECTILE", "LIGHT", "BUCKSHOT", "SHIELD_FIELD", "SEA_LAVA", "FREEZE", "BALL_LIGHTNING", "AIR_BULLET", "CHAOS_POLYMORPH_FIELD", "LIFETIME", "LIFETIME_DOWN", "HEAVY_SPREAD", "TINY_GHOST", "DYNAMITE", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "BLOODLUST", "DELAYED_SPELL", "apotheosis_BOMB_GIGA", "VARIA_SLASH", "VARIA_BULLET", "VARIA_BULLET_TRIGGER", "VARIA_SHOTGUN_SHELL", "VARIA_CRIT_ON_CHARM", "VARIA_GATLING_RAY_ENEMY", "VARIA_RE_ADDED_CHARM_FIELD", "VARIA_JUMPER_BLAST", "VARIA_LUKKI_BOMB", "VARIA_CRESCENT_WAVE_POISON", "VARIA_BLINK", "VARIA_BEES", "apotheosis_AQUA_MINE", "apotheosis_ALT_FIRE_TELEPORT_SHORT", "BURST_8"}
    else
        opts = {"ROCKET_TIER_2", "GRENADE_TIER_2", "SPITTER_TIER_2", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "DISC_BULLET", "ROCKET", "GRENADE", "SWAPPER_PROJECTILE", "LIGHT", "BUCKSHOT", "SHIELD_FIELD", "SEA_LAVA", "FREEZE", "BALL_LIGHTNING", "AIR_BULLET", "CHAOS_POLYMORPH_FIELD", "LIFETIME", "LIFETIME_DOWN", "HEAVY_SPREAD", "TINY_GHOST", "DYNAMITE", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "BLOODLUST", "DELAYED_SPELL", "apotheosis_BOMB_GIGA", "apotheosis_AQUA_MINE", "apotheosis_ALT_FIRE_TELEPORT_SHORT", "BURST_8"}
    end

    if HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki_spell" ) then
        table.insert(opts, "apotheosis_FIRE_CHARGE")
    end

    count = 3
	
	-- reward
	EntityLoad("data/entities/particles/image_emitters/magical_symbol_hobo_money.xml", x, y)
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)

    for i = 1, count do
        local rnd = Random(1, #opts)
        CreateItemActionEntity(opts[rnd], pos_x - 8 * count + (i - 0.5) * 16, pos_y)
        table.remove(opts, rnd)
    end
    
	local has_already_found_battery = GameHasFlagRun("apotheosis_temp_battery_donated")

    if (Random(1,10) == 10) and (has_already_found_battery == false) then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/mana_battery.xml", x, y - 16 )
        GameAddFlagRun( "apotheosis_temp_battery_donated" )
    end
    

    --GamePrint("Hobo Richified")

	-- cleanup
	EntityLoad("data/entities/animals/hisii_hobo_rich.xml", x, y)
    EntityKill(entity_id)
	
    if ModIsEnabled("raksa") == false then
	    AddFlagPersistent( "apotheosis_card_unlocked_donated_beggar" )

        if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
            AddFlagPersistent( "apotheosis_card_unlocked_donated_beggar_goldmode" )
        end
    end

    if (ModIsEnabled("nightmare") or ModIsEnabled("purgatory")) and HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar_goldmode") == false then
        EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_generous.xml", 4178, 2150 )
    elseif HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar" ) == false then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_generous.xml", 4178, 2150 )
    end

end

--Donate super rare liquid to a beggar, special big heart statue and better rewards?
--What liquid?
--Divine Liquid? (lol)