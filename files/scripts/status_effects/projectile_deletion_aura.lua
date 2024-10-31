dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 96

local projectiles = EntityGetInRadiusWithTag( x, y, r, "projectile" )

if ( #projectiles > 0 ) then
	for k=1, #projectiles
	do local projectile_id = projectiles[k];
		EntityKill(projectile_id)
	end
end

