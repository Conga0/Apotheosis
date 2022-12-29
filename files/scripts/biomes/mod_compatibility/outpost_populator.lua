
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
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })




    --Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_engineer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.04,
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