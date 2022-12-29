

if g_small_enemies then
    table.insert(g_small_enemies,
    {
        prob   		= 0.3,
        min_count	= 2,
        max_count	= 3,    
        entity 	= "data/entities/animals/rat_birthday.xml",
    })
end

if g_lamp then
    table.insert(g_lamp,
    {
        prob   		= 0.3,
        min_count	= 5,
        max_count	= 5,    
        entity 	= "mods/Apotheosis/files/entities/special/rgb_fairy_spawner.xml",
    })
end








--[[
table.insert(g_small_enemies,
{
    prob   		= 0.4,
    min_count	= 1,
    max_count	= 2,    
    entity 	= "data/entities/animals/rat_birthday.xml",
    spawn_check = function() 
        local year, month, day = GameGetDateAndTimeLocal()
        
        if ( month == 9 ) and (( day >= 21 ) and (day <= 23 )) then
            return true
        else
            return false 
        end
    end,
})
]]--