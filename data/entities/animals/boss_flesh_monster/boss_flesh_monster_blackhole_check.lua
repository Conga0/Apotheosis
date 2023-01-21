dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )


SetRandomSeed( x, y * GameGetFrameNum() )

local players = EntityGetWithTag( "player_unit" )
local player = players[1]
if player == nil then return end
local plyr_x, plyr_y = EntityGetTransform(player)
local shoot_blackhole = false

local comps = EntityGetComponent( entity_id, "VariableStorageComponent" )
  
local did_hit = RaytraceSurfaces(x, y, plyr_x, plyr_y)
  
if did_hit then

	if ( comps ~= nil ) then
		for k=1, #comps
		do local v = comps[k];
			local n = ComponentGetValue2( v, "name" )
			if ( n == "apotheosis_blackhole_count" ) then
				local checks = ComponentGetValue2( v, "value_int" )
				
				--Failing 4 line of sight checks consecutively causes a blackhole wand to appear
				if checks >= 3 then
					shoot_blackhole = true
					checks = 0
				else
					checks = checks + 1
				end
				
				ComponentSetValue2( v, "value_int", checks )
			end
		end
	end
else
	if ( comps ~= nil ) then
		for k=1, #comps
		do local v = comps[k];
			local n = ComponentGetValue2( v, "name" )
			if ( n == "apotheosis_blackhole_count" ) then
				ComponentSetValue2( v, "value_int", 0 )
			end
		end
	end
end





if shoot_blackhole then
	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	pos_x = pos_x + Random( -60, 60 )
	pos_y = pos_y + Random( -60, 60 )

	target = player


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
		if not angle_inc_set then
			angle_inc = math.rad( Random( 1, 360 ) )
		end
		
		local vel_x = math.cos( angle_inc ) * length
		local vel_y = 0- math.sin( angle_inc ) * length

		shoot_projectile( entity_id, "data/entities/animals/boss_flesh_monster/projectiles/enlightened_blackhole_fire_wand.xml", pos_x, pos_y, vel_x, vel_y )
	end
end