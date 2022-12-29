local apotheosis_HardmodeCheck = false

if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
    apotheosis_HardmodeCheck = true
end

---Hell enemies 

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml"
    })
else
    table.insert(g_big_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml"
    })
end

table.insert(g_small_enemies,
{
    prob           = 0.12,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poring_devil.xml"
})



---Heaven enemies

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml"
    })
else
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml"
    })
end

table.insert(g_small_enemies_sky,
{
    prob           = 0.12,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poring_holy.xml"
})



table.insert(g_small_enemies_sky,
{
    prob           = 0.02,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml"
})

table.insert(g_small_enemies_sky,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,
    entity     = "data/entities/buildings/polymorph_crystal.xml"
})



--New Game ++ (2)

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml",
        ngpluslevel = 2
    })
else
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
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
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml",
        ngpluslevel = 4
    })
else
    table.insert(g_big_enemies_sky,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml",
        ngpluslevel = 4
    })
end