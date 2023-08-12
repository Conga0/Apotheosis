
local targets = EntityGetWithTag( "player_unit" )

local target = targets[1]

EntitySetDamageFromMaterial( target, "lava", 0)