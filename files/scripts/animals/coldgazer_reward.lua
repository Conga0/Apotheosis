dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local pos_x,pos_y = EntityGetTransform(entity_id)

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

	-- Copi: 
	--  Removed spells from pool which have been disabled from copi's things for now. TODO: Revisit this file and remake the loot system possibly?

    if ModIsEnabled("copis_things") then
        opts = {"ICEBALL", "CIRCLE_WATER", "ACIDSHOT", "LANCE", "BUBBLESHOT", "ROCKET_TIER_3", "GRENADE_TIER_3", "SPITTER_TIER_3", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "ROCKET_TIER_2", "GRENADE_TIER_2", "SWAPPER_PROJECTILE", "BUCKSHOT", "SHIELD_FIELD", "FREEZE", "BALL_LIGHTNING", "CHAOS_POLYMORPH_FIELD", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "HOMING", "BLOODLUST", "MISSILE", "BULLET", "apotheosis_BOMB_GIGA", "apotheosis_AQUA_MINE", "apotheosis_ALT_FIRE_TELEPORT", "BURST_8", "COPITH_SUMMON_HAMIS", --[["COPITH_UPGRADE_MANA_CHARGE_SPEED", "COPITH_UPGRADE_MANA_MAX", "COPITH_UPGRADE_FIRE_RATE_WAIT", "COPITH_UPGRADE_RELOAD_TIME",]] "COPITH_ARCANE_TURRET", "COPITH_ANCHORED_SHOT", "COPITH_LUNGE", "COPITH_SLOW", "COPITH_CONCRETEBALL", "COPITH_SLOW_BULLET_TIMER_N", "COPITH_SCATTER_6", "COPITH_CAUSTIC_CLAW", "COPITH_LUMINOUS_BLADE", "COPITH_ASTRAL_VORTEX", "COPITH_LARPA_FORWARDS"}
    elseif ModIsEnabled("variaAddons") then
        opts = {"ICEBALL", "CIRCLE_WATER", "ACIDSHOT", "LANCE", "BUBBLESHOT", "ROCKET_TIER_3", "GRENADE_TIER_3", "SPITTER_TIER_3", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "ROCKET_TIER_2", "GRENADE_TIER_2", "SWAPPER_PROJECTILE", "BUCKSHOT", "SHIELD_FIELD", "FREEZE", "BALL_LIGHTNING", "CHAOS_POLYMORPH_FIELD", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "HOMING", "BLOODLUST", "MISSILE", "BULLET", "apotheosis_BOMB_GIGA", "apotheosis_AQUA_MINE", "apotheosis_ALT_FIRE_TELEPORT", "BURST_8", "VARIA_SLASH", "VARIA_BULLET", "VARIA_BULLET_TRIGGER", "VARIA_SHOTGUN_SHELL", "VARIA_RE_ADDED_CHARM_FIELD", "VARIA_JUMPER_BLAST", "VARIA_LUKKI_BOMB", "VARIA_CRESCENT_WAVE_POISON", "VARIA_BLINK", "VARIA_BEES"}
    else
        opts = {"ICEBALL", "CIRCLE_WATER", "ACIDSHOT", "LANCE", "BUBBLESHOT", "ROCKET_TIER_3", "GRENADE_TIER_3", "SPITTER_TIER_3", "SPITTER_TIER_3", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "ROCKET_TIER_2", "GRENADE_TIER_2", "SWAPPER_PROJECTILE", "BUCKSHOT", "SHIELD_FIELD", "FREEZE", "BALL_LIGHTNING", "CHAOS_POLYMORPH_FIELD", "BLOOD_MAGIC", "MANA_REDUCE", "CHAINSAW", "RECHARGE", "HOMING_SHOOTER", "HOMING", "BLOODLUST", "MISSILE", "BULLET", "apotheosis_BOMB_GIGA", "apotheosis_AQUA_MINE", "apotheosis_ALT_FIRE_TELEPORT", "BURST_8"}
    end

    count = 3

    for i = 1, count do
        local rnd = Random(1, #opts)
        CreateItemActionEntity(opts[rnd], pos_x - 8 * count + (i - 0.5) * 16, pos_y)
        table.remove(opts, rnd)
    end
end