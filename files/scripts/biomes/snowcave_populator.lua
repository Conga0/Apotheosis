
    table.insert(g_big_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/hisii_engineer.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/sentry.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/tesla_turret.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entities     =  {
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/hisii_engineer.xml",
			},
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/tank_flame_apotheosis.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.002,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/eye_forsaken_orbit.xml"
    })



    --Small enemies


    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
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
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hiisi_thief.xml"
    })





    --Unique Encounters

    table.insert(g_scavenger_party,
    {
        prob           = 0.65,
        min_count    = 1,
        max_count    = 1,
        entities     =  {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/secret/gazer_greater_cold.xml",
			},
		}
    })

    table.insert(g_scavenger_party,
    {
        prob           = 0.007,
        min_count    = 1,
        max_count    = 1,
        entities     =  {
			{
				min_count	= 5,
				max_count 	= 7,
				entity = "data/entities/animals/gazer_cold_apotheosis.xml",
			},
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/secret/gazer_cold_apotheosis.xml",
			},
		}
    })



    

    --New Game +

table.insert(g_small_enemies,
{
    prob           = 0.08,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/hisii_engineer.xml",
    ngpluslevel = 1,
})

table.insert(g_small_enemies,
{
    prob           = 0.12,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/gazer_greater_cold.xml",
    ngpluslevel = 1,
    ng_exclusive = true,
})

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/gazer_cold_apotheosis.xml",
    ngpluslevel = 1,
    ng_exclusive = true,
})

table.insert(g_big_enemies,
{
    prob           = 0.5,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/apotheosis/files/entities/buildings/snowcave/pylon_vulnerability.xml",
    ngpluslevel = 1,
})

table.insert(g_big_enemies,
{
    prob           = 0.5,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/apotheosis/files/entities/buildings/snowcave/pylon_escium.xml",
    ngpluslevel = 1,
})



    --New Game ++

table.insert(g_big_enemies,
{
    prob           = 0.05,
    min_count    = 3,
    max_count    = 7,    
    entity     = "data/entities/animals/fungicave/rat_birthday.xml",
    ngpluslevel = 2
})













-- Pixel Scenes/Areas

--[[
]]--



table.insert(g_pixel_scene_02,
{
        prob   			= 1.5,
        material_file 	= "mods/Apotheosis/files/biome_impl/snowcave/shop_alt.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/snowcave/shop_alt_visual.png",
        background_file	= "",
        is_unique		= 0
})