    table.insert(g_big_enemies,
	{
		prob   		= 0.03,
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
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })


    --Liquid bubbles
    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/ambrosia/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/berserkium/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/soarium/bubble_liquid.xml"
    })



    ---Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_manaeater.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/witch_miniboss/witch_variants/arcane/witch_miniboss.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/witch_miniboss/witch_variants/explosive/witch_miniboss.xml"
    })