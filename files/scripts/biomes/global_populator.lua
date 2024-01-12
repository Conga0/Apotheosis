    
--If the player has over 1,000 max hp, soft-cap heart spawns by disabling random heart generation in the wild
---@diagnostic disable-next-line: lowercase-global
function player_health_check(player_id)
    local player_id = EntityGetWithTag("player_unit")[1]
    if player_id ~= 0 then
        local comp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        if comp ~= nil then
            if ComponentGetValue2(comp,"max_hp") >= 40 then
                return false
            else
                return true
            end
        else return true end
    else return true end
end





--- Rare Bubbles

table.insert(g_big_enemies,
{
    prob           = 0.012,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/ambrosia/bubble_liquid.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.0002,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/magic_catalyst/bubble_liquid.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.0002,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/alchemicprecursor/bubble_liquid.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.0003,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/healthium/bubble_liquid.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.0001,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/voidliquid/bubble_liquid.xml"
})



-- Chaotic Polymorphing Crystal

table.insert(g_big_enemies,
{
    prob           = 0.006,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml"
})

-- Wand Editting Crystal

table.insert(g_small_enemies,
{
    prob           = 0.01,
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
        
        if ( month == 7 ) and (( day >= 20 ) and ( day <= 22 )) then
            return true
        else
            return false 
        end
    end,
})

--Adds extra health ups to the spawn pool if you've openned a Pandora's Chest
table.insert(g_small_enemies,
{
    prob           = 0.01,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/items/pickup/heart.xml",
    spawn_check = function() 
        if GameHasFlagRun( "apotheosis_pandora_unleashed" ) and player_health_check() then
            return true
        else
            return false 
        end
    end,
})


-- New Game +

table.insert(g_big_enemies,
{
    prob           = 0.010,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml",
    ngpluslevel = 1
})

table.insert(g_big_enemies,
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
            
            if ( month == 4 ) and (( day >= 1 ) and ( day <= 3 )) then
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
    table.insert(g_big_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/sliceLiquid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.018,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/pandorium/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.0012,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/unstablePandorium/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/bubbles/stophittingyourself/bubble_liquid.xml"
    })
end

--Inserts tablet ghosts, changes their tablet description based on day rather than random chance, had problems with one ghost overriding the other
local year, month, day, hour = GameGetDateAndTimeLocal()
if (day % 2 == 0) then
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
else
    --Tablet Ghost 2
    table.insert(g_small_enemies,
    {
        prob           = 0.002,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/playerghost_apotheosis/temp/playerghost.xml",
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
end








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