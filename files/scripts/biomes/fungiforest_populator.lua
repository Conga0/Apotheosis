
table.insert(g_big_enemies,
{
    prob           = 0.025,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/wizard_copeseethmald.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.35,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/lukki_fungus.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/crypt/tentacler_big.xml"
})
    
table.insert(g_big_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/wizard_transmutation.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.15,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungiforest/shaman_greater_apotheosis.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.08,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/blob_huge.xml"
})


--Small enemies

table.insert(g_small_enemies,
{
    prob           = 0.1,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/lukki_fungus.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.2,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/crypt/tentacler_big.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.3,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/poisonmushroom.xml"
})
    
table.insert(g_small_enemies,
{
    prob           = 0.3,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/wizard_transmutation.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.5,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungiforest/ceiling_fungus.xml"
})

table.insert(g_small_enemies,
{
    prob           = 0.07,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungiforest/shaman_greater_apotheosis.xml"
})

if ModIsEnabled("worse_enemies") == false then
    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/blob_big.xml"
    })
end

table.insert(g_small_enemies,
{
    prob           = 0.25,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/fungiforest/fungus_smoking_creep.xml"
})



--New Game +

table.insert(g_small_enemies,
{
    prob           = 0.08,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/crypt/tentacler_big.xml",
    ngpluslevel = 1
})

table.insert(g_small_enemies,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/bubbles/acid/GlassCannon/bubble_liquid.xml",
    ngpluslevel = 1,
})




--props
--Welcome to Wandmart, how may I help you?

table.insert(g_physics_fungi,
{
    prob           = 0.05,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/shoppingcart.xml"
})

table.insert(g_physics_fungi,
{
    prob           = 1.0,
    min_count    = 1,
    max_count    = 1,    
    entity     = ""
})

table.insert(g_physics_fungi,
{
    prob           = 1.0,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/physics_fungus_trip_small.xml"
})

table.insert(g_physics_fungi,
{
    prob           = 1.0,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/physics_fungus_trip.xml"
})

table.insert(g_physics_fungi,
{
    prob           = 1.0,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/physics_fungus_trip_big.xml"
})

table.insert(g_physics_fungi,
{
    prob           = 0.5,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/physics_fungus_trip_hugeish.xml"
})

table.insert(g_physics_fungi,
{
    prob           = 0.4,
    min_count    = 1,
    max_count    = 1,    
    entity     = "mods/Apotheosis/files/entities/props/physics_fungus_trip_huge.xml"
})



--Item Pickups

table.insert(g_items,
{
    prob   		= 0.04,
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
        local world_state = GameGetWorldStateEntity()
        if EntityGetIsAlive(world_state) == false then return false end

        if GameHasFlagRun( "apotheosis_pandora_unleashed" ) then
            return true
        else
            return false 
        end
    end,
})

table.insert(g_items,
{
    prob   		= 0.05,
    min_count	= 1,
    max_count	= 1,    
    entity 	= "mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml",
})