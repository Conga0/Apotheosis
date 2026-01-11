
attack_options = {
    {
        name = "icebolt",
        filepath = "data/entities/animals/enchanted_books/projectiles/icebolt.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_burst = 4,
        attacks_in_this_cycle = 4,
        random_spread = 5,
        speed = 500,
        speed_random_mult = 1.0,
        burst_wait_between = 8,
        after_attack_delay = 60
    },
    {
        name = "ice_mist",
        filepath = "data/entities/animals/enchanted_books/projectiles/ice_mist.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 25,
        random_spread = 85,
        speed = 10,
        speed_random_mult = 7.0,
        after_attack_delay = 10
    }
}

dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")