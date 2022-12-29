
table.insert(g_big_enemies,
{
    prob           = 0.025,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/wizard_copeseethmald.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.15,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/lukki_fungus.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/giant_centipede.xml"
})

--Small enemies

table.insert(g_small_enemies,
{
    prob           = 0.07,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/lukki_fungus.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poisonmushroom.xml"
})

local ambrosiaFairies = ModSettingGet( "Apotheosis.fairy_immortality" )

if ambrosiaFairies == true then
    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 6,
        max_count    = 12,    
        entity     = "data/entities/animals/cat_immortal/fairy_cheap.xml"
    })
else
    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 6,
        max_count    = 12,    
        entity     = "data/entities/animals/fairy_cheap.xml"
    })
end

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 2,
    max_count    = 5,    
    entity     = "data/entities/animals/fairy_big.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 3,
    max_count    = 5,    
    entity     = "data/entities/animals/fairy_big_discord.xml"
})



--New Game +

table.insert(g_small_enemies,
{
    prob           = 0.15,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/crypt/tentacler_big.xml",
    ngpluslevel = 1
})




--props
--Welcome to Wandmart, how may I help you?

table.insert(g_physics_fungi,
{
    prob           = 0.25,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/shoppingcart.xml"
})