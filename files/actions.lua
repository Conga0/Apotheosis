--spell is non-functional, intention is after every bounce, the projectile will redirect itself towards an enemy but I am failing to create this behaviour.
--I think it would be interesting, but is not proving worth the development time demanded so far.
--I may return to this at some point if I have a confident theory on how to get it working.
--
--Brooo "Trickshot" would like, totally be a killer name for this
--[[table.insert(actions,
{
    id          = "APOTHEOSIS_BOUNCE_HOMING",
    name 		= "Autoaiming Bounce",
    description = "Your spells redirect themselves into an enemy upon every bounce",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/APOTHEOSIS_bounce_homing.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/sinewave_unidentified.png",
    related_extra_entities = { "mods/Apotheosis/files/entities/misc/bounce_homing.xml" },
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "1,2,3,4,6,7", -- BOUNCE_HOMING
    spawn_probability                 = "0.1,0.5,0.7,0.6,0.6,0.3", -- BOUNCE_HOMING
    price = 200,
    mana = 20,
    --max_uses = 150,
    action 		= function()
        c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/bounce_homing.xml,data/entities/particles/tinyspark_white.xml,"
        c.bounces = c.bounces + 1
        c.fire_rate_wait = c.fire_rate_wait + 8
        shot_effects.recoil_knockback = shot_effects.recoil_knockback + 5.0
        draw_actions( 1, true )
    end,
})]]--

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
    mana = 90,
    max_uses = 20,
    action 		= function()
        c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_nuke_ray_enemy.xml,"
        draw_actions( 1, true )
    end,
})

table.insert(actions,
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
})

--[[
table.insert(actions,
{
    id          = "APOTHEOSIS_HOLYORB_SHOTGUN_CURSED",
    name 		= "$spell_apotheosis_cursed_orb_barrage_name",
    description = "$spell_apotheosis_cursed_orb_barrage_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/orb_holy_shotgun_cursed.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml", 7},
    spawn_requires_flag = "apotheosis_card_unlocked_divinebeing_spell",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "10",
    spawn_probability                 = "0.02",
    price = 220,
    mana = 80,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun_cursed.xml")
        c.fire_rate_wait = c.fire_rate_wait + 12
        c.spread_degrees = c.spread_degrees + 30.0
        current_reload_time = current_reload_time + 15
    end,
})
]]--

table.insert(actions,   --This spell is kinda weird
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

--[[
table.insert(actions,
{
    id          = "APOTHEOSIS_TEST_HOLY_BEAM",
    name 		= "Divine Light",
    description = "Creates a holy beam of divine light after 5 seconds, unbias to all it harms.",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/divine_light.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/dynamite_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/beam_holy_warning_player.xml"},
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "4,5,6,10", -- Divine Light
    spawn_probability                 = "0.5,0.5,0.5,1", -- Divine Light
    price = 220,
    mana = 100,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/beam_holy_warning_player.xml")
        c.fire_rate_wait = c.fire_rate_wait + 120
    end,
})
]]--

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
{
    id          = "APOTHEOSIS_REVERBERATION",
    name 		= "$spell_apotheosis_reverberation_name",
    description = "$spell_apotheosis_reverberation_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/reverberation.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/field_reverberation.xml"},
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
})

table.insert(actions,
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
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/rat_bite.xml")
        c.damage_critical_chance = c.damage_critical_chance + 10
    end,
})

table.insert(actions,
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
})

--[[
table.insert(actions,
{
    id          = "APOTHEOSIS_SUMMON_WORM_BIG",
    name 		= "$spell_apotheosis_summon_worm_name",
    description = "$spell_apotheosis_summon_worm_desc", --Triggers a fungal shift, no cooldown.
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/summon_worm_big.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
    related_extra_entities = { "mods/Apotheosis/files/entities/projectiles/deck/summon_worm_big.xml" },
    spawn_requires_flag = "apotheosis_card_unlocked_boss_toxic_worm_spell",
    never_unlimited		= true,
    type 		= ACTION_TYPE_STATIC_PROJECTILE,
    spawn_level                       = "10", -- Conversion spell
    spawn_probability                 = "0.01", -- Conversion spell
    price = 250,
    mana = 225,
    max_uses = 3,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/summon_worm_big.xml")
        c.fire_rate_wait = c.fire_rate_wait + 90
        current_reload_time = current_reload_time + 60
    end,
})
]]--

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
        current_reload_time = current_reload_time + 60
    end,
})

