dofile_once( "data/scripts/lib/utilities.lua" )


local entity_id = GetUpdatedEntityID()

local health = 0
local max_health = 0
local newgame_n = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") )

if newgame_n >= 1 then 
    newgame_n = 2 ^ (newgame_n + 1)
    local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

    local health = ComponentGetValue2( comp, "hp" )
    local health_max = ComponentGetValue2( comp, "max_hp" )

    health = health * newgame_n
    health_max = health_max * newgame_n

    ComponentSetValue( comp, "max_hp", tostring(health_max) )
    ComponentSetValue( comp, "hp", tostring(health) )
end