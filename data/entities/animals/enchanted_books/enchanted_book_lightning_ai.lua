
attack_options = {
    {
        name = "lightning_bolt",
        filepath = "data/entities/projectiles/enlightened_laser_elec_wand.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 4,
        random_spread = 0,
        speed = 60,
        speed_random_mult = 0.0,
        give_warning = true,
        continous_warning = true,
        after_attack_delay = 60
    },
    --[[
    {
        name = "lightning_orb",
        filepath = "mods/Apotheosis/files/entities/projectiles/sun_mini.xml", --Written idea is very similar to the sun, maybe do a lightning bomb instead?
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 1,
        random_spread = 0,
        speed = 80,
        give_warning = true,
        after_attack_delay = 260
    },
    ]]--
    {
        name = "summon_cloud",
        filepath = "data/entities/animals/enchanted_books/projectiles/thunder_cloud_homing.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 1,
        random_spread = 0,
        speed = 0,
        speed_random_mult = 1.0,
        give_warning = true,
        bias_y = -777,
        after_attack_delay = 180,
        extra_func = function(projectile_id,current_target)
            local comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"VariableStorageComponent")
            ComponentSetValue2(comp,"value_int",current_target)
        end
    }
}

dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")