
attack_options = {,
    {
        name = "example_attack",                                                        --Name of the attack, used for internal identification
        filepath = "data/entities/animals/enchanted_books/projectiles/icebolt.xml",     --Filepath of the projectile being shot out
        count_min = 1,                                                                  --Minimum amount of projectiles to fire each shot
        count_max = 1,                                                                  --Maximum amount of projectiles to fire each shot
        attacks_in_this_cycle = 3,                                                      --The book will attack this many times before closing
        attacks_in_this_burst = 4,                                                      --If this is greater than 0/nil, the book will attack this many times with after_attack_delay's fire rate, after shoots for the given amount of times stated by the burst (in this example 4), it will reduce 1 counter from attacks_in_this_cycle and wait using burst_wait_between before resuming the next barrage
        random_spread = 0,                                                              --Random spread given to the projectiles the book shoots
        speed = 250,                                                                    --Velocity of the projectiles the book shoots
        speed_random_mult = 1.15,                                                       --Randomly multiply the speed a projectile is shot at between 1x and this mult
        give_warning = true,                                                            --If this is true, the book will give a visual warning of some kind upon openning, which will vanish when the book shoots
        after_attack_delay = 150,                                                       --The book will wait this many frames between shots
        burst_wait_between = 60,                                                        --The book will wait this many frames between bursts, if attacks_in_this_burst is set
        spin = 0.06,                                                                    --If this is set, the book will ignore traditional targetting and instead rotate at this speed while it attacks. 0.06 is the default turn-rate for the book
        bias_x = 10,                                                                    --The book will bias it's targetting relative to the target by this much, lower x means closer to book, higher x means further from book
        bias_y = -30,                                                                   --The book will bias it's targetting relative to the target by this much
        weight = 1.0                                                                    --Unused, not functional. Weight for this attack to be chosen randomly, might be useful if you want a variation of another attack without flooding the attack pool
    },
    {
        name = "icebolt",                                                               --This attack will shoot a burst of 4 ice bolts in rapid succession, wait for 60 frames, then repeat again until 16 bolts are fired in total (4 * 4 = 16)
        filepath = "data/entities/animals/enchanted_books/projectiles/icebolt.xml",     
        count_min = 1,
        count_max = 1,
        attacks_in_this_burst = 4,
        attacks_in_this_cycle = 4,
        random_spread = 5,
        speed = 250,
        speed_random_mult = 1.0,
        burst_wait_between = 60,
        after_attack_delay = 10,
        weight = 1.0
    },
    {
        name = "flamethrower",                                                          --This attack will make the book spew out a constant stream of fire while spinning until the attack expires
        filepath = "data/entities/projectiles/flamethrower.xml",
        count_min = 3,
        count_max = 3,
        attacks_in_this_cycle = 80,
        random_spread = 15,
        speed = 250,
        speed_random_mult = 1.15,
        spin_speed = 0.06,
        after_attack_delay = 3,
        weight = 1.0
    },
    {
        name = "extreme_vacuum",                                                        --This attack will make the book let out a visual warning while it warms up it's attack, before releasing a single extreme vacuum and closing
        filepath = "data/entities/animals/enchanted_books/projectiles/extreme_vacuum.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 1,
        random_spread = 0,
        speed = 0,
        give_warning = true,
        after_attack_delay = 150,
        weight = 1.0
    }
}

--Remember to call this so the book has AI
dofile("data/entities/animals/enchanted_books/enchanted_book_base_ai.lua")