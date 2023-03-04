
local apotheosis_HardmodeCheck = false

if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
    apotheosis_HardmodeCheck = true
end

---Hell enemies 

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml"
    })
else
    table.insert(g_big_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml"
    })
end


table.insert(g_small_enemies,
{
    prob           = 0.02,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/sentry.xml"
})


table.insert(g_small_enemies,
{
    prob           = 0.12,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/wizard_firemage_greater.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/poring_devil.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.07,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/gazer_greater.xml"
})



---Heaven enemies



table.insert(g_small_enemies_sky,
{
    prob           = 0.18,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/poring_holy.xml"
})

table.insert(g_small_enemies_sky,
{
    prob           = 0.12,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/wraith_returner_apotheosis.xml"
})

table.insert(g_small_enemies_sky,
{
    prob           = 0.07,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/gazer_greater_sky.xml"
})

table.insert(g_small_enemies_sky,
{
    prob           = 0.08,
    min_count    = 4,
    max_count    = 6,    
    entity     = "data/entities/animals/the_end/fairy_big_discord.xml"
})

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml"
    })
else
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml"
    })
end



table.insert(g_small_enemies_sky,
{
    prob           = 0.01,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml"
})

table.insert(g_small_enemies_sky,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/buildings/the_end/polymorph_crystal.xml"
})






--New Game ++ (2)

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml",
        ngpluslevel = 2
    })
else
    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml",
        ngpluslevel = 2
    })
end



--New Game ++++ (4)

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml",
        ngpluslevel = 4
    })
else
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml",
        ngpluslevel = 4
    })
end