table.insert(actions,
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
})

--I want this to have x2 mana cost for the cast if you use it but need to wait for copi lib to make it happen
table.insert(actions,
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
})

--Unfortunately these aren't as great spells as you'd think, even with perfect tracking.
--[[
table.insert(actions,
{
    id          = "APOTHEOSIS_CLOUD_ACID_PERSONAL",
    name 		= "Personal Acid Cloud",
    description = "Makes a projectile curse the creatures it hits with a cloud of Acid",
    sprite 		= "data/ui_gfx/gun_actions/cloud_acid.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
    related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_cloud_acid.xml" },
    spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "0,1,2,3,4,5", -- CLOUD_ACID
    spawn_probability                 = "0.2,0.2,0.2,0.2,0.2,0.2", -- CLOUD_ACID
    price = 180,
    mana = 90,
    max_uses = 8,
    action 		= function()
        c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_cloud_acid.xml,"
        draw_actions( 1, true )
    end,
})

table.insert(actions,
{
    id          = "APOTHEOSIS_CLOUD_THUNDER_PERSONAL",
    name 		= "Personal Thunder Cloud",
    description = "Makes a projectile curse the creatures it hits with a cloud of Thunder",
    sprite 		= "data/ui_gfx/gun_actions/cloud_thunder.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
    related_extra_entities = { "mods/Apotheosis/files/entities/misc/hitfx_cloud_thunder.xml" },
    spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "0,1,2,3,4,5", -- CLOUD_THUNDER
    spawn_probability                 = "0.3,0.3,0.3,0.3,0.3,0.3", -- CLOUD_THUNDER
    price = 190,
    mana = 90,
    max_uses = 12,
    action 		= function()
        c.extra_entities = c.extra_entities .. "mods/Apotheosis/files/entities/misc/hitfx_cloud_thunder.xml,"
        draw_actions( 1, true )
    end,
})]]--

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

--Wait.. is burning trail literally just fire charge but not called fire charge..? Keep your naming consistency together Noita please
--I do want a spell which lets me do fire damage though.. so...
table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})

table.insert(actions,
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
})



-------------------------------------------- Apotheosis New Content Below ------------------------------------------------------------------------------

table.insert(actions,
{
    id          = "APOTHEOSIS_SPELLS_TO_CURSOR",
    name 		= "$spell_apotheosis_spells_to_cursor_name",
    description = "$spell_apotheosis_spells_to_cursor_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/spells_to_cursor.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/spells_to_cursor.xml"},
    spawn_requires_flag = "apotheosis_card_unlocked_orb_12_spell",
    type 		= ACTION_TYPE_UTILITY,
    spawn_level                       = "3,4,6,9", -- spells to Cats
    spawn_probability                 = "0.4,0.4,0.4,0.5", -- spells to Cats
    price = 600,
    mana = 220,
    --max_uses = 1000,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/spells_to_cursor.xml")
        c.fire_rate_wait = c.fire_rate_wait + 50
        current_reload_time = current_reload_time + 45
    end,
})

