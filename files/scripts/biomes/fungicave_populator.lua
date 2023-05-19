---Originally Master of Mallards would spawn here, but he no longer does to avoid over-population. Not every master has to spawn where every other master shows up y'know!
---Unless they're here to do a lil trolling



table.insert(g_big_enemies,
{
    prob           = 0.09,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/wizard_copeseethmald.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungicave/lukki_fungus.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.35,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/tentacler_big.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.35,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/shaman_greater_apotheosis.xml"
})

if ModIsEnabled("worse_enemies") == false then
    table.insert(g_big_enemies,
    {
        prob           = 0.35,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/blob_big.xml"
    })
end


-- Robots

table.insert(g_robots,
{
    prob           = 0.25,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/drone_status_ailment.xml"
})

--[[
table.insert(g_robots,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml"
})
]]--



--Small Enemies

table.insert(g_small_enemies,
{
    prob           = 0.15,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.5,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/ceiling_fungus.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.15,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungus_smoking_creep.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.03,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/hiisi_thief.xml"
})



--New Game +

table.insert(g_big_enemies,
{
    prob           = 0.3,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungicave/lukki_fungus.xml",
    ngpluslevel = 1
})

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/vault/tentacler_big.xml",
    ngpluslevel = 1
})


--Item Pickups

table.insert(g_items,
{
    prob   		= 0.05,
    min_count	= 1,
    max_count	= 1,    
    entity 	= "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml"
})

table.insert(g_items,
{
    prob   		= 0.05,
    min_count	= 1,
    max_count	= 1,    
    entity 	= "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml",
    spawn_check = function() 
        if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
            return true
        else
            return false 
        end
    end,
})

table.insert(g_items,
{
    prob   		= 0.11,
    min_count	= 1,
    max_count	= 1,    
    entity 	= "mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml",
})