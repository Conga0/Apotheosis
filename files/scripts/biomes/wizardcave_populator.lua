
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_explosive.xml"
    })

    table.insert(g_big_enemies,
	{
		prob   		= 0.015,
		min_count	= 1,
		max_count	= 1,    
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/wizard_duck.xml",
			},
			{
				min_count	= 5,
				max_count 	= 7,
				entity = "data/entities/animals/enchanted_duck.xml",
			},
		}
	})


    
    table.insert(g_big_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_firemage_greater.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.06,
        min_count    = 2,
        max_count    = 3,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })
  
    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_ambrosia.xml"
    })
  
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,
        offset_y 	= -3,
        entity     = "data/entities/animals/wizard_z_poly_miniboss.xml",
    })
    
    table.insert(g_big_enemies,
	{
		prob   		= 0.02,
		min_count	= 1,
		max_count	= 1,    
		entities 	= { "data/entities/animals/duck.xml", "data/entities/animals/wizard_ambrosia.xml", "data/entities/animals/wizard_ambrosia.xml", "data/entities/animals/wizard_ambrosia.xml", "data/entities/animals/wizard_jackofalltrades.xml", "data/entities/animals/wizard_jackofalltrades.xml", "data/entities/animals/wizard_transmutation.xml", "data/entities/animals/wizard_poly.xml", "data/entities/animals/wizard_swapper.xml", "data/entities/animals/wizard_homing.xml" },
	})



    ---Small enemies
  
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_ambrosia.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_den/forsaken_eye.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })