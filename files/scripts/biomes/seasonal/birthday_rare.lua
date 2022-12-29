


table.insert(g_small_enemies,
{
    prob   		= 0.05,
    min_count	= 5,
    max_count	= 7,    
    entity 	= "data/entities/animals/rat_birthday.xml",
})









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