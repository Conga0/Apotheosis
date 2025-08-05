dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

    table.insert(g_big_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/giant_centipede.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungicave/lukki_fungus.xml",
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.11,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/shaman_greater_apotheosis.xml",
    })
   
    ---Small Enemies
   
    table.insert(g_small_enemies,
    {
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/rat_birthday.xml",
		spawn_check = function() 
			return is_holiday_active("birthday")
		end,
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.11,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poisonmushroom.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.11,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungiforest/ceiling_fungus.xml"
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
        min_count    = 5,
        max_count    = 7,    
        entity     = "data/entities/animals/fairy_big.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/jungle/locust_swarm.xml"
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

