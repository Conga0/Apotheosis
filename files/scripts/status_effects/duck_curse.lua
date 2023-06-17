
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local projectiles = EntityGetWithTag( "projectile" )

if ( #projectiles > 0 ) then
	for i,projectile_id in ipairs( projectiles ) do
		
		local spritecomponents = EntityGetComponent( projectile_id, "SpriteComponent" )
		for k=1,#spritecomponents
		do local v = spritecomponents[k]
			ComponentSetValue(v,"image_file","data/projectiles_gfx/duck.xml")
		end
	end
end