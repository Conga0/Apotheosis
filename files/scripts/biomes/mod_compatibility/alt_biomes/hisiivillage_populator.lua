
    table.insert(g_big_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/hisii_engineer.xml",
			},
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/drone_lasership.xml",
			}
		}
	})

    table.insert(g_big_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/drone_status_ailment.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_giga_bomb.xml"
    })




    --Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_engineer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/drone_mini.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_hobo.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.025,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.004,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/scavenger_heal.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.004,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/drone_status_ailment.xml"
    })


    --Unique
    table.insert(g_unique_enemy,
    {
        prob           = 1.0,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })



     --New Game +

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,  
        entity     = "data/entities/animals/hisii_engineer.xml",
		ngpluslevel = 1
    })