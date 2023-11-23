--Herobrine

table.insert(g_big_enemies,
{
    prob           = 0.002,
    min_count    = 1,
    max_count    = 1,    
    entity     = "data/entities/buildings/herobrine.xml",
    spawn_check = function() 
        local year, month, day, hour = GameGetDateAndTimeLocal()

        --Only spawns between 11pm and 4am
        if hour >= 23 or hour <= 4 then
            return true
        else
            return false 
        end
    end,
})