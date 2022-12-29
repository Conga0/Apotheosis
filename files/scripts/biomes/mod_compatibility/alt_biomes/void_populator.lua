local apotheosis_HardmodeCheck = false

if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
    apotheosis_HardmodeCheck = true
end


table.insert(g_big_enemies,
{
    prob           = 0.02,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/wizard_copeseethmald.xml"
})

if apotheosis_HardmodeCheck then 
    table.insert(g_big_enemies,
    {
        prob           = 0.025,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gold_bosses/angel/angel.xml"
    })
else
    table.insert(g_big_enemies,
    {
        prob           = 0.025,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/angel.xml"
    })
end



--Small Enemies

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/devourer_ghost.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.09,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/voidliquid/bubble_liquid.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/musical_being.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.12,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/the_end/ghost_bow.xml"
})



table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poring_devil.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.06,
    min_count    = 6,
    max_count    = 8,
    entity     = "data/entities/animals/the_end/fairy_big_discord.xml"
})