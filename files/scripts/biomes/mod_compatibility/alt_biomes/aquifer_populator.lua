dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/longleg_pillar.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/buildings/hamis_nest.xml",
			},
			{
				min_count	= 2,
				max_count 	= 3,
				entity = "data/entities/animals/longleg.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.115,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_minecart_weak.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_minecart_tnt.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/secret/hisii_minecart.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.01,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_giga_bomb.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/slime_leaker_weak.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/watermage.xml"
    })

    

    ---Small Enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/swamp/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/goo_slug.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })

    table.insert(g_small_enemies,
    {
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/rat_birthday.xml",
		spawn_check = function() 
			return is_holiday_active("birthday")
		end,
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


    --Slime Pit Spawns
    table.insert(g_unique_enemy,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/slime_leaker_weak.xml"
    })





    --Pandora Spawns

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_giga_bomb.xml",
		spawn_check = function() 
            local world_state = GameGetWorldStateEntity()
            if EntityGetIsAlive(world_state) == false then return false end

			if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
				return true
			else
				return false 
			end
		end,
    })
    




    --New Game +

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poring_holy.xml",
    ngpluslevel = 1
})

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poring_magic.xml",
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