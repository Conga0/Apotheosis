
    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
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
        entity     = "data/entities/animals/hisii_minecart.xml"
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
        prob           = 0.007,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/excavationsite/poring_lukki_fake.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
		entities 	= {
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/ccc_bat_psychic.xml",
			},
			{
				min_count	= 3,
				max_count 	= 4,
				entity = "data/entities/animals/fairy_big.xml",
			},
		}
    })



    --Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.18,
        min_count    = 2,
        max_count    = 4,    
        entity     = "data/entities/animals/ccc_bat_psychic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/goo_slug.xml"
    })

	local ambrosiaFairies = ModSettingGet( "Apotheosis.fairy_immortality" )

    if ambrosiaFairies == true then
        table.insert(g_small_enemies,
        {
            prob           = 0.08,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/cat_immortal/fairy_cheap.xml"
        })
    else
        table.insert(g_small_enemies,
        {
            prob           = 0.08,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/fairy_cheap.xml"
        })
    end

    table.insert(g_small_enemies,
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

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hiisi_thief.xml"
    })




    

    table.insert(g_props,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })

    table.insert(g_lamp,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/fairy_big.xml"
    })

    table.insert(g_lamp,
    {
        prob           = 0.05,
        min_count    = 5,
        max_count    = 10,    
        entity     = "data/entities/animals/whisp.xml"
    })

    if ModIsEnabled("purgatory") then
        table.insert(g_big_enemies,
        {
            prob           = 0.05,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/hisii_giga_bomb.xml"
        })
    end




    --Slime Pit Spawns
    table.insert(g_unique_enemy,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/slime_leaker.xml"
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

    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/illusions/dark_alchemist.xml",
		spawn_check = function() 
			if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
				return true
			else
				return false 
			end
		end,
    })



    --Props

    table.insert(g_hanging_props,
    {
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "mods/Apotheosis/files/entities/props/suspended_tank_fire.xml"
    })




    --New Game +
    
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/tentacler_big.xml",
        ngpluslevel = 1,
        ng_exclusive = true,
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.3,
        min_count    = 2,
        max_count    = 3,    
        entity     = "data/entities/animals/whisp_big.xml",
        ngpluslevel = 1
    })













    -- Pixel Scenes/Areas
    
    --[[
    ]]--
    
    local pixelscene_append_list ={
    {
        prob   			= 1.8,
        material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_01.png",
        visual_file		= "",
        background_file	= "",
        is_unique		= 0
    },
    {
        prob   			= 1.8,
        material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_02.png",
        visual_file		= "",
        background_file	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_02_background.png",
        is_unique		= 0
    },
    {
        prob   			= 3.0,
        material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/shop_01.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/excavationsite/shop_01_visual.png",
        background_file	= "",
        is_unique		= 0
    }, --Everything below this point is the vanilla stuff so shops don't get overinflated -----------------------------------
	{
		prob   			= 0.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_1.png",
		visual_file		= "data/biome_impl/excavationsite/machine_1_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_1_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_2.png",
		visual_file		= "data/biome_impl/excavationsite/machine_2_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_2_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_3b.png",
		visual_file		= "data/biome_impl/excavationsite/machine_3b_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_3b_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_4.png",
		visual_file		= "data/biome_impl/excavationsite/machine_4_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_4_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_5.png",
		visual_file		= "data/biome_impl/excavationsite/machine_5_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_5_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_6.png",
		visual_file		= "data/biome_impl/excavationsite/machine_6_visual.png",
		background_file	= "",
		is_unique		= 0
	},
	{
		prob   			= 0.3,
		material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_machine_7.png",
		visual_file		= "data/biome_impl/excavationsite/machine_5_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_5_background.png",
		is_unique		= 0
	},
    }

    for i,v in ipairs(pixelscene_append_list) do
        table.insert(g_pixel_scene_04,v)
    end
    
    --[[
    table.insert(g_pixel_scene_04,
    {
            prob   			= 1.0,
            material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_01.png",
            visual_file		= "",
            background_file	= "",
            is_unique		= 0
    })

    table.insert(g_pixel_scene_04,
    {
            prob   			= 1.0,
            material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_02.png",
            visual_file		= "",
            background_file	= "mods/Apotheosis/files/biome_impl/excavationsite/redstone_02_background.png",
            is_unique		= 0
    })

    table.insert(g_pixel_scene_04,
    {
            prob   			= 3.0,
            material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/shop_01.png",
            visual_file		= "mods/Apotheosis/files/biome_impl/excavationsite/shop_01_visual.png",
            background_file	= "",
            is_unique		= 0
    })
    ]]--

RegisterSpawnFunction( 0xff876544, "spawn_nest_egg" )
RegisterSpawnFunction( 0xffffeedd, "init" )

if init ~= nil then
    local previousinit = init
end

function init(x, y, w, h)
    -- figure out positions for 4 fire lukki eggs within the biome
    -- and spawn them if a position is within the bounds of this function call
    -- NOTE: only 1 egg is needed to complete the nest portal
    for i=1,4 do
        local biome_x_min = -1887
        local biome_x_max = 1843
        local biome_y_min = 1701
        local biome_y_max = 2403

        local pos_x = ProceduralRandomi(109,i*53,biome_x_min,biome_x_max)
        local pos_y = ProceduralRandomi(111,i*2.9,biome_y_min,biome_y_max)

        if pos_x >= x and pos_x <= x+w
        and pos_y >= y and pos_y <= y+h then
            -- Generate Fire Lukki Nests
            LoadPixelScene( "mods/apotheosis/files/biome_impl/excavationsite/fire_lukki_egg.png", "mods/apotheosis/files/biome_impl/excavationsite/fire_lukki_egg_visual.png", pos_x-22, pos_y-22, "mods/apotheosis/files/biome_impl/excavationsite/fire_lukki_egg_background.png", true )
            
            --Debug Data
            --GamePrint("Spawning nest at X: " .. pos_x .. ", Y: " .. pos_y)
            --print("Spawning nest at X: " .. pos_x .. ", Y: " .. pos_y)
        end	
    end
end

function spawn_nest_egg(x, y)
	EntityLoad("mods/apotheosis/files/entities/items/pickups/egg_volcanic_lukki.xml", x, y)
end