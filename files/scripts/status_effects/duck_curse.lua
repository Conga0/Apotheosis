dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local projectiles = EntityGetWithTag( "projectile" )

if ( #projectiles > 0 ) then
	for i,projectile_id in ipairs( projectiles ) do
		
		local spritecomponents = EntityGetComponent( projectile_id, "SpriteComponent" )
		
		if ( spritecomponents ~= nil ) then
			edit_component( projectile_id, "SpriteComponent", function(comp,vars)
				ComponentSetValue( comp, "image_file", "data/projectiles_gfx/duck.xml" )
			end)
		end
	end
end