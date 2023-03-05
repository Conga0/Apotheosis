local apotheosis_spellappends = {
    {
        id          = "APOTHEOSIS_SAWBLADE_BIG_RAY",
        name 		= "$spell_apotheosis_thrower_disc_name",
        description = "$spell_apotheosis_thrower_disc_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_disc_big_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_disc_big_ray.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 150,
        mana = 80,
        max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/thrower_disc_big_ray.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_CURSED_ORB_RAY",
        name 		= "$spell_apotheosis_thrower_cursed_orb_name",
        description = "$spell_apotheosis_thrower_cursed_orb_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_cursed_orb_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_cursed_orb_ray.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 150,
        mana = 110,
        max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/thrower_cursed_orb_ray.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_DYNAMITE_RAY",
        name 		= "$spell_apotheosis_thrower_tnt_name",
        description = "$spell_apotheosis_thrower_tnt_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_dynamite_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_dynamite_ray.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 150,
        mana = 110,
        max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/thrower_dynamite_ray.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_ICEBALL_RAY",
        name 		= "$spell_apotheosis_thrower_ice_ball_name",
        description = "$spell_apotheosis_thrower_ice_ball_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_ice_ball_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_ice_ball_ray.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 150,
        mana = 110,
        max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/thrower_ice_ball_ray.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_NUKE_RAY",
        name 		= "$spell_apotheosis_thrower_nuke_name",
        description = "$spell_apotheosis_thrower_nuke_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_nuke_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_nuke_ray.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "5,6,10", -- GRAVITY_FIELD_ENEMY
        spawn_probability                 = "0.1,0.2,1", -- GRAVITY_FIELD_ENEMY
        price = 400,
        mana = 250,
        max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/thrower_nuke_ray.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_SAWBLADE_BIG_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_disc_enemy_name",
        description = "$spell_apotheosis_thrower_disc_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_disc_big_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_disc_big_ray_enemy.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 100,
        mana = 70,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_disc_big_ray_enemy.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_CURSED_ORB_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_cursed_orb_enemy_name",
        description = "$spell_apotheosis_thrower_cursed_orb_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_cursed_orb_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_cursed_orb_ray_enemy.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 100,
        mana = 90,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_cursed_orb_ray_enemy.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_DYNAMITE_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_tnt_enemy_name",
        description = "$spell_apotheosis_thrower_tnt_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_dynamite_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_dynamite_ray_enemy.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 100,
        mana = 90,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_dynamite_ray_enemy.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_ICEBALL_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_ice_ball_enemy_name",
        description = "$spell_apotheosis_thrower_ice_ball_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_ice_ball_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_ice_ball_ray_enemy.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 100,
        mana = 90,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_ice_ball_ray_enemy.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_NUKE_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_nuke_enemy_name",
        description = "$spell_apotheosis_thrower_nuke_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_nuke_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_nuke_ray_enemy.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,5,6", -- FIREBALL_RAY_LINE
        spawn_probability                 = "0.6,0.4,0.4,0.4,1", -- FIREBALL_RAY_LINE
        price = 100,
        mana = 250,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_nuke_ray_enemy.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_HOLYORB_SHOTGUN",
        name 		= "$spell_apotheosis_holy_orb_barrage_name",
        description = "$spell_apotheosis_holy_orb_barrage_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/orb_holy_shotgun.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml", 7},
        spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "2,3,4,5,6", -- BUCKSHOT  Originally this was 1-5 but was changed because the spell feels too good to get early on, might revert, unsure
        --spawn_probability                 = "0.7,0.9,1,0.8,0.6", -- Original Rates
        spawn_probability                 = "0.7,0.7,0.8,0.8,0.6", -- BUCKSHOT
        price = 220,
        mana = 50,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml")
            c.fire_rate_wait = c.fire_rate_wait + 12
            c.spread_degrees = c.spread_degrees + 30.0
        end,
    },
    {
        id          = "APOTHEOSIS_BOMB_GIGA",
        name 		= "$spell_apotheosis_giga_bomb_name",
        description = "$spell_apotheosis_giga_bomb_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/bomb_giga.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/bomb_giga.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "1,2,3,4,5,6,10", -- BOMB
        spawn_probability                 = "0.7,0.8,1,1,1,1,0.7", -- BOMB
        price = 300,
        mana = 50, 
        max_uses    = 3, 
        custom_xml_file = "mods/apotheosis/files/entities/misc/custom_cards/bomb_giga.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/bomb_giga.xml")
            c.fire_rate_wait = c.fire_rate_wait + 140
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_MATERIA_CONVERSION",
        name 		= "$spell_apotheosis_mass_materia_conversion_name",
        description = "$spell_apotheosis_mass_materia_conversion_desc", --Be Careful what you wish for.. Convert a large amount of materials in a radius to various counterparts
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_materia_conversion.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "data/entities/misc/mass_materia_conversion.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_boss_toxic_worm_spell",
        type 		= ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "2,3,6,7,10", -- LAVA_TO_BLOOD
        spawn_probability                 = "0.1,0.1,0.3,0.5,1", -- LAVA_TO_BLOOD
        price = 250,
        mana = 200,
        max_uses = 3,
        action 		= function()
            add_projectile("data/entities/misc/mass_materia_conversion.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            current_reload_time = current_reload_time + 30
        end,
    },
    {
        id          = "APOTHEOSIS_BUNGAL_SHIFT",
        name 		= "$spell_apotheosis_bungal_shift_name",
        description = "$spell_apotheosis_bungal_shift_desc", --Be Careful what you wish for.. Triggers a fungal shift, still obeys normal fungal cooldown
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/bungal_shift.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "data/entities/misc/forced_bungal_shift.xml" },
        type 		= ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "2,3,6,7,10", -- LAVA_TO_BLOOD
        spawn_probability                 = "0.1,0.1,0.3,0.5,1", -- LAVA_TO_BLOOD
        price = 250,
        mana = 200,
        max_uses = 3,
        action 		= function()
            add_projectile("data/entities/misc/forced_bungal_shift.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            current_reload_time = current_reload_time + 30
        end,
    },
    {
        id          = "APOTHEOSIS_AQUA_MINE",
        name 		= "$spell_apotheosis_aqua_mine_name",
        description = "$spell_apotheosis_aqua_mine_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/aquamine.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/aquamine.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level	           = "1,3,4,6", -- MINE
        spawn_probability	   = "1,1,1,1", -- MINE
        price = 220,
        mana = 50,
        max_uses = 20,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/aquamine.xml")
            c.fire_rate_wait = c.fire_rate_wait + 12
        end,
    },
    {
        id          = "APOTHEOSIS_MUSICAL_STRIKE",
        name 		= "$spell_apotheosis_musical_proj_name",
        description = "$spell_apotheosis_musical_proj_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/musical_strike.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/musical_delayed_attack_end.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_musical_boss_spell",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "1,2,3,4,5", -- MUSICALSTRIKE
        spawn_probability                 = "0.8,0.8,0.6,0.6,0.5", -- MUSICALSTRIKE
        price = 220,
        mana = 40, 
        max_uses = 30,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/musical_delayed_attack_end.xml")
        end,
    },
    {
        id          = "APOTHEOSIS_MUSICAL_STRIKE_TRIGGER",
        name 		= "$spell_apotheosis_musical_proj_trig_name",
        description = "$spell_apotheosis_musical_proj_trig_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/musical_strike_trigger.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/musical_delayed_attack_end.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_musical_boss_spell",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "1,2,3,4,5,10", -- MUSICALSTRIKE
        spawn_probability                 = "0.5,0.5,0.5,0.5,0.4,0.1", -- MUSICALSTRIKE
        price = 220,
        mana = 60, 
        max_uses = 30,
        action 		= function()
            add_projectile_trigger_hit_world("mods/Apotheosis/files/entities/projectiles/deck/musical_delayed_attack_end.xml", 1)
        end,
    },
    {
        id          = "APOTHEOSIS_REVERBERATION",
        name 		= "$spell_apotheosis_reverberation_name",
        description = "$spell_apotheosis_reverberation_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/reverberation.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/field_reverberation_visual.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_musical_boss_spell",
        type 		= ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "0,1,2,3,4,5,6", -- FREEZE_FIELD
        spawn_probability                 = "0.3,0.6,0.6,0.7,0.7,0.3,0.2", -- FREEZE_FIELD
        price = 200,
        mana = 50, 
        max_uses = 20,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/field_reverberation.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
    },
    {
        id          = "APOTHEOSIS_RAT_BITE",
        name 		= "$spell_apotheosis_bite_name",
        description = "$spell_apotheosis_bite_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/rat_bite.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/rat_bite.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_rat_bite",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "0,1,2", -- LUMINOUS_DRILL
        spawn_probability                 = "0.5,0.5,0.25", -- LUMINOUS_DRILL
        price = 150,
        mana = 20,
        --max_uses = 1000,
        action 		= function()
            --if reflecting then
            --	c.damage_melee_add = c.damage_melee_add + 1.0
            --else
                add_projectile("mods/Apotheosis/files/entities/projectiles/deck/rat_bite.xml")
                c.damage_critical_chance = c.damage_critical_chance + 10
            --end
            --It says "+25 melee damage" instead of "25 melee damage"... hmm.. not satisfactory
        end,
    },
    {
        id          = "APOTHEOSIS_BUNGAL_SHIFT_SPAM",
        name 		= "$spell_apotheosis_bungal_shift_hyper_name",
        description = "$spell_apotheosis_bungal_shift_hyper_desc", --Triggers a fungal shift, no cooldown.
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/bungal_shift_spam.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "data/entities/misc/forced_bungal_shift_spam.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_boss_toxic_worm_spell",
        type 		= ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "10", -- Conversion spell
        spawn_probability                 = "0.01", -- Conversion spell
        price = 250,
        mana = 200,
        max_uses = 3,
        action 		= function()
            add_projectile("data/entities/misc/forced_bungal_shift_spam.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            current_reload_time = current_reload_time + 30
        end,
    },
    {
        id          = "APOTHEOSIS_RAT_BITE_CRIT",
        name 		= "$spell_apotheosis_bite_crit_name",
        description = "$spell_apotheosis_bite_crit_desc", --Converted Rat Bite, Big Crit chance.
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/rat_bite_crit.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/rat_bite_crit.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_boss_toxic_worm_spell",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "10", -- Conversion spell
        spawn_probability                 = "0.01", -- Conversion spell
        price = 250,
        mana = 80,
        --max_uses = 1000,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/rat_bite_crit.xml")
            c.damage_critical_chance = c.damage_critical_chance + 50
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_BURROW",
        name 		= "$spell_apotheosis_mass_burrow_name",
        description = "$spell_apotheosis_mass_burrow_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_burrow.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"data/entities/projectiles/remove_ground.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_boss_toxic_worm_spell",
        never_unlimited		= true,
        type 		= ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level                       = "10", -- Conversion spell
        spawn_probability                 = "0.01", -- Conversion spell
        price = 300,
        max_uses    = 2, 
        mana = 225, 
        action 		= function()
            add_projectile("data/entities/projectiles/remove_ground.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_DRY",
        name 		= "$spell_apotheosis_status_dry_name",
        description = "$spell_apotheosis_status_dry_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_dry.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_dry.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        never_unlimited		= true,
        type 		= ACTION_TYPE_UTILITY,
        spawn_level                       = "10", -- Conversion spell
        spawn_probability                 = "0.01", -- Conversion spell
        price = 180,
        max_uses    = 20,
        mana = 100,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_dry.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 1800
        end,
    },
    {
        id          = "APOTHEOSIS_SPELLS_TO_CATS",
        name 		= "$spell_apotheosis_spells_to_sorako_name",
        description = "$spell_apotheosis_spells_to_sorako_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/spells_to_cats.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/spells_to_cats.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_cat_secret_spell",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "3,6,10", -- spells to Cats
        spawn_probability                 = "0.1,0.05,1", -- spells to Cats
        price = 600,
        mana = 200,
        --max_uses = 1000,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/spells_to_cats.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 100
        end,
    },
    {
        id                = "APOTHEOSIS_SPLIT_SPELL",
        name              = "$spell_apotheosis_split_shot_name",
        description       = "$spell_apotheosis_split_shot_desc",
        sprite            = "mods/Apotheosis/files/ui_gfx/gun_actions/split_spell.png",
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,2,3,5,6,10", -- Omega
        spawn_probability                 = "0.1,0.05,0.1,0.2,0.2,0.8", -- Omega
        price             = 200,
        mana              = 20,
        action            = function()
            -- this always runs, so just leave it up here
            draw_actions( 1, true )
            if reflecting then
                -- force spell tooltip to show stat change without always applying it
                -- I don't want it to though, because it only does the degree increase if it makes a split
                --c.spread_degrees = c.spread_degrees + 10.0  
            else
                -- this is run *after* reflection
                local iter = 1
                local iter = tonumber(GlobalsGetValue("APOTHEOSIS_global_splitseed", "0"))
                if iter == 0 then
                    SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() - 523 )
                    GlobalsSetValue("APOTHEOSIS_global_splitseed", "1")
                end
                local rnd_num = Random( 1, 2 )
                if ( hand ~= nil ) and ( rnd_num == 1 ) then
                    for i,data in ipairs( hand ) do
                        if ( data.type ~= ACTION_TYPE_OTHER and data.type ~= ACTION_TYPE_MODIFIER ) then
                            data.action()
                        end
                    end
                    c.spread_degrees = c.spread_degrees + 10.0  
                end
            end
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_STATUS_DRUNK",
        name 		= "$spell_apotheosis_status_drunk_name",
        description = "$spell_apotheosis_status_drunk_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_alcohol.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_drunk.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.8,1,1,0.8,0.6,0.4,0.2", -- X_RAY
        price = 180,
        max_uses    = 20,
        mana = 100,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_drunk.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_STATUS_WET",
        name 		= "$spell_apotheosis_status_wet_name",
        description = "$spell_apotheosis_status_wet_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_wet.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_wet.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.8,1,1,0.8,0.6,0.4,0.2", -- X_RAY
        price = 180,
        max_uses    = 20,
        mana = 100,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_wet.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_STATUS_FIRE",
        name 		= "$spell_apotheosis_status_fire_name",
        description = "$spell_apotheosis_status_fire_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_fire.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_fire.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.8,1,1,0.8,0.6,0.4,0.2", -- X_RAY
        price = 180,
        max_uses    = 20,
        mana = 100,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_fire.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_STATUS_URINE",
        name 		= "$spell_apotheosis_status_urine_name",
        description = "$spell_apotheosis_status_urine_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_urine.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_urine.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.8,0.8,0.8,0.8,0.6,0.4,0.2", -- X_RAY
        price = 180,
        max_uses    = 20,
        mana = 100,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_urine.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_STATUS_POLYMORPH",
        name 		= "$spell_apotheosis_status_polymorph_name",
        description = "$spell_apotheosis_status_polymorph_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_polymorph.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_UTILITY,
        spawn_level       = "2,3,4,5,6", -- X_RAY
        spawn_probability = "0.6,0.6,0.5,0.4,0.2", -- X_RAY
        price = 240,
        max_uses    = 20,
        mana = 120,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_TARGETTER",
        name 		= "$spell_apotheosis_targetter_name",
        description = "$spell_apotheosis_targetter_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/targetter.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/heavy_bullet_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/targetter.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "1,2,3,4,5,6", -- HEAVY_BULLET
        spawn_probability                 = "0.5,1,1,1,1,1", -- HEAVY_BULLET
        price = 200,
        mana = 40,
        max_uses = 8,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/targetter.xml")
            c.fire_rate_wait = c.fire_rate_wait + 30
            --current_reload_time = current_reload_time + 15
        end,
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_TELEPORT",
        name 		= "$spell_apotheosis_alt_fire_teleport_name",
        description = "$spell_apotheosis_alt_fire_teleport_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_teleport_projectile.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "0,1,2,4,5,6,10", -- TELEPORT_PROJECTILE
        spawn_probability                 = "0.45,0.45,0.45,0.3,0.3,0.3,0.8", -- TELEPORT_PROJECTILE
        price = 130,
        mana = 0,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_teleport.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
        end,
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT",
        name 		= "$spell_apotheosis_alt_fire_teleport_short_name",
        description = "$spell_apotheosis_alt_fire_teleport_short_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_teleport_projectile_short.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "0,1,2,4,5,6,10", -- TELEPORT_PROJECTILE
        spawn_probability                 = "0.45,0.45,0.45,0.3,0.3,0.3,0.8", -- TELEPORT_PROJECTILE
        price = 130,
        mana = 0,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_teleport_short.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
        end,
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_SWAPPER",
        name 		= "$spell_apotheosis_alt_fire_swapper_name",
        description = "$spell_apotheosis_alt_fire_swapper_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_swapper_projectile.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "0,1,2,4,5,6,10", -- TELEPORT_PROJECTILE
        spawn_probability                 = "0.2,0.2,0.2,0.1,0.1,0.1,0.05", -- TELEPORT_PROJECTILE
        price = 130,
        mana = 0,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_swapper.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
        end,
    },

    --Wait.. is burning trail literally just fire charge but not called fire charge..? Keep your naming consistency together Noita please
    --I do want a spell which lets me do fire damage though.. so...
    {
        id          = "APOTHEOSIS_FIRE_CHARGE",
        name 		= "$spell_apotheosis_firecharge_name",
        description = "$spell_apotheosis_firecharge_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/fire_charge.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/heavy_bullet_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,2,4,5", -- ELECTRIC_CHARGE
        spawn_probability                 = "1,1,1,1", -- ELECTRIC_CHARGE
        price = 150,
        mana = 8,
        --max_uses = 8,
        custom_xml_file = "data/entities/misc/custom_cards/torch.xml",
        action 		= function()
            c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_on_fire.xml,"
            c.damage_fire_add = c.damage_fire_add + 0.12
            c.extra_entities = c.extra_entities .. "data/entities/misc/burn.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_PORTAL_LUKKI_RED_PORTAL",
        name 		= "$spell_apotheosis_portal_lukki_red_portal_name",
        description = "$spell_apotheosis_portal_lukki_red_portal_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/portal_red_portal.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        spawn_manual_unlock = true,
        never_unlimited		= false,
        type 		= ACTION_TYPE_OTHER,
        recursive	= true,
        ai_never_uses = true,
        spawn_level                       = "10", -- MANA_REDUCE
        spawn_probability                 = "0", -- MANA_REDUCE
        price = 4300,
        mana = 300,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/portal_red_marker.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_red_portal.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 100
        end,
    },
    {
        id          = "APOTHEOSIS_PORTAL_LUKKI_BLUE_PORTAL",
        name 		= "$spell_apotheosis_portal_lukki_blue_portal_name",
        description = "$spell_apotheosis_portal_lukki_blue_portal_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/portal_blue_portal.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        spawn_manual_unlock = true,
        never_unlimited		= false,
        type 		= ACTION_TYPE_OTHER,
        recursive	= true,
        ai_never_uses = true,
        spawn_level                       = "10", -- MANA_REDUCE
        spawn_probability                 = "0", -- MANA_REDUCE
        price = 4300,
        mana = 300,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/portal_blue_marker.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_blue_portal.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 100
        end,
    },
    {
        id          = "APOTHEOSIS_PORTAL_LUKKI_GREEN_PORTAL",
        name 		= "$spell_apotheosis_portal_lukki_green_portal_name",
        description = "$spell_apotheosis_portal_lukki_green_portal_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/portal_green_portal.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        spawn_manual_unlock = true,
        never_unlimited		= false,
        type 		= ACTION_TYPE_OTHER,
        recursive	= true,
        ai_never_uses = true,
        spawn_level                       = "10", -- MANA_REDUCE
        spawn_probability                 = "0", -- MANA_REDUCE
        price = 4300,
        mana = 300,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/portal_green_marker.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_green_portal.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 100
        end,
    },
    {
        id          = "APOTHEOSIS_KNOWLEDGE_OF_KINGS",
        name 		= "$spell_apotheosis_knowledge_of_kings_name",
        description = "$spell_apotheosis_knowledge_of_kings_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/knowledge_of_kings.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_secret_knowledge_of_kings_spell",
        spawn_manual_unlock = true,
        never_unlimited		= true,
        type 		= ACTION_TYPE_OTHER,
        recursive	= true,
        ai_never_uses = true,
        spawn_level                       = "10", -- MANA_REDUCE
        spawn_probability                 = "0.0001", -- MANA_REDUCE
        price = 2000,
        mana = 600,
        max_uses    = 1,
        action 		= function()
            local players = EntityGetWithTag( "player_unit" )
            for i,v in ipairs( players ) do
                local x,y = EntityGetTransform( v )
                local eid = EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/knowledge_of_kings_proj_check.xml", x, y)
            end
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 100
        end,
    },



    -------------------------------------------- Apotheosis New Content Below ------------------------------------------------------------------------------


    {
        id          = "APOTHEOSIS_SPELLS_TO_CURSOR",
        name 		= "$spell_apotheosis_spells_to_cursor_name",
        description = "$spell_apotheosis_spells_to_cursor_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/spells_to_cursor.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/spells_to_cursor.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_orb_12_spell",  --Temple of Sacriligious Remains
        type 		= ACTION_TYPE_UTILITY,
        spawn_level                       = "3,4,6,9", -- spells to Cats
        spawn_probability                 = "0.4,0.4,0.4,0.5", -- spells to Cats
        price = 600,
        mana = 220,
        --max_uses = 1000,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/spells_to_cursor.xml")
            c.fire_rate_wait = c.fire_rate_wait + 20
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_STATUS_POLYMORPH_INTENSE",
        name 		= "$spell_apotheosis_status_polymorph_intense_name",
        description = "$spell_apotheosis_status_polymorph_intense_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_intense_polymorph.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph_intense.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_UTILITY,
        spawn_level                       = "10", -- Conversion spell
        spawn_probability                 = "0.01", -- Conversion spell
        price = 240,
        max_uses    = 20,
        mana = 120,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph_intense.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_AUTOFIRE",
        name 		= "$spell_apotheosis_autofire_name",
        description = "$spell_apotheosis_autofire_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/autofire.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "2,3,4,5,6", -- AUTOAIM
        spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- AUTOAIM
        price = 130,
        mana = 0,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/autofire.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
        end,
    },
    {
        id          = "APOTHEOSIS_UPGRADE_ALWAYSCAST",
        name 		= "$spell_apotheosis_upgrade_alwayscast_name",
        description = "$spell_apotheosis_upgrade_alwayscast_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/upgrade_alwayscast.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_UTILITY,
        spawn_level = "0",
        spawn_probability = "0",
        price = 200,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            if reflecting then
                return
            end
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)

            if (recursion_level or iteration) ~= nil or (current_action.id ~= "APOTHEOSIS_UPGRADE_ALWAYSCAST") then
                GameScreenshake(50, pos_x, pos_y)
                GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y )
                GamePrintImportant("$log_apotheosis_upgrade_alwayscast_cheater_name", "")
                return
            end
            draw_actions(1, true)
            local EZWand = dofile_once("mods/Apotheosis/lib/EZWand/EZWand.lua")
            local entity_id = GetUpdatedEntityID()
            local inventory = EntityGetFirstComponent( entity_id, "Inventory2Component" )
            local active_wand = ComponentGetValue2( inventory, "mActiveItem" )
            local wand = EZWand(active_wand)

            if wand ~= nil then
                local spells = wand:GetSpells()


                if #spells >= 1 then
                    if (spells[1].action_id) == "APOTHEOSIS_UPGRADE_ALWAYSCAST" then
                        GameScreenshake(50, pos_x, pos_y)
                        GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y )
                        GamePrintImportant("$log_apotheosis_upgrade_alwayscast_cheater_name", "")
                        --GamePrint("First Slot is found to be an always cast upgrade!!")
                    else
                        --AddGunAction( wand, gun_action )
                        wand:RemoveSpells("APOTHEOSIS_UPGRADE_ALWAYSCAST")
                        wand:RemoveSpells(spells[1].action_id)
                        wand:AttachSpells(spells[1].action_id)
                        GameScreenshake(50, pos_x, pos_y)
                        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/wand/create", pos_x, pos_y )
                        GamePrintImportant("$log_apotheosis_upgrade_alwayscast_success_name", "$log_apotheosis_upgrade_alwayscast_success_desc")
                    end
                end
            end
        end
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_COV",
        name 		= "$spell_apotheosis_alt_fire_cov_name",
        description = "$spell_apotheosis_alt_fire_cov_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_cov_projectile.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "1,2,3,4,10", -- REGENERATION_FIELD
        spawn_probability                 = "0.2,0.2,0.2,0.2,0.7", -- REGENERATION_FIELD
        price = 250,
        mana = 0,
        max_uses = 2,
        never_unlimited = true,
        custom_uses_logic = true,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_cov.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
        end,
    },

    --Not sure how to implement
    --[[
    {
        id          = "APOTHEOSIS_ALT_FIRE_ALPHA",
        name 		= "$spell_apotheosis_alt_fire_alpha_name",
        description = "$spell_apotheosis_alt_fire_alpha_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_alpha.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_duplicate",
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "5,6,10", -- MANA_REDUCE
        spawn_probability                 = "0.1,0.1,1", -- MANA_REDUCE
        price = 200,
        mana = 0,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_alpha.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
        end,
    }
    ]]--

    --Ideally 2 more alt-fire spells here so all alt-fire spells are grouped together ideally


    {
        id          = "APOTHEOSIS_HITFX_CRITICAL_DRUNK",
        name 		= "$spell_apotheosis_critical_drunk_name",
        description = "$spell_apotheosis_critical_drunk_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/critical_drunk.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_critical_drunk.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability                 = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price = 70,
        mana = 10,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_critical_drunk.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_AFFLUENCE",
        name 		= "$spell_apotheosis_affluence_name",
        description = "$spell_apotheosis_affluence_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/affluence.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_affluence.xml" },
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "2,3,4,6", -- APOTHEOSIS_HITFX_AFFLUENCE
        spawn_probability                 = "1.0,0.8,0.5,0.2", -- APOTHEOSIS_HITFX_AFFLUENCE
        price = 300,
        mana = 20,
        --max_uses = 20,
        --This used to have 20 max charges as a way to limit the amount of extra gold you gain, as well as encourage players to avoid spambuilds, but I think this spell ultimately plays better with unlimited charges
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_affluence.xml,mods/apotheosis/files/entities/particles/tinyspark_gold.xml,"
            draw_actions( 1, true )
        end,
    },

    --[[
    --Note: Missing Sprites
    {
        id          = "APOTHEOSIS_LIQUIDSPHERE_ACID",
        name 		= "$spell_apotheosis_liquidsphere_acid_name",
        description = "$spell_apotheosis_liquidsphere_acid_desc",
        sprite 		= "data/ui_gfx/gun_actions/black_hole.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/black_hole_unidentified.png",
        related_projectiles	= {"data/entities/projectiles/deck/black_hole.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "0,2,4,5", -- BLACK_HOLE
        spawn_probability                 = "0.8,0.8,0.8,0.8", -- BLACK_HOLE
        price = 200,
        mana = 180,
        max_uses    = 3, 
        never_unlimited = true,
        custom_xml_file = "data/entities/misc/custom_cards/black_hole.xml",
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/liquidsphere_acid.xml")
            c.fire_rate_wait = c.fire_rate_wait + 80
            c.screenshake = c.screenshake + 20
        end,
    },
    ]]--


    {
        id          = "APOTHEOSIS_STAR_SHOT",
        name 		= "$spell_apotheosis_star_shot_name",
        description = "$spell_apotheosis_star_shot_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/star_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/star_shot.xml", 2},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "2,3,4,5,6", -- BUCKSHOT
        spawn_probability                 = "0.7,0.7,0.8,0.8,0.6", -- BUCKSHOT
        price = 140,
        mana = 30,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/star_shot.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/star_shot.xml")
            c.fire_rate_wait = c.fire_rate_wait + 16
            c.spread_degrees = c.spread_degrees + 25.0
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_HEX_WATER",
        name 		= "$spell_apotheosis_hex_water_name",
        description = "$spell_apotheosis_hex_water_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/hex_water.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_hex_water.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_14_spell",  --Sunken Cavern
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.8,1,1,0.8,0.6,0.4,0.2", -- X_RAY
        price = 40,
        mana = 30,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_hex_water.xml,mods/apotheosis/files/entities/particles/tinyspark_water.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_HEX_OIL",
        name 		= "$spell_apotheosis_hex_oil_name",
        description = "$spell_apotheosis_hex_oil_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/hex_oil.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_hex_oil.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_14_spell",  --Sunken Cavern
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.5,1.0,0.6,0.4,0.3,0.4", -- X_RAY
        price = 40,
        mana = 30,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_hex_oil.xml,mods/apotheosis/files/entities/particles/tinyspark_oil.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_HEX_BLOOD",
        name 		= "$spell_apotheosis_hex_blood_name",
        description = "$spell_apotheosis_hex_blood_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/hex_blood.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_hex_blood.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_14_spell",  --Sunken Cavern
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.5,1.0,0.6,0.4,0.3,0.4", -- X_RAY
        price = 40,
        mana = 30,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_hex_blood.xml,mods/apotheosis/files/entities/particles/tinyspark_blood.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_MIST_ATTUNIUM",
        name 		= "$spell_apotheosis_mist_attunium_name",
        description = "$spell_apotheosis_mist_attunium_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mist_attunium.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slimeball_unidentified.png",
        related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/mist_attunium.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "1,2,3,4", -- APOTHEOSIS_MIST_ATTUNIUM
        spawn_probability                 = "0.3,0.3,0.3,0.3", -- APOTHEOSIS_MIST_ATTUNIUM
        price = 120,
        mana = 120,
        --max_uses = 10,
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/mist_attunium.xml")
            c.fire_rate_wait = c.fire_rate_wait + 10
        end,
    },
    {
        id          = "APOTHEOSIS_HOMING_DELAYED",
        name 		= "$spell_apotheosis_homing_delayed_name",
        description = "$spell_apotheosis_homing_delayed_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/homing_delayed.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/proj_homing_delayed.xml" },
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,2,3,4,5,6", -- HOMING
        spawn_probability                 = "0.1,0.4,0.4,0.4,0.4,0.4", -- HOMING
        price = 200,
        mana = 50,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/proj_homing_delayed.xml,data/entities/particles/tinyspark_white_weak.xml,"
            draw_actions( 1, true )
        end,
    },
    --[[
    {
        id          = "APOTHEOSIS_MATERIAL_LAVA",
        name 		= "$action_material_lava",
        description = "$actiondesc_material_lava",
        sprite 		= "data/ui_gfx/gun_actions/material_lava.png",
        spawn_requires_flag = "apotheosis_card_unlocked_lost_alchemy_spell",  --Lost Alchemy Unlock Puzzle, hopefully these spells should make alchemy easier
        type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,1,2,3,4", -- MATERIAL_ALCHEMY
		spawn_probability                 = "0.1,0.1,0.1,0.05,0.05", -- MATERIAL_ALCHEMY
        price = 100,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action 		= function()
            add_projectile("data/entities/projectiles/deck/material_lava.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    ]]--
    --Most of these material spells are bloat, it'd be better to have a bunch of one-off flasks with these relevent materials than a ton of spells dedicated to each one you'd only ever use maybe once.
    --Slime & Whiskey are the most practical for people to use due to their alchemic reactions, assuming you know them...
    --Hey, while you're here snooping as usual I see, have you ever tried mixing whiskey & soarium? Or was it concentrated mana and levitatium? I don't remember
    {
        id          = "APOTHEOSIS_MATERIAL_SLIME",
        name 		= "$spell_apotheosis_material_slime_name",
        description = "$spell_apotheosis_material_slime_desc",
        sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/material_slime.png",
        spawn_requires_flag = "apotheosis_card_unlocked_lost_alchemy_spell",  --Lost Alchemy Unlock Puzzle, hopefully these spells should make alchemy easier
        type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,1,2,3,4", -- MATERIAL_ALCHEMY
		spawn_probability                 = "0.1,0.2,0.1,0.05,0.05", -- MATERIAL_ALCHEMY
        price = 100,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/material_slime.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    {
        id          = "APOTHEOSIS_MATERIAL_ALCOHOL",
        name 		= "$spell_apotheosis_material_alcohol_name",
        description = "$spell_apotheosis_material_alcohol_desc",
        sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/material_alcohol.png",
        spawn_requires_flag = "apotheosis_card_unlocked_lost_alchemy_spell",  --Lost Alchemy Unlock Puzzle, hopefully these spells should make alchemy easier
        type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,1,2,3,4", -- MATERIAL_ALCHEMY
		spawn_probability                 = "0.1,0.2,0.1,0.05,0.05", -- MATERIAL_ALCHEMY
        price = 100,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/material_alcohol.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    --[[
    {
        id          = "APOTHEOSIS_MATERIAL_CONFUSE",
        name 		= "$spell_apotheosis_material_confuse_name",
        description = "$spell_apotheosis_material_confuse_desc",
        sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/material_confuse.png",
        spawn_requires_flag = "apotheosis_card_unlocked_lost_alchemy_spell",  --Lost Alchemy Unlock Puzzle, hopefully these spells should make alchemy easier
        type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,1,2,3,4", -- MATERIAL_ALCHEMY
		spawn_probability                 = "0.1,0.1,0.1,0.05,0.05", -- MATERIAL_ALCHEMY
        price = 100,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/material_confuse.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    {
        id          = "APOTHEOSIS_MATERIAL_COPPER",
        name 		= "$spell_apotheosis_material_copper_name",
        description = "$spell_apotheosis_material_copper_desc",
        sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/material_copper.png",
        spawn_requires_flag = "apotheosis_card_unlocked_lost_alchemy_spell",  --Lost Alchemy Unlock Puzzle, hopefully these spells should make alchemy easier
        type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,1,2,3,4", -- MATERIAL_ALCHEMY
		spawn_probability                 = "0.1,0.1,0.1,0.05,0.05", -- MATERIAL_ALCHEMY
        price = 100,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/material_copper.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    {
        id          = "APOTHEOSIS_MATERIAL_FUNGI",
        name 		= "$spell_apotheosis_material_fungi_name",
        description = "$spell_apotheosis_material_fungi_desc",
        sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/material_fungi.png",
        spawn_requires_flag = "apotheosis_card_unlocked_lost_alchemy_spell",  --Lost Alchemy Unlock Puzzle, hopefully these spells should make alchemy easier
        type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,1,2,3,4", -- MATERIAL_ALCHEMY
		spawn_probability                 = "0.1,0.1,0.1,0.05,0.05", -- MATERIAL_ALCHEMY
        price = 100,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/material_fungi.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    ]]--
    --TODO
    --All of these material spells should spawn in a special place.. take inspiration from the lake bunker
    --Check DM Notes
}



for k=1,#apotheosis_spellappends
do local v = apotheosis_spellappends[k]
    table.insert(actions,v)
end







-- Checks if a spell is being cast by a greek letter & if you have the perk which allows it
-- Not completely sure why, but this feels like a bad solution, wrong, is it because it isn't 'absolute'?
function disablecopying(recursion_level)
    if (recursion_level) ~= nil and GameHasRunFlag("apotheosis_flag_copy_spells") == false then return true
    else return false
    end
end


--Modifying Vanilla spells
--Recursion = Greek letters
--Iteration = divide by

--Function for modifying existing spells
function modify_existing_spell(spell_id, parameter_to_modify, new_value)
	for i, spell in ipairs(actions) do
		if spell.id == spell_id then
			spell[parameter_to_modify] = new_value
			break
		end
	end
end

--CoV can no longer be used by greek letters/splitshot
modify_existing_spell(
	"REGENERATION_FIELD",
	"action",
    function(recursion_level)
        if (recursion_level) ~= nil then return; end
        --if disablecopying(recursion_level) then return; end
        add_projectile("data/entities/projectiles/deck/regeneration_field.xml")
        c.fire_rate_wait = c.fire_rate_wait + 15
    end
)

--Healing bolt can no longer be used by greek letters/splitshot
modify_existing_spell(
	"HEAL_BULLET",
	"action",
    function(recursion_level)
        if (recursion_level) ~= nil then return; end
        --if disablecopying(recursion_level) then return; end
        add_projectile("data/entities/projectiles/deck/heal_bullet.xml")
        c.fire_rate_wait = c.fire_rate_wait + 4
        c.spread_degrees = c.spread_degrees + 2.0
    end
)

--Arrow doesn't have increased knockback
--This spell is secretly kinda god-tier once you realise it gains damage from speed.. hmm
modify_existing_spell(
	"ARROW",
	"action",
    function()
        add_projectile("data/entities/projectiles/deck/arrow.xml")
        c.fire_rate_wait = c.fire_rate_wait + 10
        c.spread_degrees = c.spread_degrees - 20
    end
)

--Death Cross becomes cheaper
modify_existing_spell("DEATH_CROSS","mana", 40)

--Giga Death Cross becomes cheaper
modify_existing_spell("DEATH_CROSS_BIG", "mana", 100)
modify_existing_spell("MEGALASER", "mana", 80)

--Spitter Bolt Tier 2 & 3 becomes cheaper
modify_existing_spell("SPITTER_TIER_2","mana",10)

modify_existing_spell("SPITTER_TIER_2_TIMER","mana",20)

--Spitter Bolt Tier 2 & 3 becomes cheaper
modify_existing_spell("SPITTER_TIER_3","mana",20)

modify_existing_spell("SPITTER_TIER_3_TIMER","mana",30)

--Increase frequency of acceleration/Rotate towards foes appearing, makes acceleration builds more accessible
modify_existing_spell("ACCELERATING_SHOT","spawn_level","1,2,3,4,5")
modify_existing_spell("ACCELERATING_SHOT","spawn_probability","0.5,1,1,1,0.5")

modify_existing_spell("HOMING_ROTATE","spawn_level","2,3,4,5,6")
modify_existing_spell("HOMING_ROTATE","spawn_probability","0.6,0.8,1,1,0.6")

--Chainsaw mana cost increase, forces you to expend all your mana for making a rapidfire build early on
modify_existing_spell("CHAINSAW","mana",12)

--Slightly buff Bubbly Bounce by reducing the spell cost & removing the recoil effect from the modiifer
modify_existing_spell("BOUNCE_SPARK","price",60)
modify_existing_spell(
	"BOUNCE_SPARK",
	"action",
    function()
        c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_spark.xml,"
        c.bounces = c.bounces + 1
        c.fire_rate_wait = c.fire_rate_wait + 8
        draw_actions( 1, true )
    end
)

--Slightly buff Plasma Beam Bounce by reducing the spell cost & removing the recoil effect from the modiifer
modify_existing_spell("BOUNCE_LASER_EMITTER","price",90)
modify_existing_spell(
	"BOUNCE_LASER_EMITTER",
	"action",
    function()
        c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_laser_emitter.xml,"
        c.bounces = c.bounces + 1
        c.fire_rate_wait = c.fire_rate_wait + 12
        draw_actions( 1, true )
    end
)

--Slightly buff Concentrated Light Bounce by reducing the spell cost & removing the recoil effect from the modiifer
modify_existing_spell("BOUNCE_LASER","price",90)
modify_existing_spell(
	"BOUNCE_LASER",
	"action",
    function()
        c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_laser.xml,"
        c.bounces = c.bounces + 1
        c.fire_rate_wait = c.fire_rate_wait + 12
        draw_actions( 1, true )
    end
)

--Fix Healing Bolt & Circle of Vigour to have updated spell descriptions
modify_existing_spell("REGENERATION_FIELD","description","$spell_apotheosis_cov_desc")
modify_existing_spell("HEAL_BULLET","description","$spell_apotheosis_healing_bolt_desc")

--I feel worried that I'm tinkering with the base game a bit too much here
modify_existing_spell("REGENERATION_FIELD","spawn_level","1,2,3,4,10")
modify_existing_spell("REGENERATION_FIELD","spawn_probability","0.2,0.2,0.2,0.2,0.5")



--Remove Spells
--[[
function remove_spell(spell_name)
	local key_to_spell = nil
	for key, perk in pairs(actions) do
		if (perk.id == spell_name) then
			key_to_spell = key
		end
	end

	if (key_to_spell ~= nil) then
		table.remove(actions, key_to_spell)
	end
end

remove_spell("LASER_LUMINOUS_DRILL")
]]--