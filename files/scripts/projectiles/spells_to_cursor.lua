dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local length = 400

local projectiles = EntityGetWithTag( "projectile" )

if ( #projectiles > 0 ) then
	local player = EntityGetWithTag( "player_unit" )[1]
	local cx, cy = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")

	for i,projectile_id in ipairs( projectiles ) do
		local tags = EntityGetTags( projectile_id )
		
		if ( tags == nil ) or ( string.find( tags, "acid" ) == nil ) then
			local px, py = EntityGetTransform( projectile_id )
			
			local velocitycomponents = EntityGetComponent( projectile_id, "VelocityComponent" )
			
			if ( velocitycomponents ~= nil ) then
				local angle_inc = 0 - math.atan2( ( cx - py ), ( cx - px ) )
				local angle = angle_inc * 0.001
				local vel_x = math.cos( angle ) * length
				local vel_y = 0- math.sin( angle ) * length

				edit_component( projectile_id, "VelocityComponent", function(comp,vars)
					vel_x,vel_y = ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
				end)
			end
		end
	end
end


