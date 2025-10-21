
attack_options = {
    --[[
    {
        name = "infohazard_orbs",
        filepath = "data/entities/animals/enchanted_books/projectiles/bliss_beam.xml",
        count_min = 6,
        count_max = 8,
        attacks_in_this_cycle = 6,
        random_spread = 15,
        speed = 350,
        speed_random_mult = 1.0,
        after_attack_delay = 60
    },
    ]]--
    {
        name = "bliss_beam",
        filepath = "data/entities/animals/enchanted_books/projectiles/bliss_beam.xml",
        count_min = 1,
        count_max = 1,
        attacks_in_this_cycle = 1,
        random_spread = 0,
        speed = 0,
        give_warning = true,
        after_attack_delay = 150
    },
    {
        name = "disguise_tomes",
        filepath = "data/entities/animals/enchanted_books/projectiles/bliss_beam.xml",
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


--[[
Infohazard ideas:
Bliss - hide the player's health, similar to morphine from CC
Perspective - books/enemies use a random, different sprite, to mislead the player
Heaven after Death - you take twice as much damage
Unspeakable Horrors - frosty misty effect

BLISS
YOU ARE IN BLISS, HARMONY IS UPON YOU.
TRUST THAT PAIN IS PLEASURE.

NEW PERSPECTIVE
YOU SEE THE WORLD FROM A PERSPECTIVE NO ONE ELSE CAN.
THE WORLD WAS ALWAYS AS IT SEEMED.

HEAVEN AFTER DEATH
THERE IS A PERFECT WORLD WAITING FOR YOU UPON YOUR DEMISE.
YOUR BODY IS TWICE AS EAGER TO EMBRACE IT. 
ANIMA ARDEAT.

INSIGHT ON UNSPEAKABLE HORRORS
MONSTERS ARE HIDING BEHIND EVERY CORNER, BEASTS BEYOND THIS WORLD ARE HUNTING YOU.
MOVE SLOWLY.
TELEPORTATION IS RISKY.

]]

--Maybe just looking at this book while it's open curses you with an infohazard?