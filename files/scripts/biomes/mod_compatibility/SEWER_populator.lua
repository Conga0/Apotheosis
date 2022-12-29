
    table.insert(g_small_enemies,
    {
        prob           = 0.01,
        min_count    = 1,
        max_count    = 2,
        entity     = "data/entities/animals/boss_toxic_worm_minion.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/blindgazer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/goo_slug.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/hisii_hobo.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/swamp/poring.xml"
    })

    table.insert(g_lamp,
    {
        prob           = 0.05,
        min_count    = 5,
        max_count    = 10,    
        entity     = "data/entities/animals/whisp.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })



    --New Game +

table.insert(g_big_enemies,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/boss_toxic_worm.xml",
    ngpluslevel = 1
})



---Herobrine

table.insert(g_big_enemies,
{
    prob           = 0.005,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/buildings/herobrine.xml"
})