--Bloat, Intention behind these spells was to remove stain effects very quickly, specifically for countering Masters of Immortality, but these have all been merged into one spell: "Mass Dry"
--Exception to this is mass chaotic polymorph, because it's a liiil funny
--[[
table.insert(actions,
{
    id          = "APOTHEOSIS_MASS_STATUS_DRUNK_INTENSE",
    name 		= "$spell_apotheosis_status_drunk_intense_name",
    description = "$spell_apotheosis_status_drunk_intense_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_intense_alcohol.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_drunk_intense.xml"},
    spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
    type 		= ACTION_TYPE_UTILITY,
    spawn_level                       = "10", -- Conversion spell
    spawn_probability                 = "0.01", -- Conversion spell
    price = 180,
    max_uses    = 20,
    mana = 100,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_drunk_intense.xml")
        c.fire_rate_wait = c.fire_rate_wait + 100
        current_reload_time = current_reload_time + 60
    end,
})

table.insert(actions,
{
    id          = "APOTHEOSIS_MASS_STATUS_WET_INTENSE",
    name 		= "$spell_apotheosis_status_wet_intense_name",
    description = "$spell_apotheosis_status_wet_intense_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_intense_wet.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_wet_intense.xml"},
    spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
    type 		= ACTION_TYPE_UTILITY,
    spawn_level                       = "10", -- Conversion spell
    spawn_probability                 = "0.01", -- Conversion spell
    price = 180,
    max_uses    = 20,
    mana = 100,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_wet_intense.xml")
        c.fire_rate_wait = c.fire_rate_wait + 100
        current_reload_time = current_reload_time + 60
    end,
})

table.insert(actions,
{
    id          = "APOTHEOSIS_MASS_STATUS_FIRE_INTENSE",
    name 		= "$spell_apotheosis_status_fire_intense_name",
    description = "$spell_apotheosis_status_fire_intense_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_intense_fire.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_fire_intense.xml"},
    spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
    type 		= ACTION_TYPE_UTILITY,
    spawn_level                       = "10", -- Conversion spell
    spawn_probability                 = "0.01", -- Conversion spell
    price = 180,
    max_uses    = 20,
    mana = 100,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_fire_intense.xml")
        c.fire_rate_wait = c.fire_rate_wait + 100
        current_reload_time = current_reload_time + 60
    end,
})

table.insert(actions,
{
    id          = "APOTHEOSIS_MASS_STATUS_URINE_INTENSE",
    name 		= "$spell_apotheosis_status_urine_intense_name",
    description = "$spell_apotheosis_status_urine_intense_desc",
    sprite 		= "mods/Apotheosis/files/ui_gfx/gun_actions/mass_status_intense_urine.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
    related_projectiles	= {"mods/Apotheosis/files/entities/projectiles/deck/mass_status_urine_intense.xml"},
    spawn_requires_flag = "apotheosis_card_unlocked_blob_boss_spell",
    type 		= ACTION_TYPE_UTILITY,
    spawn_level                       = "10", -- Conversion spell
    spawn_probability                 = "0.01", -- Conversion spell
    price = 180,
    max_uses    = 20,
    mana = 100,
    action 		= function()
        add_projectile("mods/Apotheosis/files/entities/projectiles/deck/mass_status_urine_intense.xml")
        c.fire_rate_wait = c.fire_rate_wait + 100
        current_reload_time = current_reload_time + 60
    end,
})
]]--

table.insert(actions,
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
})





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
modify_existing_spell("SPITTER_TIER_2","mana",15)

modify_existing_spell("SPITTER_TIER_2_TIMER","mana",20)

--Spitter Bolt Tier 2 & 3 becomes cheaper
modify_existing_spell("SPITTER_TIER_3","mana",25)

modify_existing_spell("SPITTER_TIER_3_TIMER","mana",30)

--Increase frequency of acceleration/Rotate towards foes appearing, makes acceleration builds more accessible
modify_existing_spell("ACCELERATING_SHOT","spawn_level","1,2,3,4,5")
modify_existing_spell("ACCELERATING_SHOT","spawn_probability","0.5,1,1,1,0.5")

modify_existing_spell("HOMING_ROTATE","spawn_level","2,3,4,5,6")
modify_existing_spell("HOMING_ROTATE","spawn_probability","0.6,0.8,1,1,0.6")


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