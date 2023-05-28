dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local r = 126
local targets = EntityGetInRadius( x, y, r )

for k=1,#targets
do local v = targets[k]
    if ( EntityGetName( v ) == "Puppetering Crystal" ) then
        EntityLoad( "mods/Apotheosis/files/entities/projectiles/orb_wands_nodmg.xml", x, y )
    end
end