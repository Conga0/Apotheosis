

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/giant_centipede.xml"
    })
   
    ---Small Enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

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

	local ambrosiaFairies = ModSettingGet( "Apotheosis.fairy_immortality" )

    if ambrosiaFairies == true then
        table.insert(g_lamp,
        {
            prob           = 0.2,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/cat_immortal/fairy_cheap.xml"
        })
    else
        table.insert(g_lamp,
        {
            prob           = 0.2,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/fairy_cheap.xml"
        })
    end

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 2,
        max_count    = 7,    
        entity     = "data/entities/animals/fairy_big.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/hisii_rocketshotgun.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/jungle/locust_swarm.xml"
    })





    --Pandora Spawns

    table.insert(g_small_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/items/pickup/heart.xml",
		spawn_check = function() 
			if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
				return true
			else
				return false 
			end
		end,
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.01,
        min_count    = 2,
        max_count    = 2,    
        entity     = "data/entities/animals/giant_centipede.xml",
		spawn_check = function() 
			if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
				return true
			else
				return false 
			end
		end,
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungicave/lukki_fungus.xml",
		spawn_check = function() 
			if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
				return true
			else
				return false 
			end
		end,
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/fungicave/triangle_gem.xml",
		spawn_check = function() 
			if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
				return true
			else
				return false 
			end
		end,
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
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungicave/lukki_fungus.xml",
        ngpluslevel = 2
    })

