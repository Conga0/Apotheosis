dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

-- check that we're only shooting every 10 frames

	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	pos_x = pos_x + Random( -150, 150 )
	pos_y = pos_y + Random( -150, 150 ) --originally only up to a 90 off set


	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

	target = targets[1]


	local angle_inc = 0
	local angle_inc_set = false

	local length = 2

	if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
		local ex, ey = EntityGetTransform( target )
		
		if ( ex ~= nil ) and ( ey ~= nil ) then
			angle_inc = 0 - math.atan2( ( ey - pos_y ), ( ex - pos_x ) )
			angle_inc_set = true
		end
	end

	for i=1,2 do
		local angle = 0
		if angle_inc_set then
			angle = angle_inc + Random( -5, 5 ) * 0.01
		else
			angle = math.rad( Random( 1, 360 ) )
		end
		
		local vel_x = math.cos( angle ) * length
		local vel_y = 0- math.sin( angle ) * length

		shoot_projectile( entity_id, "data/entities/animals/boss_water_lukki/projectiles/deathcross_cross.xml", pos_x, pos_y, vel_x, vel_y )
	end


