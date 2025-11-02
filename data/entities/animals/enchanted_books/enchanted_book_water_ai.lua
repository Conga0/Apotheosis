
attack_options = {
    {
        name = "eels",
        filepath = "data/entities/animals/enchanted_books/projectiles/eel.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 4,
        random_spread = 35,
        speed = 75,
        speed_random_mult = 3.0,
        bias_y = -60,
        give_warning = true,
        after_attack_delay = 20
    },
    {
        name = "waterball",
        filepath = "data/entities/animals/enchanted_books/projectiles/waterball.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 16,
        random_spread = 360,
        speed = 20,
        after_attack_delay = 15
    },
    {
        name = "aquamage_pylon",
        filepath = "mods/Apotheosis/files/entities/projectiles/aquamage_pylon_short.xml",
        count_min = 4,
        count_max = 5,
        attacks_in_this_cycle = 2,
        random_spread = 35,
        speed = 30,
        speed_random_mult = 10.0,
        after_attack_delay = 90
    }
}

dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")