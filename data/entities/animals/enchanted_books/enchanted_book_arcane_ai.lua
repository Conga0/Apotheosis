
attack_options = {
    {
        name = "orb_barrage",  --Probably just going to have this be a grand-master attack, like a big master not mom, Converged Master? Kaikkien-Suurmestari? Master of All?
        filepath = {
            "mods/Apotheosis/files/entities/projectiles/orb_manadrain.xml",
            "mods/Apotheosis/files/entities/projectiles/orb_corrupt_teleport.xml",
            "mods/Apotheosis/files/entities/projectiles/orb_corrupt_twitchy.xml",
            "mods/Apotheosis/files/entities/projectiles/orb_corrupt_hearty.xml",
            "data/entities/projectiles/orb_homing.xml",
            "data/entities/projectiles/orb_hearty.xml"
        },
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 20,
        random_spread = 360,
        speed = 40,
        speed_random_mult = 1.0,
        after_attack_delay = 3,
        extra_func = function(projectile_id)
            local comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"HomingComponent")
            ComponentSetValue2(comp,"detect_distance",0)

            EntityAddComponent2(
                projectile_id,
                "LuaComponent",
                {
                    script_source_file="mods/Apotheosis/files/scripts/projectiles/lavashot_BoC.lua",
                    execute_every_n_frame=60,
                    execute_times=1
                }
            )

            EntityAddComponent2(
                projectile_id,
                "LuaComponent",
                {
                    script_source_file="mods/Apotheosis/files/scripts/projectiles/lavashot_BoC_2.lua",
                    execute_every_n_frame=90,
                    execute_times=1
                }
            )
        end
    },
    {
        name = "extreme_vacuum",
        filepath = "data/entities/animals/enchanted_books/projectiles/extreme_vacuum.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 1,
        random_spread = 0,
        speed = 0,
        give_warning = true,
        after_attack_delay = 150
    }
}

dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")