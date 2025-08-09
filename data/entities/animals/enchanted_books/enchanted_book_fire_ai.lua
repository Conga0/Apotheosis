
attack_options = {
    {
        name = "firebolt",
        filepath = "data/entities/projectiles/deck/grenade.xml",
        count_min = 4,
        count_max = 5,
        attacks_in_this_cycle = 5,
        random_spread = 35,
        speed = 180,
        speed_random_mult = 2.0,
        after_attack_delay = 60
    },
    {
        name = "mini_sun",
        filepath = "mods/Apotheosis/files/entities/projectiles/sun_mini.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 1,
        random_spread = 0,
        speed = 80,
        give_warning = true,
        after_attack_delay = 260
    },
    {
        name = "flamethrower",
        filepath = "data/entities/projectiles/flamethrower.xml",
        count_min = 3,
        count_max = 3,
        attacks_in_this_cycle = 80,
        random_spread = 15,
        speed = 250,
        speed_random_mult = 1.15,
        --spin_speed = 0.06,  --Example of how to tell an attack to spin, book will spin at the given speed, 0.06 is the default turn-speed for the book.
        after_attack_delay = 3
    }
}

dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")