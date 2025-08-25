
attack_options = {
    {
        name = "sentinel_bolt",
        filepath = "data/entities/animals/enchanted_books/projectiles/sentinel_bolt.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 12,
        random_spread = 20,
        speed = 150,
        speed_random_mult = 1.0,
        after_attack_delay = 30
    },
    {
        name = "death_mist",
        filepath = "data/entities/animals/enchanted_books/projectiles/death_mist.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 40,
        random_spread = 360,
        speed = 10,
        speed_random_mult = 10.0,
        after_attack_delay = 10
    }
}

dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")