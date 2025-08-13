
attack_options = {
    {
        name = "airburst",
        filepath = "data/entities/animals/enchanted_books/projectiles/air_bullet_book.xml",
        count_min = 6,
        count_max = 8,
        attacks_in_this_cycle = 6,
        random_spread = 15,
        speed = 350,
        speed_random_mult = 1.0,
        after_attack_delay = 60
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