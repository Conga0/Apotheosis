dofile_once("data/scripts/lib/utilities.lua")

-- why does this file have such a convoluted path to get to ): -Spoop
-- nevermind I didn't need the setup in actuality :pensive:

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 200

-- seeing how many shots we've pulled off before disabling self
local varcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local count = ComponentGetValue2( varcomp, "value_int")

if count >= 1 then
	local comp_id = GetUpdatedComponentID()
	EntitySetComponentIsEnabled( entity_id, comp_id, false)
else
	ComponentSetValue2( varcomp, "value_int", count + 1)
end

-- check that we're only shooting every 10 frames

	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	pos_x = pos_x + Random( -20, 20 )
	pos_y = pos_y + Random( -20, 20 )


	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

	target = targets[1]


	local angle_inc = 0
	local angle_inc_set = false

	local length = 250

	if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
		local ex, ey = EntityGetTransform( target )
		
		if ( ex ~= nil ) and ( ey ~= nil ) then
			angle_inc = 0 - math.atan2( ( ey - pos_y ), ( ex - pos_x ) )
			angle_inc_set = true
		end
	end

	local angle = 0
	if angle_inc_set then
		angle = angle_inc + Random( -5, 5 ) * 0.01
	else
		angle = math.rad( Random( 1, 360 ) )
	end
	
	local vel_x = math.cos( angle ) * length
	local vel_y = 0- math.sin( angle ) * length

	shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/lukki_fire_tiny_laser_fire_wand.xml", pos_x, pos_y, vel_x, vel_y )



