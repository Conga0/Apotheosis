
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local distance_full = 128


function calculate_force_at(body_x, body_y)
	local distance = math.sqrt( ( x - body_x ) ^ 2 + ( y - body_y ) ^ 2 )
	local direction = 0 - math.atan2( ( y - body_y ), ( x - body_x ) )

	local gravity_percent = ( distance_full - distance ) / distance_full
	local gravity_coeff = 196
	
	local fx = math.cos( direction ) * ( gravity_coeff * gravity_percent )
	local fy = -math.sin( direction ) * ( gravity_coeff * gravity_percent )

    return fx,fy
end

-- attract projectiles
local customers = EntityGetInRadiusWithTag(x, y, distance_full, "enemy")
for k=1,#customers
do local v = customers[k]
	local px, py = EntityGetTransform( v )

	local velocitycomp = EntityGetFirstComponentIncludingDisabled( v, "CharacterDataComponent" )
	if ( velocitycomp ~= nil ) then
		local fx, fy = calculate_force_at(px, py)
		local vel_x, vel_y = ComponentGetValue2(velocitycomp,"mVelocity")
				
		vel_x = vel_x + fx
		vel_y = vel_y + fy

		ComponentSetValue2( velocitycomp, "mVelocity", vel_x, vel_y)
	end
end



