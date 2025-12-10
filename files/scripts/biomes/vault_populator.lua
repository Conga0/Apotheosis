
    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 2,
        max_count    = 3,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
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
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/drone_status_ailment.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
		entities 	= 
        {
            "data/entities/animals/vault/tentacler_big.xml",
            "data/entities/animals/vault/tentacler.xml",
            "data/entities/animals/vault/tentacler.xml"
        }
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 6,
        max_count    = 9,    
        entity     = "data/entities/animals/wraith_weirdo_shield.xml"
    })

    if ModIsEnabled("worse_enemies") == false then
        table.insert(g_big_enemies,
        {
            prob           = 0.2,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/blob_big.xml"
        })
    end

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/slime_leaker.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/boss_toxic_worm/boss_toxic_worm_minion.xml",
        spawn_check = function()
            local world_state = GameGetWorldStateEntity()
            if EntityGetIsAlive(world_state) == false then return false end
            
            return GameHasFlagRun( "apotheosis_boss_toxic_worm_summoned" )
        end,
    })




    --Small enemies

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })


    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/tentacler_big.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/vault/hisii_engineer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.11,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/vault/drone_mini.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/blindgazer.xml"
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
        prob           = 0.03,
        min_count    = 3,
        max_count    = 6,    
        entity     = "data/entities/animals/vault/goo_slug.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.085,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_hobo.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/mimic_explosive_box.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/wraith_weirdo_shield.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/drone_status_ailment.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/slime_leaker.xml"
    })



    --Pandora Spawns

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/items/pickup/heart.xml",
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

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 6,
        max_count    = 8,    
        entity     = "data/entities/animals/blindgazer.xml",
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

    table.insert(g_big_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/watermage_greater.xml",
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

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 4,
        max_count    = 4,    
        entity     = "data/entities/animals/poring_lukki.xml",
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



    --Ceiling Props

    table.insert(g_hanging_props,
    {
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "mods/Apotheosis/files/entities/props/suspended_tank_lava.xml"
    })




    --New Game +
    
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 3,
        max_count    = 4,    
        entity     = "data/entities/animals/vault/hisii_engineer.xml",
        ngpluslevel = 1
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 5,
        max_count    = 7,    
        entity     = "data/entities/animals/power_plant/drone_mini.xml",
        ng_exclusive = true,
        ngpluslevel = 1
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/drone_status_ailment.xml",
        ngpluslevel = 1
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/power_plant/worm_mechanical.xml",
        ng_exclusive = true,
        ngpluslevel = 1
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 3, 
        ngpluslevel  = 1,   
        entity     = "data/entities/animals/slime_teleporter.xml"
    })













-- Pixel Scenes/Areas

--[[
]]--

table.insert(g_pixel_scene_wide,
{
        prob   			= 0.5,
        material_file 	= "mods/Apotheosis/files/biome_impl/vault/lava_pit.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/vault/lava_pit_visual.png",
        background_file	= "mods/Apotheosis/files/biome_impl/vault/lava_pit_background.png",
        is_unique		= 0
})
--Adding shop into the pool a 2nd time to not dilute it's spawn chance
table.insert(g_pixel_scene_wide,
{
        prob   			= 0.5,
        material_file 	= "data/biome_impl/vault/shop.png",
        visual_file		= "data/biome_impl/vault/shop_visual.png",
        background_file	= "",
        is_unique		= 0,
})

table.insert(g_pixel_scene_tall,
{
        prob   			= 0.5,
        material_file 	= "mods/Apotheosis/files/biome_impl/vault/redstone_trap_room.png",
        visual_file		= "",
        background_file	= "mods/Apotheosis/files/biome_impl/vault/redstone_trap_room_background.png",
        is_unique		= 0
})

RegisterSpawnFunction( 0xff22ec6e, "spawn_hatch" )
RegisterSpawnFunction( 0xffefce17, "spawn_spell_machine_controller" )
RegisterSpawnFunction( 0xff4cacab, "spawn_spell_machine_vat" )

function spawn_hatch(x, y)
	EntityLoad("mods/Apotheosis/files/entities/props/hatch_steel.xml", x, y)
end

function spawn_spell_machine_controller(x, y)
	EntityLoad("mods/Apotheosis/files/entities/buildings/spell_machine_controller.xml", x, y)
end

function spawn_spell_machine_vat(x, y)
	EntityLoad("mods/Apotheosis/files/entities/buildings/spell_machine_vat.xml", x, y)
end