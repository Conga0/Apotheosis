
    table.insert(g_big_enemies,
    {
        prob           = 0.0005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.0005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/watermage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.025,
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
        prob           = 0.07,
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



    ---Small Enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/coal_mines/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/goo_slug.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/hiisi_thief.xml"
    })


    

    table.insert(g_props,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
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


    --Watermage Spawns
    table.insert(g_unique_enemy3,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/watermage.xml"
    })





    --Pandora Spawns

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_giga_bomb.xml",
		spawn_check = function() 
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
    ngpluslevel = 1,
    ng_exclusive = true,
})

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poring_magic.xml",
    ngpluslevel = 1,
    ng_exclusive = true,
})

table.insert(g_small_enemies,
{
    prob           = 0.07,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml",
    ngpluslevel = 1,
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













-- Pixel Scenes/Areas

--[[
]]--
RegisterSpawnFunction( 0xffd964d5, "spawn_apotheosis_portaltrap" )
RegisterSpawnFunction( 0xffdb6666, "spawn_apotheosis_giga_bomber" )



table.insert(g_pixel_scene_01,
{
        prob   			= 0.6,
        material_file 	= "mods/Apotheosis/files/biome_impl/coalmines/coalpit_c_01.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/coalmines/coalpit_c_01_visual.png",
        background_file	= "",
        is_unique		= 0
})



table.insert(g_pixel_scene_02,
{
        prob   			= 0.85,
        material_file 	= "mods/Apotheosis/files/biome_impl/coalmines/wandtrap_portal.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/coalmines/wandtrap_portal_visual.png",
        background_file	= "",
        is_unique		= 0
})



table.insert(g_pixel_scene_02,
{
        prob   			= 1.4,
        material_file 	= "mods/Apotheosis/files/biome_impl/coalmines/gigabomb_01.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/coalmines/gigabomb_01_visual.png",
        background_file	= "mods/Apotheosis/files/biome_impl/coalmines/gigabomb_01_background.png",
        is_unique		= 0
})



function spawn_apotheosis_portaltrap( x, y )
    EntityLoad( "mods/Apotheosis/files/entities/props/traps/trap_portal.xml", x, y )
end

function spawn_apotheosis_giga_bomber( x, y )
    EntityLoad( "data/entities/animals/hisii_giga_bomb.xml", x, y )
    CreateItemActionEntity( "apotheosis_BOMB_GIGA", x, y - 8 )
end
