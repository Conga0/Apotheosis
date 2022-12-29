

    table.insert(g_big_enemies,
    {
        prob           = 0.25,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.5,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })


    --Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tesla_turret.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/vault/drone_mini.xml"
    })


    --Newgame +

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 5,
        max_count    = 7,    
        entity     = "data/entities/animals/power_plant/drone_mini.xml",
        ngpluslevel = 1
    })