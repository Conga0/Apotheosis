
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poisonmushroom.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_lukki_fake.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 6,
        max_count    = 9,    
        entity     = "data/entities/animals/lukki_swarmling.xml"
    })


    --New Game +

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungicave/lukki_fungus.xml",
        ngpluslevel = 1
    })



    --New Game ++

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/fungicave/lukki_fungus.xml",
        ngpluslevel = 2
    })

