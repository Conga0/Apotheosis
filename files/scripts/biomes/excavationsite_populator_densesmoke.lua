
-- Creates a field of dense smoke

table.insert(g_props,
{
    prob           = 0.30,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/buildings/smoke_dense_creator_apotheosis.xml"
})

table.insert(g_props2,
{
    prob           = 0.30,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/buildings/smoke_dense_creator_apotheosis.xml"
})

table.insert(g_props3,
{
    prob           = 0.30,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/buildings/smoke_dense_creator_apotheosis.xml"
})

table.insert(g_big_enemies,
{
    prob           = 0.01,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/animals/illusions/dark_alchemist.xml",
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