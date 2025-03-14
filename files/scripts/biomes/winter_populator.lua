
    table.insert(g_big_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/manadrain_crystal.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/musical_being.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entities     =  {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/secret/gazer_greater_cold.xml",
			},
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "mods/Apotheosis/files/entities/misc/remove_ground_small.xml",
			},
		}
    })



    --Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.065,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/forsaken_eye.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/musical_being_weak.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/gazer_greater_cold.xml",
        ngpluslevel = 1
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gazer_cold_apotheosis.xml"
    })

    --April Fools Snowmen
    local year, month, day, hour, minute = GameGetDateAndTimeLocal()
    if ((( month == 4 ) and ( day == 1 )) and ModSettingGet( "Apotheosis.seasonal_events" )) or ModSettingGet( "Apotheosis.seasonal_events_forced_april_fools" ) then
        table.insert(g_small_enemies,
        {
            prob           = 0.1,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/snowman.xml"
        })
    end

    table.insert(g_props,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })
    



    --New Game +

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/watermage_greater.xml",
    ngpluslevel = 1
})

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 3,
    max_count    = 5,    
    entity     = "data/entities/animals/gazer_cold_apotheosis.xml",
    ngpluslevel = 1
})