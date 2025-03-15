    

table.insert(g_small_enemies,
{
    prob           = 0.25,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/hisii_hobo.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.35,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/hisii_hobo.xml",
    ngpluslevel = 1
})

table.insert(g_small_enemies,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/waterskull.xml",
})


RegisterSpawnFunction( 0xffb0742e, "spawn_book" )
RegisterSpawnFunction( 0xff2fc6ec, "spawn_quest_point" )

function spawn_book(x, y)
    EntityLoad("mods/Apotheosis/files/entities/items/books/book_wiseguy_taunt.xml", x, y)
end

function spawn_quest_point(x, y)
    EntityLoad("mods/Apotheosis/files/entities/buildings/wiseguy_taunt_questcheck.xml", x, y)
end