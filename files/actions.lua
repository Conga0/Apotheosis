local apotheosis_spellappends = {
    {
        id          = "APOTHEOSIS_SAWBLADE_BIG_RAY",
        id_matchup  = "LASER_EMITTER_RAY",
        name 		= "$spell_apotheosis_thrower_disc_name",
        description = "$spell_apotheosis_thrower_disc_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_disc_big_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_disc_big_ray.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "APOTHEOSIS_SAWBLADE_BIG_RAY",
        name 		= "$spell_apotheosis_thrower_cursed_orb_name",
        description = "$spell_apotheosis_thrower_cursed_orb_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_cursed_orb_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_cursed_orb_ray.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
    --[[
    {
        id          = "APOTHEOSIS_DYNAMITE_RAY",
        id_matchup  = "APOTHEOSIS_CURSED_ORB_RAY",
        name 		= "$spell_apotheosis_thrower_tnt_name",
        description = "$spell_apotheosis_thrower_tnt_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_dynamite_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_dynamite_ray.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
    ]]--
    {
        id          = "APOTHEOSIS_ICEBALL_RAY",
        id_matchup  = "APOTHEOSIS_CURSED_ORB_RAY",
        name 		= "$spell_apotheosis_thrower_ice_ball_name",
        description = "$spell_apotheosis_thrower_ice_ball_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_ice_ball_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_ice_ball_ray.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "APOTHEOSIS_ICEBALL_RAY",
        name 		= "$spell_apotheosis_thrower_nuke_name",
        description = "$spell_apotheosis_thrower_nuke_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_nuke_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/thrower_nuke_ray.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "TENTACLE_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_disc_enemy_name",
        description = "$spell_apotheosis_thrower_disc_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_disc_big_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_disc_big_ray_enemy.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "APOTHEOSIS_SAWBLADE_BIG_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_cursed_orb_enemy_name",
        description = "$spell_apotheosis_thrower_cursed_orb_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_cursed_orb_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_cursed_orb_ray_enemy.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
    --[[
    {
        id          = "APOTHEOSIS_DYNAMITE_RAY_ENEMY",
        id_matchup  = "APOTHEOSIS_CURSED_ORB_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_tnt_enemy_name",
        description = "$spell_apotheosis_thrower_tnt_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_dynamite_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_dynamite_ray_enemy.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
    ]]--
    {
        id          = "APOTHEOSIS_ICEBALL_RAY_ENEMY",
        id_matchup  = "APOTHEOSIS_CURSED_ORB_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_ice_ball_enemy_name",
        description = "$spell_apotheosis_thrower_ice_ball_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_ice_ball_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_ice_ball_ray_enemy.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "APOTHEOSIS_ICEBALL_RAY_ENEMY",
        name 		= "$spell_apotheosis_thrower_nuke_enemy_name",
        description = "$spell_apotheosis_thrower_nuke_enemy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/thrower_nuke_ray_enemy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_nuke_ray_enemy.xml" },
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "LANCE_HOLY",
        name 		= "$spell_apotheosis_holy_orb_barrage_name",
        description = "$spell_apotheosis_holy_orb_barrage_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/orb_holy_shotgun.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml", 7},
        --spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
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
        id_matchup  = "BOMB",
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
        spawn_probability                 = "0.1,0.1,0.3,0.5,0.05", -- LAVA_TO_BLOOD
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
        spawn_probability                 = "0.1,0.1,0.3,0.5,0.05", -- LAVA_TO_BLOOD
        price = 250,
        mana = 200,
        max_uses = 3,
        pandorium_ignore = true,
        action 		= function( recursion_level, iteration )
            if reflecting then
                c.fire_rate_wait = c.fire_rate_wait + 60
                current_reload_time = current_reload_time + 30
                return
            end
            --add_projectile("data/entities/misc/forced_bungal_shift.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            current_reload_time = current_reload_time + 30

            --Fungal Shift
            do
                dofile_once("data/scripts/lib/utilities.lua")
                dofile_once("mods/Apotheosis/files/scripts/magic/fungal_shift.lua")
                
                local entity_id    = GetUpdatedEntityID()
                local pos_x, pos_y = EntityGetTransform( entity_id )
                
                SetRandomSeed(pos_x + GameGetFrameNum(), pos_y)
                
                -- spawn random eye particles
                if ( rand(0,1) > 0.5 ) then
                    function spawn( x,y )
                        EntityLoad( "data/entities/particles/treble_eye.xml", x,y )
                    end
                
                    local x,y = pos_x + rand(-100,100), pos_y + rand(-80,80)
                    local rad = rand(0,30)
                
                    spawn(x,y)
                    spawn( x + 40 + rad, y + 30 + rad )
                    spawn( x - 40 - rad, y + 30 + rad )
                end

                --Timer check
                local iter = iteration or 0
                local frame = GameGetFrameNum()
	            local last_frame = tonumber( GlobalsGetValue( "fungal_shift_last_frame", "-1000000" ) )
                local fungal_iter = tonumber( GlobalsGetValue( "fungal_shift_iteration", "0" ) )
                
                -- shift materials
                if iter > 0 and frame > last_frame + 60*60*5 and fungal_iter < 20 then
                    fungal_shift( entity_id, pos_x, pos_y, true )
                else
                    --fungal_shift( entity_id, pos_x, pos_y, false )
                    add_projectile("data/entities/misc/forced_bungal_shift.xml")
                end
            end
        end,
    },
    {
        id          = "APOTHEOSIS_AQUA_MINE",
        id_matchup  = "GRENADE_LARGE",
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
        id_matchup  = "MEGALASER",
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
        id_matchup  = "APOTHEOSIS_MUSICAL_STRIKE",
        name 		= "$spell_apotheosis_musical_proj_trig_name",
        description = "$spell_apotheosis_musical_proj_trig_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/musical_strike_trigger.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/musical_delayed_attack_end.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_musical_boss_spell",
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "1,2,3,4,5,10", -- MUSICALSTRIKE
        spawn_probability                 = "0.5,0.5,0.5,0.5,0.4,0.01", -- MUSICALSTRIKE
        price = 220,
        mana = 60, 
        max_uses = 30,
        action 		= function()
            add_projectile_trigger_hit_world("mods/Apotheosis/files/entities/projectiles/deck/musical_delayed_attack_end.xml", 1)
        end,
    },
    {
        id          = "APOTHEOSIS_REVERBERATION",
        id_matchup  = "APOTHEOSIS_MUSICAL_STRIKE_TRIGGER",
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
        id_matchup  = "APOTHEOSIS_BUNGAL_SHIFT",
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
        pandorium_ignore = true,
        action 		= function( recursion_level, iteration )
            if reflecting then
                c.fire_rate_wait = c.fire_rate_wait + 60
                current_reload_time = current_reload_time + 30
                return
            end
            --add_projectile("data/entities/misc/forced_bungal_shift_spam.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            current_reload_time = current_reload_time + 30

            --Fungal Shift
            do
                dofile_once("data/scripts/lib/utilities.lua")
                dofile_once("mods/Apotheosis/files/scripts/magic/fungal_shift_spam.lua")
                
                local entity_id    = GetUpdatedEntityID()
                local pos_x, pos_y = EntityGetTransform( entity_id )
                
                SetRandomSeed(pos_x + GameGetFrameNum(), pos_y)
                
                -- spawn random eye particles
                if ( rand(0,1) > 0.5 ) then
                    function spawn( x,y )
                        EntityLoad( "data/entities/particles/treble_eye.xml", x,y )
                    end
                
                    local x,y = pos_x + rand(-100,100), pos_y + rand(-80,80)
                    local rad = rand(0,30)
                
                    spawn(x,y)
                    spawn( x + 40 + rad, y + 30 + rad )
                    spawn( x - 40 - rad, y + 30 + rad )
                end
                
                -- shift materials
                local iter = iteration or 0
                if iter > 0 then
                    fungal_shift( entity_id, pos_x, pos_y, true )
                else
                    add_projectile("data/entities/misc/forced_bungal_shift_spam.xml")
                end
            end
        end,
    },
    {
        id          = "APOTHEOSIS_RAT_BITE_CRIT",
        id_matchup  = "APOTHEOSIS_RAT_BITE",
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
        id          = "APOTHEOSIS_SPELLS_TO_CATS",
        id_matchup  = "ALL_ACID",
        name 		= "$spell_apotheosis_spells_to_sorako_name",
        description = "$spell_apotheosis_spells_to_sorako_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/spells_to_cats.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/spells_to_cats.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_cat_secret_spell",
        type 		= ACTION_TYPE_UTILITY,
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
        id_matchup        = "CHAIN_SHOT",
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
                local rnd_num = math.random(1,2)
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
        pandorium_ignore = true,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_TARGETTER",
        id_matchup  = "LASER_LUMINOUS_DRILL",
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
		related_projectiles	= {"data/entities/projectiles/deck/teleport_projectile.xml"},
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "0,1,2,4,5,6,10", -- TELEPORT_PROJECTILE
        spawn_probability                 = "0.45,0.45,0.45,0.3,0.3,0.3,0.8", -- TELEPORT_PROJECTILE
        subtype     = { altfire = true },
        price = 130,
        mana = 40,
        custom_uses_logic = true,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_teleport.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
            mana = mana + 40
        end,
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT",
        name 		= "$spell_apotheosis_alt_fire_teleport_short_name",
        description = "$spell_apotheosis_alt_fire_teleport_short_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_teleport_projectile_short.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/teleport_projectile_short.xml"},
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "0,1,2,4,5,6,10", -- TELEPORT_PROJECTILE
        spawn_probability                 = "0.45,0.45,0.45,0.3,0.3,0.3,0.8", -- TELEPORT_PROJECTILE
        subtype     = { altfire = true },
        price = 130,
        mana = 20,
        custom_uses_logic = true,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_teleport_short.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
            mana = mana + 20
        end,
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_SWAPPER",
        name 		= "$spell_apotheosis_alt_fire_swapper_name",
        description = "$spell_apotheosis_alt_fire_swapper_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_swapper_projectile.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/swapper.xml"},
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "0,1,2,4,5,6,10", -- TELEPORT_PROJECTILE
        spawn_probability                 = "0.2,0.2,0.2,0.1,0.1,0.1,0.05", -- TELEPORT_PROJECTILE
        subtype     = { altfire = true },
        price = 130,
        mana = 10,
        custom_uses_logic = true,
        --max_uses    = 1,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_swapper.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
            mana = mana + 10
        end,
    },

    --Wait.. is burning trail literally just fire charge but not called fire charge..? Keep your naming consistency together Noita please
    --I do want a spell which lets me do fire damage though.. so...
    {
        id          = "APOTHEOSIS_FIRE_CHARGE",
        id_matchup  = "FREEZE",
        name 		= "$spell_apotheosis_firecharge_name",
        description = "$spell_apotheosis_firecharge_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/fire_charge.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/heavy_bullet_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,2,4,5", -- ELECTRIC_CHARGE
        spawn_probability                 = "1,1,1,1", -- ELECTRIC_CHARGE
        price = 150,
        mana = 10,
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
        pandorium_ignore = true,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/portal_red_marker.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_red_portal.xml")
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
        pandorium_ignore = true,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/portal_green_marker.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_green_portal.xml")
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
        pandorium_ignore = true,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/portal_blue_marker.xml",
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_blue_portal.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 100
        end,
    },
    {
        id          		= "APOTHEOSIS_KNOWLEDGE_OF_KINGS",
        name 				= "$spell_apotheosis_knowledge_of_kings_name",
        description 		= "$spell_apotheosis_knowledge_of_kings_desc",
        sprite 				= "mods/Apotheosis/files/ui_gfx/gun_actions/knowledge_of_kings.png",
        sprite_unidentified	= "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag	= "apotheosis_card_unlocked_secret_knowledge_of_kings_spell",
        spawn_manual_unlock	= true,
        never_unlimited		= true,
        type 				= ACTION_TYPE_OTHER,
        recursive			= true,
        ai_never_uses 		= true,
        spawn_level			= "10",
        spawn_probability	= "0.0001",
        price				= 2000,
        mana				= 600,
        max_uses    		= 1,
        custom_xml_file		= "mods/Apotheosis/files/entities/misc/custom_cards/knowledge_of_kings.xml",
        pandorium_ignore = true,
        action 				= function()
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
        id_matchup  = "APOTHEOSIS_SPELLS_TO_CATS",
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
        id_matchup  = "APOTHEOSIS_MASS_STATUS_POLYMORPH",
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
        pandorium_ignore = true,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph_intense.xml")
            c.fire_rate_wait = c.fire_rate_wait + 100
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_MASS_BURROW",
        id_matchup  = "WORM_RAIN",
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
        id_matchup  = "APOTHEOSIS_MASS_STATUS_POLYMORPH_INTENSE",
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
            current_reload_time = current_reload_time + 60
        end,
    },
    {
        id          = "APOTHEOSIS_AUTOFIRE",
        id_matchup  = "TINY_GHOST",
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
        custom_xml_file		= "mods/Apotheosis/files/entities/misc/custom_cards/spell_infusion.xml",
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
        id_matchup  = "APOTHEOSIS_ALT_FIRE_SWAPPER",
        name 		= "$spell_apotheosis_alt_fire_cov_name",
        description = "$spell_apotheosis_alt_fire_cov_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_cov_projectile.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/regeneration_field.xml"},
        --spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "1,2,3,4,10", -- REGENERATION_FIELD
        spawn_probability                 = "0.2,0.2,0.2,0.2,0.7", -- REGENERATION_FIELD
        subtype     = { altfire = true },
        price = 250,
        mana = 80,
        max_uses = 2,
        never_unlimited = true,
        custom_uses_logic = true,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_cov.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
            mana = mana + 80
        end,
    },
    {
        id          = "APOTHEOSIS_ALT_FIRE_TARGETTER",
        id_matchup  = "APOTHEOSIS_ALT_FIRE_COV",
        name 		= "$spell_apotheosis_alt_fire_targetter_name",
        description = "$spell_apotheosis_alt_fire_targetter_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/alt_fire_targetter.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/targetter.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_boss_flesh_monster_spell",    --Alt fire varient can't spawn until you've slain the Heretic, no need to introduce multiple new mechanics at once to a new player and overwhelm them; this will also help keep the game fresh for veterened players by continuing to introduce new spells as they defeat later game bosses
        type    = ACTION_TYPE_PASSIVE,
        spawn_level                       = "1,2,3,4,5,6", -- HEAVY_BULLET
        spawn_probability                 = "0.25,0.5,0.5,0.5,0.5,0.5", -- HEAVY_BULLET
        subtype     = { altfire = true },
        price = 250,
        mana = 40,
        max_uses = 8,
        never_unlimited = true,
        custom_uses_logic = true,
        custom_xml_file   = "mods/Apotheosis/files/entities/misc/custom_cards/alt_fire_targetter.xml",
        action            = function()
            -- Go to the next card
            draw_actions(1, true)
            mana = mana + 40
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
        id_matchup  = "HITFX_CRITICAL_BLOOD",
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
        id_matchup  = "LIGHT",
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
    {
        id          = "APOTHEOSIS_LIQUIDSPHERE_ACID",
        id_matchup  = "INFESTATION",
        name 		= "$spell_apotheosis_liquidsphere_acid_name",
        description = "$spell_apotheosis_liquidsphere_acid_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/liquidsphere_acid.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/black_hole_unidentified.png",
        related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/liquidsphere_acid.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "0,2,4,5", -- BLACK_HOLE
        spawn_probability                 = "0.8,0.8,0.8,0.8", -- BLACK_HOLE
        price = 200,
        mana = 180,
        max_uses    = 3, 
        never_unlimited = true,
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/liquidsphere_acid.xml")
            c.fire_rate_wait = c.fire_rate_wait + 80
            c.screenshake = c.screenshake + 20
        end,
    },
    {
        id          = "APOTHEOSIS_LIQUIDSPHERE_WATER",
        id_matchup  = "APOTHEOSIS_LIQUIDSPHERE_ACID",
        name 		= "$spell_apotheosis_liquidsphere_water_name",
        description = "$spell_apotheosis_liquidsphere_water_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/liquidsphere_water.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/black_hole_unidentified.png",
        related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/liquidsphere_water.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level       = "0,1,2,3,4,5,6", -- X_RAY
        spawn_probability = "0.7,0.8,0.8,0.7,0.6,0.4,0.2", -- X_RAY
        price = 120,
        mana = 120,
        max_uses    = 30, 
        never_unlimited = false,
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/liquidsphere_water.xml")
            c.fire_rate_wait = c.fire_rate_wait + 80
            c.screenshake = c.screenshake + 20
        end,
    },
    {
        id          = "APOTHEOSIS_LIQUIDSPHERE_TELEPORTATIUM",
        id_matchup  = "APOTHEOSIS_LIQUIDSPHERE_WATER",
        name 		= "$spell_apotheosis_liquidsphere_teleportatium_name",
        description = "$spell_apotheosis_liquidsphere_teleportatium_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/liquidsphere_teleportatium.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/black_hole_unidentified.png",
        related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/liquidsphere_teleportatium.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5", -- TELEPORTATION_FIELD
		spawn_probability                 = "0.3,0.6,0.3,0.3,0.6,0.3", -- TELEPORTATION_FIELD
        price = 120,
        mana = 120,
        max_uses    = 3, 
        never_unlimited = false,
        action 		= function()
            add_projectile("mods/apotheosis/files/entities/projectiles/deck/liquidsphere_teleportatium.xml")
            c.fire_rate_wait = c.fire_rate_wait + 80
            c.screenshake = c.screenshake + 20
        end,
    },
    {
        id          = "APOTHEOSIS_STAR_SHOT",
        id_matchup  = "APOTHEOSIS_HOLYORB_SHOTGUN",
        name 		= "$spell_apotheosis_star_shot_name",
        description = "$spell_apotheosis_star_shot_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/star_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/star_shot.xml", 2},
        type 		= ACTION_TYPE_PROJECTILE,
        spawn_level                       = "2,3,4,5,6", -- BUCKSHOT
        spawn_probability                 = "0.7,0.7,0.8,0.8,0.6", -- BUCKSHOT
        price = 140,
        mana = 40,
        action 		= function()
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/star_shot.xml")
            add_projectile("mods/Apotheosis/files/entities/projectiles/deck/star_shot.xml")
            c.fire_rate_wait = c.fire_rate_wait + 16
            c.spread_degrees = c.spread_degrees + 25.0
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_HEX_WATER",
        id_matchup  = "APOTHEOSIS_HITFX_AFFLUENCE",
        name 		= "$spell_apotheosis_hex_water_name",
        description = "$spell_apotheosis_hex_water_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/hex_water.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_hex_water.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_14_spell",  --Sunken Cavern
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- Material Hex
        spawn_probability = "0.1,0.5,1.0,0.6,0.4,0.3,0.4", -- Material Hex
        price = 110,
        mana = 30,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_hex_water.xml,mods/apotheosis/files/entities/particles/tinyspark_water.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_HEX_OIL",
        id_matchup  = "APOTHEOSIS_HITFX_HEX_WATER",
        name 		= "$spell_apotheosis_hex_oil_name",
        description = "$spell_apotheosis_hex_oil_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/hex_oil.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_hex_oil.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_14_spell",  --Sunken Cavern
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- Material Hex
        spawn_probability = "0.5,1.0,0.6,0.4,0.3,0.4", -- Material Hex
        price = 110,
        mana = 30,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_hex_oil.xml,mods/apotheosis/files/entities/particles/tinyspark_oil.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_HITFX_HEX_BLOOD",
        id_matchup  = "APOTHEOSIS_HITFX_HEX_OIL",
        name 		= "$spell_apotheosis_hex_blood_name",
        description = "$spell_apotheosis_hex_blood_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/hex_blood.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_hex_blood.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_14_spell",  --Sunken Cavern
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- Material Hex
        spawn_probability = "0.5,1.0,0.6,0.4,0.3,0.4", -- Material Hex
        price = 110,
        mana = 30,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_hex_blood.xml,mods/apotheosis/files/entities/particles/tinyspark_blood.xml,"
            draw_actions( 1, true )
        end,
    },
    {
        id          = "APOTHEOSIS_MIST_ATTUNIUM",
        id_matchup  = "MIST_BLOOD",
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
        id_matchup  = "HOMING_AREA",
        name 		= "$spell_apotheosis_homing_delayed_name",
        description = "$spell_apotheosis_homing_delayed_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/homing_delayed.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/proj_homing_delayed.xml" },
        type 		= ACTION_TYPE_MODIFIER,
        subtype     = { homing = true },
        spawn_level                       = "1,2,3,4,5,6", -- HOMING
        spawn_probability                 = "0.1,0.4,0.4,0.4,0.4,0.4", -- HOMING
        price = 200,
        mana = 50,
        --max_uses = 16,
        subtype = {
            homing = true
        },
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
        id_matchup  = "MATERIAL_CEMENT",
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
			c.game_effect_entities = c.game_effect_entities .. "mods/apotheosis/files/entities/misc/effect_apply_slimy.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },
    {
        id          = "APOTHEOSIS_MATERIAL_ALCOHOL",
        id_matchup  = "APOTHEOSIS_MATERIAL_SLIME",
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
			c.game_effect_entities = c.game_effect_entities .. "mods/apotheosis/files/entities/misc/effect_apply_drunk.xml,"
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
    --Note (Conga): Omega Death Cross should spawn in a special place after a questline, similar to how Giga Nuke and Omega Sawblade does
	{
		id          = "APOTHEOSIS_DEATH_CROSS_OMEGA",
        id_matchup  = "DEATH_CROSS_BIG",
        name 		= "$spell_apotheosis_death_cross_omega_name",
        description = "$spell_apotheosis_death_cross_omega_desc",
        sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/death_cross_omega.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/death_cross_unidentified.png",
		related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/death_cross_omega.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_omega_cross_spell",  --Teleporter Puzzle
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "4,5,10", -- DISC_BULLET_BIGGER
		spawn_probability                 = "0.1,0.2,1", -- DISC_BULLET_BIGGER
		price = 310,
		mana = 150,
		max_uses = 8,
		custom_xml_file = "mods/apotheosis/files/entities/misc/custom_cards/death_cross_omega.xml",
		action 		= function()
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/death_cross_omega.xml")
			c.fire_rate_wait = c.fire_rate_wait + 70
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
		end,
	},
    --There's a really fun way to Noita yourself here by using boomerang + healing bolt :)
    {
        id          = "APOTHEOSIS_HITFX_MUDMAN_SLIMY",
        id_matchup  = "HITFX_EXPLOSION_ALCOHOL_GIGA",
        name 		= "$spell_apotheosis_mudman_slimy_name",
        description = "$spell_apotheosis_mudman_slimy_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mudman_slimy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_mudman_slimy.xml" },
        spawn_requires_flag = "apotheosis_card_unlocked_orb_15_spell",  --Divine Rock
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,3,4,5", -- APOTHEOSIS_HITFX_MUDMAN_SLIMY
        spawn_probability                 = "0.05,0.05,0.02,0.02", -- APOTHEOSIS_HITFX_MUDMAN_SLIMY
        price = 200,
        mana = 200,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_mudman_slimy.xml,"
            draw_actions( 1, true )
        end,
    },
    --Not as fun as I thought it'd be
    --[[
	{
		id          = "APOTHEOSIS_CLOUD_GUNPOWDER",
        id_matchup  = "CLOUD_ACID",
        name 		= "$spell_apotheosis_cloud_gunpowder_name",
        description = "$spell_apotheosis_cloud_gunpowder_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/cloud_gunpowder.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/cloud_gunpowder.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5", -- CLOUD_ACID
		spawn_probability                 = "0.2,0.2,0.2,0.2,0.2,0.2", -- CLOUD_ACID
		price = 180,
		mana = 90,
		max_uses = 8,
		action 		= function()
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/cloud_gunpowder.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	},
    --More interesting as a perk
    {
        id          = "APOTHEOSIS_HITFX_NORAGDOLL",
        id_matchup  = "HITFX_PETRIFY",
        name 		= "$spell_apotheosis_noragdoll_name",
        description = "$spell_apotheosis_noragdoll_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/noragdoll.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_noragdoll.xml" },
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,3,4,5", -- APOTHEOSIS_HITFX_MUDMAN_SLIMY
        spawn_probability                 = "0.05,0.05,0.02,0.02", -- APOTHEOSIS_HITFX_MUDMAN_SLIMY
        price = 50,
        mana = 20,
        max_uses = 20,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_noragdoll.xml,"
            draw_actions( 1, true )
        end,
    },
    ]]--
	{
		id          = "APOTHEOSIS_TRAIL_LARGER",
        id_matchup  = "FIRE_TRAIL",
        name 		= "$spell_apotheosis_trail_enhancer_name",
        description = "$spell_apotheosis_trail_enhancer_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/trail_enhancer.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/burn_trail_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- WATER_TRAIL
		spawn_probability                 = "0.3,0.3,0.3,0.3,0.3", -- WATER_TRAIL
		price = 100,
		mana = 10,
		--max_uses = 120,
		action 		= function()
			c.trail_material_amount = c.trail_material_amount + 150
			draw_actions( 1, true )
		end,
	},
    --[[
        --Bloat, when would you ever use this?.... within reason!
	{
		id          = "APOTHEOSIS_TRAIL_SMALLER",
        id_matchup  = "APOTHEOSIS_TRAIL_LARGER",
        name 		= "$spell_apotheosis_trail_reducer_name",
        description = "$spell_apotheosis_trail_reducer_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/trail_reducer.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/burn_trail_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,1,2,3,4", -- WATER_TRAIL
		spawn_probability                 = "0.1,0.2,0.3,0.3,0.3", -- WATER_TRAIL
		price = 100,
		mana = -10,
		--max_uses = 120,
		action 		= function()
			c.trail_material_amount = c.trail_material_amount - 30
			draw_actions( 1, true )
		end,
	},
    ]]--
	{
		id          = "APOTHEOSIS_CLOUD_VOLCANIC",
        id_matchup  = "CLOUD_ACID",
        name 		= "$spell_apotheosis_cloud_volcanic_name",
        description = "$spell_apotheosis_cloud_volcanic_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/cloud_volcanic.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/cloud_volcanic.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5", -- CLOUD_ACID
		spawn_probability                 = "0.2,0.2,0.2,0.2,0.2,0.2", -- CLOUD_ACID
		price = 180,
		mana = 110,
		max_uses = 8,
		action 		= function()
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/cloud_volcanic.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	},
	{
		id          = "APOTHEOSIS_LARPA_DELAYED",   --Copi: It slightly bothers me that the extra entity name and the ID are inconsistent
        id_matchup  = "LARPA_DEATH",
        name 		= "$spell_apotheosis_larpa_delayed_name",
        description = "$spell_apotheosis_larpa_delayed_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/larpa_delay.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/burn_trail_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "4,5,6", -- BOUNCE_SPARK
		spawn_probability                 = "0.4,0.6,0.4", -- BOUNCE_SPARK
		price = 250,
		mana = 40,
		--max_uses = 150,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/larpa_shotgun.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 32
			draw_actions( 1, true )
		end,
	},
	{
		id          = "APOTHEOSIS_RANDOM_HOMING",
        id_matchup  = "RANDOM_STATIC_PROJECTILE",
        name 		= "$spell_apotheosis_random_homing_name",
        description = "$spell_apotheosis_random_homing_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/random_homing.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_pyramid",
		type 		= ACTION_TYPE_MODIFIER,
		recursive	= true,
		spawn_level                       = "4,5,6,10", -- MANA_REDUCE
		spawn_probability                 = "0.3,0.1,0.1,0.5", -- MANA_REDUCE
		price = 120,
		mana = 30,
		action 		= function( recursion_level, iteration )
			SetRandomSeed( GameGetFrameNum() + #deck, GameGetFrameNum() + 133 )
            local tdelay = c.fire_rate_wait

            local IDTable = {}

            for k=1,#actions
            do local v = actions[k]
                if v.subtype then
                    if v.subtype.homing then
                        table.insert(IDTable,k)
                    end
                end
            end

            --[[ Demo code for new subtypes system 
            for i = 1, #actions do
                if actions[i].subtypes["homing"] and actions[i].id ~= "COPIS_THINGS_HOMING_MACROSS" then
                    IDTable[#IDTable+1] = actions[i]
                end
            end
            ]] -- - Copi

			local rnd = Random( 1, #IDTable )
			local data = actions[IDTable[rnd]]
			
			local safety = 0
			local rec = check_recursion( data, recursion_level )
			
			data.action( rec )
            c.fire_rate_wait = tdelay
		end,
	},
    --[[ Old Lua Sharing - new one directly below
	{   --How would this even work on a technical level? Idea is to share lua components of projectiles amongst all other projectiles
		id          = "APOTHEOSIS_LUA_SHARING",
        id_matchup  = "TRANSMUTATION",
        name 		= "$spell_apotheosis_lua_sharing_name",
        description = "$spell_apotheosis_lua_sharing_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/random_homing.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6,10", -- TRANSMUTATION
		spawn_probability                 = "0.3,0.3,0.3,0.3,0.3,0.2", -- TRANSMUTATION
		price = 180,
		mana = 60,
		--max_uses = 8,
		action 		= function()

            local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
            local init = true

            local content_modifier = ModTextFileGetContent("mods/Apotheosis/files/entities/misc/lua_sharing.xml")
            local xml2 = nxml.parse(content_modifier)
            local luacomp = xml2:first_of("LuaComponent")
            if luacomp then
                xml2:remove_child(luacomp)
                GamePrint("Lua Child Found")
            end

            for k=1,#deck
            do local v = deck[k]
                if v.type <= 1 then
                    local proj_file = v.related_projectiles[1] or v.related_projectiles

                    local content = ModTextFileGetContent(proj_file)
                    local xml = nxml.parse(content)
                    local attrs = xml:first_of("LuaComponent")

                    xml2:add_child(attrs)
                    ModTextFileSetContent("mods/Apotheosis/files/entities/misc/lua_sharing.xml",tostring(xml2))

                    c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/lua_sharing.xml,"
                    GamePrint("Success")
                end
            end

			--c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/lua_sharing.xml,data/entities/particles/tinyspark_purple_bright.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
    ]]--
	{   --Thankyou Copi'r for the help!
    id          = "APOTHEOSIS_LUA_SHARING",
    id_matchup  = "TRANSMUTATION",
    name 		= "$spell_apotheosis_lua_sharing_name",
    description = "$spell_apotheosis_lua_sharing_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/lua_sharing.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
    spawn_requires_flag = "apotheosis_card_unlocked_orb_15_spell",  --Ant Hell
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "2,3,4,5,6,10", -- TRANSMUTATION
    spawn_probability                 = "0.3,0.3,0.3,0.3,0.3,0.5", -- TRANSMUTATION
    price = 180,
    mana = 40,
    --max_uses = 8,
    action = function()

        if not reflecting then

            if c.apo_caststate == nil then
                -- Relies on gun.lua haxx refer to "gun_append.lua" if you want to use data transfer haxx
                c.action_description = table.concat(
                    {
                        (c.action_description or ""),
                        "\nCASTSTATE_APOLUASHARE|",
                        GlobalsGetValue("APOTHEOSIS_LUA_SHARING_CAST_STATE", "0"),
                    }
                )
                c.apo_caststate = true
            end
            c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/lua_sharing.xml,"

        end

        --c.fire_rate_wait = c.fire_rate_wait + 20
        draw_actions(1, true)
    end
    },
    {
        id          = "APOTHEOSIS_GLUE_CHARGE",
        id_matchup  = "APOTHEOSIS_FIRE_CHARGE",
        name 		= "$spell_apotheosis_gluecharge_name",
        description = "$spell_apotheosis_gluecharge_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/glue_charge.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/heavy_bullet_unidentified.png",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "1,2,4,5", -- ELECTRIC_CHARGE
        spawn_probability                 = "1,1,1,1", -- ELECTRIC_CHARGE
        price = 160,
        mana = 20,
        --max_uses = 8,
        --custom_xml_file = "data/entities/misc/custom_cards/torch.xml",
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/hitfx_glue_charge.xml,data/entities/particles/tinyspark_white_small.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 30
            draw_actions( 1, true )
        end,
    },
    {   --Conga: Confession, I only made this because of Lua Sharing, and it's so damn worth it
        id          = "APOTHEOSIS_ELECTROSPHERE",
        id_matchup  = "APOTHEOSIS_HOLYORB_SHOTGUN",
        name 		= "$spell_apotheosis_electrosphere_name",
        description = "$spell_apotheosis_electrosphere_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/electrosphere.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
        related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/electrosphere.xml"},
        type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,4,5,6", -- CHAIN_BOLT
		spawn_probability                 = "0.75,1,0.8,0.6", -- CHAIN_BOLT
        price = 240,
        mana = 80,
		action 		= function()
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/electrosphere.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees + 3.6
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
		end,
    },
	{
		id          = "APOTHEOSIS_SEA_BERSERK",
        id_matchup  = "SEA_ACID_GAS",
        name 		= "$spell_apotheosis_sea_berserk_name",
        description = "$spell_apotheosis_sea_berserk_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/sea_berserk.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/sea_acid_unidentified.png",
		related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/sea_berserk.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_rage_aura",
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,4,5,6", -- SEA_ACID
		spawn_probability                 = "0.2,0.2,0.2,0.2", -- SEA_ACID
		price = 350,
		mana = 140,
		max_uses = 3,
		action 		= function()
			add_projectile("mods/Apotheosis/files/entities/projectiles/deck/sea_berserk.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	},
	{
		id          = "APOTHEOSIS_KINDNESS_TO_POWER",
        id_matchup  = "ESSENCE_TO_POWER",
        name 		= "$spell_apotheosis_kindness_to_power_name",
        description = "$spell_apotheosis_kindness_to_power_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/kindness_to_power.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "0.2,0.5,0.5,0.5", -- AREA_DAMAGE
		price = 180,
		mana = 40,
		-- max_uses = 20,
		action 		= function()
            local shooter = GetUpdatedEntityID()
            local x, y = EntityGetTransform(shooter)
            local targets = EntityGetInRadiusWithTag(x, y, 512, "mortal")
            local hotness = 1
            for k=1,#targets
            do local v = targets[k]
                if GameGetGameEffectCount( v, "CHARM" ) > 0 then
                    hotness = hotness + 1
                end
            end
            if c.damage_critical_chance < 50 and hotness > 1 then
                c.damage_critical_chance = 50
            end
			c.damage_critical_chance = (c.damage_critical_chance * hotness)
			draw_actions( 1, true )
		end,
	},
    {
        id          = "APOTHEOSIS_MIND_VISION",
        id_matchup  = "X_RAY",
        name 		= "$spell_apotheosis_mind_vision_name",
        description = "$spell_apotheosis_mind_vision_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mindvision.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_mindvision.xml" },
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "0,1,2,3", -- APOTHEOSIS_MIND_VISION
        spawn_probability                 = "0.5,1,1,0.5", -- APOTHEOSIS_MIND_VISION
        price = 180,
        mana = 10,
        --max_uses = 16,
        action 		= function()
            c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_mindvision.xml,"
            draw_actions( 1, true )
        end,
    },
	{
		id          = "APOTHEOSIS_WATER_POWER",
        id_matchup  = "MANA_REDUCE",
        name 		= "$spell_apotheosis_water_power_name",
        description = "$spell_apotheosis_water_power_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/hydromancy_s.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5,6", -- MANA_REDUCE
		spawn_probability                 = "0.7,0.9,1,1,1,1", -- MANA_REDUCE
		price = 180,
		mana = -30,
		-- max_uses = 20,
		action 		= function()
            if reflecting or GameGetGameEffectCount( GetUpdatedEntityID(), "WET" ) > 0 then
                c.fire_rate_wait    = c.fire_rate_wait - 10
                current_reload_time = current_reload_time - 20
            else
                mana = mana - 30
            end
            draw_actions( 1, true )
		end,
	},
	{
		id          = "APOTHEOSIS_SHAPE_WALL",
		id_matchup  = "PENTAGRAM_SHAPE",
        name 		= "$spell_apotheosis_shape_wall_name",
        description = "$spell_apotheosis_shape_wall_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/wall_shape.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/pentagram_shape_unidentified.png",
		type 		= ACTION_TYPE_DRAW_MANY,
		spawn_level                       = "1,2,3,4,5,6", -- SHAPE_WALL
		spawn_probability                 = "0.5,0.5,0.5,0.5,0.5,0.5", -- SHAPE_WALL
		price = 180,
		mana = 5,
		--max_uses = 100,
		action 		= function()
			c.pattern_degrees = 5
			draw_actions(5, true)
		end,
	},
    --[[
    --Kind of boring, and bloat
	{
		id          = "APOTHEOSIS_SUMMON_STAR_CHILD",
		id_matchup  = "FRIEND_FLY",
        name 		= "$spell_apotheosis_summon_star_child_name",
        description = "$spell_apotheosis_summon_star_child_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/star_child.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/pentagram_shape_unidentified.png",
		spawn_requires_flag = "this_should_never_spawn",
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0", -- Spawns Disabled
		spawn_probability                 = "0", -- Spawns Disabled
		price = 250,
		mana = 200,
		max_uses = 2,
		action 		= function()
			add_projectile("data/entities/animals/player/star_child.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	},
    ]]--
	{
		id          = "APOTHEOSIS_FIRE_WALL",
		id_matchup  = "APOTHEOSIS_LIQUIDSPHERE_TELEPORTATIUM",
        name 		= "$spell_apotheosis_fire_wall_name",
        description = "$spell_apotheosis_fire_wall_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/fire_wall.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/wall_of_fire.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "0,1,2,4,5", -- WALL_VERTICAL
		spawn_probability                 = "0.4,0.4,0.6,0.5,0.2", -- WALL_VERTICAL
		price = 160,
		mana = 70,
		--max_uses = 80,
		action 		= function()
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/wall_of_fire.xml")
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/wall_of_fire.xml")
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/wall_of_fire.xml")
			
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/wall_of_fire_setup.xml")
			c.fire_rate_wait = c.fire_rate_wait + 5
		end,
	},
	{
		id          = "APOTHEOSIS_RANDOM_BURST",
        id_matchup  = "APOTHEOSIS_RANDOM_HOMING",
        name 		= "$spell_apotheosis_random_burst_name",
        description = "$spell_apotheosis_random_burst_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/random_burst.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_pyramid",
		type 		= ACTION_TYPE_DRAW_MANY,
		recursive	= true,
		spawn_level                       = "2,3,4,5,6", -- BURST_4
		spawn_probability                 = "0.4,0.5,0.6,0.6,0.6", -- BURST_4
		price = 120,
		mana = 5,
		action 		= function( recursion_level, iteration )
			draw_actions( math.random(4,8), true )
        end
	},
	{
		id          = "APOTHEOSIS_JUMPER_CABLES",
        id_matchup  = "TENTACLE_TIMER",
		name 		= "$spell_apotheosis_jumper_cables_name",
		description = "$spell_apotheosis_jumper_cables_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/jumper_cables.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/tentacle_unidentified.png",
		related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/jumper_cable_black.xml", 2},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "3,4,5,6", -- TENTACLE
		spawn_probability                 = "1,0.5,1,0.8", -- TENTACLE
		price = 200,
		mana = 40,
		--max_uses = 40,
		custom_xml_file = "data/entities/misc/custom_cards/electric_charge.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 40
            c.spread_degrees = c.spread_degrees + 30.0
            if reflecting then
                --Stops the game from getting angry
			    Reflection_RegisterProjectile("mods/apotheosis/files/entities/projectiles/deck/jumper_cable_black.xml")
            else
				add_projectile("mods/apotheosis/files/entities/projectiles/deck/jumper_cable_red.xml")
				add_projectile("mods/apotheosis/files/entities/projectiles/deck/jumper_cable_black.xml")
            end
		end,
	},
	{
		id          = "APOTHEOSIS_CHI",
        id_matchup  = "SIGMA",
		name 		= "$spell_apotheosis_chi_name",
		description = "$spell_apotheosis_chi_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/chi.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_duplicate",
		type 		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level                       = "5,6,10", -- MANA_REDUCE
		spawn_probability                 = "0.1,0.2,1", -- MANA_REDUCE
		price = 500,
		mana = 120,
		action 		= function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50
			
			local firerate = c.fire_rate_wait
			local reload = current_reload_time
			local mana_ = mana
			
			if ( discarded ~= nil ) then
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= "RESET" ) and ( rec > -1 ) then
						dont_draw_actions = true
						data.action( rec )
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= "RESET" ) and ( rec > -1 ) then
						dont_draw_actions = true
						data.action( rec )
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_UTILITY ) and ( data.id ~= "RESET" ) and ( rec > -1 ) then
						dont_draw_actions = true
						data.action( rec )
						dont_draw_actions = false
					end
				end
			end
			
			c.fire_rate_wait = firerate
			current_reload_time = reload
			mana = mana_
		end,
	},
    --[[
    ]]--
    --Grab related projectiles after confirming spell is an alt-fire
    --This can't find subtype data in the wand for some reason?
    --Might be able to use EzWand..?
	{
		id          = "APOTHEOSIS_KAPPA",
        id_matchup  = "APOTHEOSIS_CHI",
		name 		= "$spell_apotheosis_kappa_name",
		description = "$spell_apotheosis_kappa_desc",
        sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/kappa.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_duplicate",
		type 		= ACTION_TYPE_OTHER,
		recursive	= true,
        spawn_level                       = "10", -- Conversion spell
        spawn_probability                 = "0.01", -- Conversion spell
		price = 500,
		mana = 120,
		action 		= function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50

			
			if ( discarded ~= nil ) then
                for k=1,#discarded
                do local v = discarded[k]
                    if ( v.type == ACTION_TYPE_PASSIVE ) and ( v.custom_uses_logic ) and (v.id ~= "APOTHEOSIS_ALT_FIRE_COV" or GameHasFlagRun("apotheosis_flag_copy_spells")) then
                        add_projectile(v.related_projectiles[1])
                    end
                end
            end

			
			if ( deck ~= nil ) then
                for k=1,#deck
                do local v = deck[k]
                    if ( v.type == ACTION_TYPE_PASSIVE ) and ( v.custom_uses_logic ) and (v.id ~= "APOTHEOSIS_ALT_FIRE_COV" or GameHasFlagRun("apotheosis_flag_copy_spells")) then
                        add_projectile(v.related_projectiles[1])
                    end
                end
            end

			
			if ( hand ~= nil ) then
                for k=1,#hand
                do local v = hand[k]
                    if ( v.type == ACTION_TYPE_PASSIVE ) and ( v.custom_uses_logic ) and (v.id ~= "APOTHEOSIS_ALT_FIRE_COV" or GameHasFlagRun("apotheosis_flag_copy_spells")) then
                        add_projectile(v.related_projectiles[1])
                    end
                end
            end
			
		end,
	},

    --[[
    --Can't name anything specific, I just don't like it, maybe it's because the ui icon is janky as hell
    --Also feels like it isn't very thought provoking, I mean, I guess if you have access to blood you may as well put it on for x2 damage, right?
    --It doesn't radically change your wand setup, it's just a switch of "I have blood" or "I don't have blood"
    --Hydromancy can make or break your wand if you're wet
	{
		id          = "APOTHEOSIS_BLOOD_POWER",
        id_matchup  = "APOTHEOSIS_WATER_POWER",
        name 		= "$spell_apotheosis_blood_power_name",
        description = "$spell_apotheosis_blood_power_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/hemomancy.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5,6", -- MANA_REDUCE
		spawn_probability                 = "0.7,0.9,1,1,1,1", -- MANA_REDUCE
		price = 180,
		mana = 30,
		-- max_uses = 20,
		action 		= function()
            draw_actions( 1, true )
            if reflecting then
                --Stops the game from getting angry
            else
                local entity_id = GetUpdatedEntityID()
                if GameGetGameEffectCount( entity_id, "BLOODY" ) > 0 then
                    if not c.extra_entities:find("mods/apotheosis/files/entities/misc/piercing_handler.xml,") then
                        c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/piercing_handler.xml,"
                    end
                    c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/piercing_shot_2.xml,"
                end
            end
		end,
	},
    ]]--
	{
		id          = "APOTHEOSIS_SHOT_WALL",
		id_matchup  = "PENTA_SHOT",
        name 		= "$spell_apotheosis_shot_wall_name",
        description = "$spell_apotheosis_shot_wall_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/wall_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/pentagram_shape_unidentified.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "3,4,5,6,10", -- I_SHAPE
		spawn_probability                 = "0.1,0.2,0.5,0.5,0.2", -- I_SHAPE
		price = 180,
		mana = 110,
		max_uses = 20,
		action 		= function()
			local data
			
			if ( #deck > 0 ) then
				data = deck[1]
			end
			
			if ( data ~= nil ) and ( ( data.type == ACTION_TYPE_PROJECTILE ) or ( data.type == ACTION_TYPE_STATIC_PROJECTILE ) ) and ( data.related_projectiles ~= nil ) and ( ( data.uses_remaining == nil ) or ( data.uses_remaining ~= 0 ) ) then
				local count = 5
				for i=1,count-1 do
					if ( mana >= data.mana ) then
						local proj = data.related_projectiles[1]
						local proj_count = data.related_projectiles[2] or 1
						
						for a=1,proj_count do
							add_projectile(proj)
						end
						
						mana = mana - data.mana
					else
						OnNotEnoughManaForAction()
						break
					end
				end
			end

			c.pattern_degrees = 5
			
			draw_actions(1, true)
		end,
	},
	{
		id          = "APOTHEOSIS_POLLEN_TRIGGER",
		id_matchup  = "POLLEN",
		name 		= "$spell_apotheosis_pollen_trigger_name",
		description = "$spell_apotheosis_pollen_trigger_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/pollen_trigger.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/arrow_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/pollen.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",   --These are only unlocked after killing the blob boss to not interfere with the new player experience, don't want people's first impression with new spells to be. "Oh, it's vanilla spells but rebranded, bruh"
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,3,4", -- ARROW
		spawn_probability                 = "0.4,0.8,0.8,0.4", -- ARROW
		price = 110,
		mana = 20,
		--max_uses = 40,
		action 		= function()
			add_projectile_trigger_hit_world("data/entities/projectiles/deck/pollen.xml", 1)
			-- damage = 0.3
			c.fire_rate_wait = c.fire_rate_wait + 2
			c.spread_degrees = c.spread_degrees + 20
		end,
	},
	{
		id          = "APOTHEOSIS_RUBBER_BALL_TRIGGER",
		id_matchup  = "RUBBER_BALL",
		name 		= "$spell_apotheosis_rubberball_trigger_name",
		description = "$spell_apotheosis_rubberball_trigger_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/rubber_ball_trigger.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rubber_ball_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/rubber_ball.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",   --These are only unlocked after killing the blob boss to not interfere with the new player experience, don't want people's first impression with new spells to be. "Oh, it's vanilla spells but rebranded, bruh"
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "1,2,10", -- RUBBER_BALL
		spawn_probability                 = "0.8,0.8,0.1", -- RUBBER_BALL
		price = 60,
		mana = 10,
		--max_uses = 150,
		action 		= function()
			add_projectile_trigger_death("mods/apotheosis/files/entities/projectiles/deck/rubber_ball_trigger.xml", 1)
			-- damage = 0.3
			c.fire_rate_wait = c.fire_rate_wait - 2
			c.spread_degrees = c.spread_degrees - 1.0
		end,
	},
	{
		id          = "APOTHEOSIS_BLOOD_POWER",
        id_matchup  = "APOTHEOSIS_WATER_POWER",
        name 		= "$spell_apotheosis_blood_power_name",
        description = "$spell_apotheosis_blood_power_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/hemomancy_s.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_boss_flesh_monster_spell",  --Requires Heretic to be slain
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,4,5,6", -- CHAIN_BOLT
		spawn_probability                 = "0.75,1,0.8,0.6", -- CHAIN_BOLT
		price = 180,
		mana = 20,
		-- max_uses = 20,
		action 		= function()
            if not reflecting and GameGetGameEffectCount( GetUpdatedEntityID(), "BLOODY" ) > 0 then
                --c.friendly_fire		= true
                if not c.extra_entities:find("mods/apotheosis/files/entities/misc/piercing_handler.xml,") then
                    c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/piercing_handler.xml,"
                end
                c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_blood.xml,data/entities/misc/piercing_shot_hemomancy.xml,"
            end
            c.fire_rate_wait    = c.fire_rate_wait + 20
            draw_actions( 1, true )
		end,
	},
	{
		id          = "APOTHEOSIS_FIRE_POWER",
        id_matchup  = "APOTHEOSIS_BLOOD_POWER",
        name 		= "$spell_apotheosis_fire_power_name",
        description = "$spell_apotheosis_fire_power_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/pyromancy_s.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_fire_lukki_spell",  --Requires Aesthete of Heat to be slain
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,4,5,6", -- CHAIN_BOLT
		spawn_probability                 = "0.75,1,0.8,0.6", -- CHAIN_BOLT
		price = 180,
		mana = 20,
		-- max_uses = 20,
		action 		= function()
            if not reflecting and GameGetGameEffectCount( GetUpdatedEntityID(), "ON_FIRE" ) > 0 then
                --Conga: Handle this with an entity on the projectile itself to catch inherent damage
                c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/fire_power_handler.xml,"
                c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_on_fire.xml,"
                c.extra_entities = c.extra_entities .. "data/entities/misc/burn_wide.xml,"
            end
            draw_actions( 1, true )
		end,
	},
    --[[
	{
		id          = "APOTHEOSIS_SUMMON_POTION",
        name 		= "$spell_apotheosis_potion_name",
        description = "$spell_apotheosis_potion_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/potion.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_ending_apotheosis_02_spell",  --Requires Ascension
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "0,1,2,10", -- CHAIN_BOLT
		spawn_probability                 = "0.05,0.05,0.05,0.1", -- CHAIN_BOLT
		price = 250,
		mana = 200,
		max_uses = 1,
        never_unlimited = true,
		action 		= function()
            if not reflecting then
                local x,y = EntityGetTransform(GetUpdatedEntityID())
                EntityLoad("data/entities/items/pickup/potion.xml", x + math.random(-2,2), y + math.random(-2,2))
                GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/potion/create", x, y )
            end
		end,
	},
    ]]--
    --[[
	{
		id          = "APOTHEOSIS_TOUCH_GRASS",
        --name 		= "$spell_apotheosis_touch_grass_name",
        --description = "$spell_apotheosis_touch_grass_desc",
        name 		= "Touch of Grass",
        description = "Transmutes everything in a short radius into grass, including walls, creatures... and you",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/touch_grass.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"mods/apotheosis/files/entities/projectiles/deck/touch_grass.xml"},
        spawn_requires_flag = "apotheosis_card_unlocked_ending_apotheosis_02_spell",  --Requires Ascension
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_GOLD
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.5", -- TOUCH_GOLD
		price = 480,
		mana = 300,
		max_uses    = 1,
		never_unlimited = true,
		action 		= function()
			add_projectile("mods/apotheosis/files/entities/projectiles/deck/touch_grass.xml")
		end,
	},
    ]]--
    --[[
	{
        --Conga: Extremely easy to infinitely dupe Ambrosia, is it that bad though? You can only actively carry so much at once
        --Spell is fully functional, just unsure if I want to implement it, sort of has the same problem summon potion has where you could "somewhat" afk farm for materials that are meant to force you to adventure to collect
		id          = "APOTHEOSIS_POTION_TO_SEA",
        --id_matchup  = "APOTHEOSIS_BLOOD_POWER",
        name 		= "$spell_apotheosis_potion_to_sea_name",
        description = "$spell_apotheosis_potion_to_sea_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/potion.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
        --spawn_requires_flag = "apotheosis_card_unlocked_ending_apotheosis_02_spell",  --Requires Ascension --Previously this required ending 2 to appear, but considering how it'd change daily RNG as well as most people likely not  going throuh the work to unlock it, I ultiamtely decided to keep it as a "regular" spell
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "0,1,2,3,10", -- CHAIN_BOLT
		spawn_probability                 = "0.05,0.05,0.05,0.05,0.1", -- CHAIN_BOLT
		price = 250,
		mana = 200,
		max_uses = 1,
        never_unlimited = true,
		action 		= function()
            if not reflecting then
                local x,y = EntityGetTransform(GetUpdatedEntityID())

                --Get material
                local potion = nil
                local inventories = EntityGetAllChildren(GetUpdatedEntityID()) or {}
                for inventory_index = 1, #inventories do
                    if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
                        -- Find last potion tagged item
                        local children = EntityGetAllChildren(inventories[inventory_index]) or {}
                        for i = 1, #children do
                            if EntityHasTag(children[i], "potion") then
                                potion = children[i]
                                break
                            end
                        end
                        break
                    end
                end


                
                if potion ~= nil then
                    local e = EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/sea_any.xml", x, y)
                    GamePlaySound( "data/audio/Desktop/materials.bank", "collision/glass_potion/destroy", x, y )
                    local mat = GetMaterialInventoryMainMaterial(potion)

                    local comp = EntityAddComponent2(
                        e,
                        "MaterialSeaSpawnerComponent",
                        {
                            speed=10,
                            noise_threshold=0.0,
                            material=mat,
                        }
                    )
                    ComponentSetValue2(comp, "size", 300, 256)
                    ComponentSetValue2(comp, "offset", 0, 158)

                    local comp = EntityAddComponent2(
                        e,
                        "ParticleEmitterComponent",
                        {
                            emitted_material_name=CellFactory_GetName(mat),
                            lifetime_min=6,
                            lifetime_max=8,
                            count_min=8,
                            count_max=8,
                            render_on_grid=true,
                            fade_based_on_lifetime=true,
                            cosmetic_force_create=false,
                            airflow_force=0.51,
                            airflow_time=1.01,
                            airflow_scale=0.05,
                            x_pos_offset_min=0,
                            x_pos_offset_max=0,
                            y_pos_offset_min=0,
                            y_pos_offset_max=0,
                            emission_interval_min_frames=1,
                            emission_interval_max_frames=1,
                            emit_cosmetic_particles=true,
                            image_animation_file="mods/apotheosis/files/particles/image_emitters/sea_any.png",
                            image_animation_speed=5,
                            image_animation_loop=false,
                            is_emitting=true,
                        }
                    )
                    ComponentSetValue2(comp, "gravity", 0, 0)
                    ComponentSetValue2(comp, "area_circle_radius", 0, 0)
                    EntityKill(potion)
                end
            end
		end,
	}
    ]]--
}

if ModSettingGet( "Apotheosis.organised_icons" ) == true then
    for k=1,#apotheosis_spellappends
    do local v = apotheosis_spellappends[k]
        v.author    = v.author  or "Conga Lyne"
        v.mod       = v.mod     or "Apotheosis"
        if v.id_matchup == nil then
            table.insert(actions,v)
        else
            for z=1,#actions
            do c = actions[z]
                if c.id == v.id_matchup or z == #actions then
                    table.insert(actions,z + 1,v)
                    break
                end
            end
        end
    end
else
    for k=1,#apotheosis_spellappends
    do local v = apotheosis_spellappends[k]
        v.author    = v.author  or "Conga Lyne"
        v.mod       = v.mod     or "Apotheosis"
        table.insert(actions,v)
    end
end






-- Checks if a spell is being cast by a greek letter & if you have the perk which allows it
-- Not completely sure why, but this feels like a bad solution, wrong, is it because it isn't 'absolute'?
function disablecopying(recursion_level)
    if (recursion_level) ~= nil and GameHasFlagRun("apotheosis_flag_copy_spells") == false then return true
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
--[[
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
]]--


local actions_to_edit = {
    --Death Cross becomes cheaper
    ["DEATH_CROSS"] = {
        mana = 40
    },

    --Giga Death Cross becomes cheaper
    --Fix Giga Death Cross to use green sparks instead of blue ones
    ["DEATH_CROSS_BIG"] = {
        mana = 100,
        custom_xml_file = "mods/apotheosis/files/entities/misc/custom_cards/death_cross_big.xml"
    },

    -- Copi: describe this
    -- Reduced mana cost of Concentrated Light to be more appropriate for it's functionality & spell tier
    ["MEGALASER"] = {
        mana = 80
    },

    --Spitter Bolt Tier 2 & 3 becomes cheaper
    ["SPITTER_TIER_2"] = {
        mana = 10
    },
    ["SPITTER_TIER_2_TIMER"] = {
        mana = 15
    },
    ["SPITTER_TIER_3"] = {
        mana = 15
    },
    ["SPITTER_TIER_3_TIMER"] = {
        mana = 20
    },

    --Reduce mana cost of Chaotic Transmutation so it's more feasible to use for lua disabling
    ["TRANSMUTATION"] = {
        mana = 40
    },

    --Increase frequency of acceleration/Rotate towards foes appearing, makes acceleration builds more accessible
    ["ACCELERATING_SHOT"] = {
        spawn_level         = "1,2,3,4,5,10",
        spawn_probability   = "0.5,1,1,1,0.5,0.1"
    },

    --Allow Path of Darkflame to spawn in lower tier spell pools, it's a great early game spell but you only ever find it mid-late game, by then it's garbage
    ["DARKFLAME"] = {
        spawn_level         = "1,2,3,5,6",
        spawn_probability   = "0.8,0.8,1,0.9,0.8"
    },

    --Chainsaw mana cost increase, forces you to expend all your mana for making a rapidfire build early on
    --[[ COPI: This is incredibly based, thank you conga ]]
    ["CHAINSAW"] = {
        mana = 12
    },

    --Slightly buff Explosive Bounce by reducing the spell cost & removing the recoil effect from the modifier
    ["BOUNCE_EXPLOSION"] = {
        price = 90,
        subtype = {
            bounce=true,
        },
        action = function ()
            c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_explosion.xml,"
            c.bounces = c.bounces + 1
            c.fire_rate_wait = c.fire_rate_wait + 25
            draw_actions( 1, true )
        end
    },

    --Slightly buff Bubbly Bounce by reducing the spell cost & removing the recoil effect from the modifier, also does no self-damage
    ["BOUNCE_SPARK"] = {
        price = 60,
        subtype = {
            bounce=true,
        },
        action = function()
            c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_spark.xml,"
            c.bounces = c.bounces + 1
            c.fire_rate_wait = c.fire_rate_wait + 8
            draw_actions( 1, true )
        end
    },

    --Slightly buff Plasma Beam Bounce by reducing the spell cost & removing the recoil effect from the modifier
    ["BOUNCE_LASER_EMITTER"] = {
        price = 90,
        subtype = {
            bounce=true,
        },
        action = function()
            c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_laser_emitter.xml,"
            c.bounces = c.bounces + 1
            c.fire_rate_wait = c.fire_rate_wait + 12
            draw_actions( 1, true )
        end
    },

    --Slightly buff Plasma Beam Bounce by reducing the spell cost & removing the recoil effect from the modifier
    ["BOUNCE_LASER"] = {
        price = 90,
        subtype = {
            bounce=true,
        },
        action = function()
            c.extra_entities = c.extra_entities .. "data/entities/misc/bounce_laser.xml,"
            c.bounces = c.bounces + 1
            c.fire_rate_wait = c.fire_rate_wait + 12
            draw_actions( 1, true )
        end
    },

    --Apply bounce subtype to bounce larpa for random bounce
    --Conga: or, whatever else Copi is up to
    -- Copi:    Wait, BBOUNCE? Is that a typo???
    -- Copi:    I forgot why I did this, I plan to subtype a few spells in my own mod for categories or something, though a random bounce spell sounds really funny if its quite cheap
    ["BOUNCE_LARPA"] = {
        subtype = {
            bounce=true,
        },
        mandatory_addition = true
    },

    -- Copi:    change this to reflect the changes better
    -- Conga:   What do you mean?
    --          Side note, please add your name to any future comments here on out if possible if it's personal thoughts rather than code documentation, I'll try to do the same, it'll be way, way easier to keep track of who's asking what that way.
    -- Copi:    by this I mean changing the line above the change 'Update Piercing's Spell Description & code to showcase it's new functionality' to reflect what the rework actually does
    --Update Piercing's Spell Description & code to showcase it's new functionality
    --Piercing now lets a projectile hit an enemy 5 times per piercing modifier
    --If a projectile pierces more than 50 times, it gains infinite piercing, still allowing for infiniwisps to exist
    ["PIERCING_SHOT"] = {
        description = "$spell_apotheosis_piercing_shot_desc",
        mana = 60,
        action = function()
            --c.damage_projectile_add = c.damage_projectile_add - 0.6
            c.friendly_fire		= true
            if not c.extra_entities:find("mods/apotheosis/files/entities/misc/piercing_handler.xml,") then
                c.extra_entities = c.extra_entities .. "mods/apotheosis/files/entities/misc/piercing_handler.xml,"
            end
            c.extra_entities = c.extra_entities .. "data/entities/misc/piercing_shot.xml,"
            draw_actions(1, true)
        end
    },

    --I feel worried that I'm tinkering with the base game a bit too much here
    --[[ COPI: I think it's alright :^) ]]
    ["REGENERATION_FIELD"] = {
        spawn_level         = "1,2,3,4,10",
        spawn_probability   = "0.2,0.2,0.2,0.2,1.2",
        mandatory_addition = true
    },

    --Makes Giant Explosion Spells infinite use, they're extremely rare, conditional & mana hungry, so why make them limited use too? Seems a bit overkill for something that's just a slightly weaker holy bomb; plus material spell + gigaexplosion is a crazy fun spell combo
    ["HITFX_EXPLOSION_ALCOHOL_GIGA"] = {
        max_uses = -1,
    },
    ["HITFX_EXPLOSION_SLIME_GIGA"] = {
        max_uses = -1,
    },

    --[[
    Spells to Power only spawns in Heaven/Hell, or other T10 spell spawn locations
    If the player wants an infinite damage wand, they need to visit a dangerous biome and put their life at risk
    With great power comes great sacrifice
    NOTE, may want to add an extra "unique spawnpool" for certain funky spells, like StP
    This forces you to visit endgame biomes if you want endgame dps
    ]]
    --[[ COPI: Unique spawnpool sounds sick as hell ]]
    ["SPELLS_TO_POWER"] = {
        spawn_level         = "10",
        spawn_probability   = "1.0"
    },

    ["HEAVY_SHOT"] = {
		spawn_level                       = "2,3,4,10", -- HEAVY_SHOT
		spawn_probability                 = "0.4,0.4,0.5,0.1" -- HEAVY_SHOT
    },

    --Changes Summon Egg to implement modded Apotheosis eggs in
    ["SUMMON_EGG"] = {
        action = function()
            SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
            local types = {"egg_monster","egg_slime","egg_red","egg_fire","apotheosis/egg_fairy","apotheosis/egg_mud","apotheosis/egg_robot"}
            local rnd = Random(1, #types)
            add_projectile(table.concat{"data/entities/items/pickup/", types[rnd], ".xml"})
        end,
        mandatory_addition = true
    },

    --Changes Summon Taikasauva to allow proper creature shift functionality
    ["SUMMON_WANDGHOST"] = {
        action = function()
            if not reflecting then
                local filepath = GlobalsGetValue( "apotheosis_wandghost_filepath", "data/entities/projectiles/deck/wand_ghost_player.xml" )
                add_projectile(filepath)
                add_projectile("data/entities/particles/image_emitters/wand_effect.xml")
            end
        end,
        mandatory_addition = true
    },

    --Arrow doesn't have increased recoil
    ["ARROW"] = {
        action = function()
            add_projectile("data/entities/projectiles/deck/arrow.xml")
            c.fire_rate_wait = c.fire_rate_wait + 10
            c.spread_degrees = c.spread_degrees - 20
        end
    },

    -- Homing subtype data
    ["HOMING"] = {
        subtype = { homing=true },
        mandatory_addition = true
    },
    ["HOMING_SHORT"] = {
        subtype = { homing=true },
        mandatory_addition = true
    },
    -- Increase frequency of acceleration/Rotate towards foes appearing, makes acceleration builds more accessible
    ["HOMING_ROTATE"] = {
        spawn_level         = "2,3,4,5,6,10",
        spawn_probability   = "0.6,0.8,1,1,0.6,0.1",
        subtype = { homing=true },
        mandatory_addition = true
    },
    ["AUTOAIM"] = {
        subtype = { homing=true },
        mandatory_addition = true
    },
    ["HOMING_ACCELERATING"] = {
        subtype = { homing=true },
        mandatory_addition = true
    },
    ["HOMING_CURSOR"] = {
        subtype = { homing=true },
        mandatory_addition = true
    },
    ["HOMING_AREA"] = {
        subtype = { homing=true },
        mandatory_addition = true
    },

    --Conga: Actually, this was unneccessary, bastard still worms it's way in
    --Definitely impossible to find when you add the new copis spells into the mix with apotheosis though
    --[[
    ["MANA_REDUCE"] = {
        spawn_level         = "1,2,3,4,5,6",
        spawn_probability   = "1,1,1,1,1,1",
    },
    ]]--
}

--[[
for i=1,#actions do -- fast as fuck boi
    if actions_to_edit[actions[i].id] then
        for key, value in pairs(actions_to_edit[actions[i].id]) do
            actions[i][key] = value
        end
        actions[i]['apotheosis_reworked'] = true
    end
end
]]--

--Script should scan through each item, and if rebalances are enabled, it'll do all of them; otherwise only do mandatory additions
--Not currently enabled, but would just need to be uncommented in theory.
for i=1,#actions do -- fast as fuck boi
    if actions_to_edit[actions[i].id] and (ModSettingGet( "Apotheosis.spellrebalances" ) or actions_to_edit[actions[i].id].mandatory_addition) then
        for key, value in pairs(actions_to_edit[actions[i].id]) do
            actions[i][key] = value
        end
        actions[i]['apotheosis_reworked'] = true
    end
end











--Something Special
--[[
if HasFlagPersistent( "apotheosis_card_unlocked_ending_apotheosis_02_spell" ) then
    local v = 
	{
		id          = "APOTHEOSIS_POTION_TO_SEA",
        name 		= "$spell_apotheosis_potion_to_sea_name",
        description = "$spell_apotheosis_potion_to_sea_desc",
		sprite 		= "mods/apotheosis/files/ui_gfx/gun_actions/potion.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
        spawn_requires_flag = "apotheosis_card_unlocked_ending_apotheosis_02_spell",  --Requires Ascension
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "0,1,2,3,10", -- CHAIN_BOLT
		spawn_probability                 = "0.05,0.05,0.05,0.05,0.1", -- CHAIN_BOLT
		price = 250,
		mana = 200,
		max_uses = 1,
        never_unlimited = true,
		action 		= function()
            if not reflecting then
                local x,y = EntityGetTransform(GetUpdatedEntityID())
                local e = EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/sea_any.xml", x, y)
                GamePlaySound( "data/audio/Desktop/materials.bank", "collision/glass_potion/destroy", x, y )

                --Get material
                local potion = nil
                local inventories = EntityGetAllChildren(GetUpdatedEntityID()) or {}
                for inventory_index = 1, #inventories do
                    if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
                        -- Find last potion tagged item
                        local children = EntityGetAllChildren(inventories[inventory_index]) or {}
                        for i = 1, #children do
                            if EntityHasTag(children[i], "potion") then
                                potion = children[i]
                                break
                            end
                        end
                        break
                    end
                end


                
                local mat = GetMaterialInventoryMainMaterial(potion) or nil

                if mat ~= nil then
                    local comp = EntityAddComponent2(
                        e,
                        "MaterialSeaSpawnerComponent",
                        {
                            speed=10,
                            noise_threshold=0.0,
                            material=mat,
                        }
                    )
                    ComponentSetValue2(comp, "size", 300, 256)
                    ComponentSetValue2(comp, "offset", 0, 158)

                    local comp = EntityAddComponent2(
                        e,
                        "ParticleEmitterComponent",
                        {
                            emitted_material_name=CellFactory_GetName(mat),
                            lifetime_min=6,
                            lifetime_max=8,
                            count_min=8,
                            count_max=8,
                            render_on_grid=true,
                            fade_based_on_lifetime=true,
                            cosmetic_force_create=false,
                            airflow_force=0.51,
                            airflow_time=1.01,
                            airflow_scale=0.05,
                            x_pos_offset_min=0,
                            x_pos_offset_max=0,
                            y_pos_offset_min=0,
                            y_pos_offset_max=0,
                            emission_interval_min_frames=1,
                            emission_interval_max_frames=1,
                            emit_cosmetic_particles=true,
                            image_animation_file="mods/apotheosis/files/particles/image_emitters/sea_any.png",
                            image_animation_speed=5,
                            image_animation_loop=false,
                            is_emitting=true,
                        }
                    )
                    ComponentSetValue2(comp, "gravity", 0, 0)
                    ComponentSetValue2(comp, "area_circle_radius", 0, 0)
                    EntityKill(potion)
                end
            end
		end,
	}
    v.author    = v.author  or "Conga Lyne"
    v.mod       = v.mod     or "Apotheosis"
    table.insert(actions,v)
end
]]--
