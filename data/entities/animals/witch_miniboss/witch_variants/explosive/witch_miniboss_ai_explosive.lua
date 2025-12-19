
ai_data = {
    {
        id = "phase_1",
        attack_options = {
            {
                name = "magic_missile",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/magicmissile_wand.xml",
                particle_to_emit_on_swap = "spark",
                filepath = "data/entities/projectiles/deck/rocket.xml",
                count_min = 1,
                count_max = 1,
                attacks_in_this_cycle = 7,
                random_spread = 5,
                speed = 70,
                speed_random_mult = 1.42,
                after_attack_delay = 60
            },
            {
                name = "firebomb_barrage",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/firebomb_wand.xml",
                particle_to_emit_on_swap = "lava",
                filepath = "data/entities/projectiles/deck/firebomb.xml",
                count_min = 2,
                count_max = 3,
                attacks_in_this_burst = 10,
                burst_wait_between = 1,
                attacks_in_this_cycle = 4,
                random_spread = 10,
                speed = 120,
                speed_random_mult = 1.5,
                after_attack_delay = 30
            },
        }
    },
    {
        id = "phase_2",
        attack_options = {
            {
                name = "giga_death_cross",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/gigacross_wand.xml",
                particle_to_emit_on_swap = "spark_green",
                filepath = "data/entities/animals/witch_miniboss/projectiles/bolt_into_giga_cross.xml",
                count_min = 1,
                count_max = 1,
                attacks_in_this_cycle = 7,
                random_spread = 5,
                speed = 600,
                speed_random_mult = 1.2,
                after_attack_delay = 50
            },
            {
                name = "firebomb_barrage",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/firebomb_wand.xml",
                particle_to_emit_on_swap = "lava",
                filepath = "data/entities/animals/witch_miniboss/projectiles/firebomb_delayedhoming.xml",
                count_min = 2,
                count_max = 3,
                attacks_in_this_burst = 40,
                burst_wait_between = 1,
                attacks_in_this_cycle = 1,
                random_spread = 360,
                speed = 40,
                speed_random_mult = 2.0,
                after_attack_delay = 90
            },
        }
    },
    {
        id = "desperation",
        desperation_func = function(desperation_init_frame)
            local entity_id = GetUpdatedEntityID()
            local p_x, p_y = EntityGetTransform(entity_id)

            local function init()
                local child = EntityLoad("data/entities/animals/witch_miniboss/particles/nuke_particles.xml",p_x,p_y)
                EntityAddChild(entity_id,child)

                --EntityLoad("data/entities/animals/witch_miniboss/projectiles/bomb_holy_giga_longlifetime.xml",p_x,p_y)
                GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bomb_holy/create", p_x, p_y)
            end

            if GameGetFrameNum() == desperation_init_frame then init() end

            if GameGetFrameNum() >= desperation_init_frame + 900 then
                EntityLoad("data/entities/animals/witch_miniboss/projectiles/nuke_giga_instant.xml",p_x,p_y)
                local player_id = EntityGetWithTag("player_unit")[1] or entity_id
                EntityInflictDamage( entity_id, 399.96, "DAMAGE_CURSE", "$spell_apotheosis_electrosphere_name", "NONE", 0, 0, player_id )
            end
        end
    }
}

dofile("data/entities/animals/witch_miniboss/witch_miniboss_base_ai.lua")