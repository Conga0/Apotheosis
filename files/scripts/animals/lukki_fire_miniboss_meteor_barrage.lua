dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

-- check that we're only shooting every 10 frames

	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	pos_x = pos_x + Random( -40, 40 )
	pos_y = pos_y + Random( -40, 40 )


	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

	target = targets[1]


	local angle_inc = 0
	local angle_inc_set = false

	local length = 1.25

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

	shoot_projectile( parent_id, "mods/apotheosis/files/entities/projectiles/lukki_fire_miniboss_laser_fire_wand.xml", pos_x, pos_y, vel_x, vel_y )



