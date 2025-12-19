
ai_data = {
    {
        id = "phase_1",
        attack_options = {
            {
                name = "sparkbolt_machinegun",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/sparkbolt_wand.xml",
                particle_to_emit_on_swap = "spark_purple_bright",
                filepath = "data/entities/projectiles/deck/light_bullet.xml",
                count_min = 1,
                count_max = 1,
                attacks_in_this_cycle = 420,
                random_spread = 6,
                speed = 650,
                speed_random_mult = 1.13,
                after_attack_delay = 1
            },
            {
                name = "holyorb_barrage",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/holyorbbarrage_wand.xml",
                particle_to_emit_on_swap = "spark_yellow",
                filepath = "mods/Apotheosis/files/entities/projectiles/deck/orb_holy_shotgun.xml",
                count_min = 7,
                count_max = 7,
                attacks_in_this_cycle = 10,
                random_spread = 30,
                speed = 200,
                speed_random_mult = 1.75,
                after_attack_delay = 30
            },
            --[[
            {
                name = "homing_lance",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/hominglance_wand.xml",
                filepath = "data/entities/animals/witch_miniboss/projectiles/homing_lance.xml",
                count_min = 1,
                count_max = 1,
                attacks_in_this_cycle = 2,
                random_spread = 30,
                speed = 150,
                speed_random_mult = 1.0,
                after_attack_delay = 180
            },
            ]]--
            {
                name = "bolt_orb",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/hominglance_wand.xml",
                particle_to_emit_on_swap = "plasma_fading",
                filepath = "data/entities/animals/witch_miniboss/projectiles/electrosphere_warning.xml",
                count_min = 1,
                count_max = 1,
                attacks_in_this_cycle = 12,
                random_spread = 70,
                speed = 80,
                speed_random_mult = 1.0,
                after_attack_delay = 40
            },
            {
                name = "expanding_orb_bomb",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/expandingorbbomb_wand.xml",
                particle_to_emit_on_swap = "spark",
                filepath = "data/entities/animals/witch_miniboss/projectiles/orb_expanding_bomb.xml",
                count_min = 1,
                count_max = 1,
                attacks_in_this_cycle = 6,
                random_spread = 30,
                speed = 60,
                speed_random_mult = 1.0,
                after_attack_delay = 70
            }
        }
    },
    {
        id = "phase_2",
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
                name = "glue_barrage",
                wandsprite_filepath = "data/entities/animals/witch_miniboss/wand_graphics/glue_wand.xml",
                particle_to_emit_on_swap = "spark_white",
                filepath = "data/entities/projectiles/glue_shot.xml",
                count_min = 11,
                count_max = 16,
                bias_y = -30,
                attacks_in_this_cycle = 1,
                random_spread = 45,
                speed = 150,
                speed_random_mult = 3.0,
                after_attack_delay = 60
            }
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