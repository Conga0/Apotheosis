
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local r = 126
local targets = EntityGetInRadius( x, y, r )

for i,v in ipairs( targets ) do
    if ( EntityGetName( v ) == "Polymorph Crystal" ) then
        EntityLoad( "mods/Apotheosis/files/entities/projectiles/orb_poly_crystal.xml", x, y )
    end
end

EntityKill( entity_id )