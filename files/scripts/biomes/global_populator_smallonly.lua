   


   --- Rare Bubbles

    table.insert(g_small_enemies,
    {
        prob           = 0.012,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/ambrosia/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.0002,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/magic_catalyst/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.0002,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/alchemicprecursor/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.0003,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/healthium/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.0006,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/voidliquid/bubble_liquid.xml"
    })



    -- Chaotic Polymorphing Crystal

    table.insert(g_small_enemies,
    {
        prob           = 0.0088,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml"
    })

    -- Wand Editting Crystal

    table.insert(g_small_enemies,
    {
        prob           = 0.009,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/wandedit_crystal.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/wandedit_crystal.xml",
		spawn_check = function() 
			local year, month, day = GameGetDateAndTimeLocal()
			
            if is_holiday_active("birthday") then
				return true
			else
				return false 
			end
		end,
    })


    -- New Game +
    
    table.insert(g_small_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml",
        ngpluslevel = 1
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/manadrain_crystal.xml",
        ngpluslevel = 1
    })



    -- Pandora's Chest
    --Originally 0.008
    
if g_props then

    table.insert(g_props,
    {
        prob           = 0.002,
        min_count    = 1,
        max_count    = 1,    
        offset_y 	= -3,
        entity     = "mods/Apotheosis/files/entities/items/pickups/chest_random_cursed.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.012,
        min_count    = 1,
        max_count    = 1,
        entity     = "mods/Apotheosis/files/entities/items/pickups/chest_random_cursed.xml",
        spawn_check = function() 
            local year, month, day = GameGetDateAndTimeLocal()
            
            if is_holiday_active("april_fools") then
                return true
            else
                return false 
            end
        end,
    })

end




-- Mod Compatibility

--Chemical Curiosities

if ModIsEnabled("Hydroxide") then
    table.insert(g_small_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/sliceLiquid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.018,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/pandorium/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.0012,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/unstablePandorium/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/stophittingyourself/bubble_liquid.xml"
    })
end


--Tablet Ghost
table.insert(g_small_enemies,
{
    prob           = 0.002,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/animals/playerghost_apotheosis/playerghost.xml",
    spawn_check = function() 

        local ghost_count = tonumber( GlobalsGetValue( "apotheosis_tabletghost_count", "0" ) ) or 0
        
        if ghost_count >= 3 then
            return false
        else
            GlobalsSetValue("apotheosis_tabletghost_count", tostring(ghost_count + 1) )
            return true 
        end
    end,
})








--Parallel World Bosses
table.insert(g_small_enemies,
{
    prob           = 0.01,
    min_count    = 1,
    max_count    = 1,
    parallel     = true,
    entity     = "data/entities/buildings/apotheosis_parallel_boss_spawner_alchemist.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.01,
    min_count    = 1,
    max_count    = 1,
    parallel     = true,
    entity     = "data/entities/buildings/apotheosis_parallel_boss_spawner_tentacles.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.01,
    min_count    = 1,
    max_count    = 1,
    parallel     = true,
    entity     = "data/entities/buildings/apotheosis_parallel_boss_spawner_worm.xml"
})