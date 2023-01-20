dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )


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
	local angle = Random( 1, 200 ) * math.pi
	local vel_x = math.cos( angle ) * 100
	local vel_y = 0 - math.cos( angle ) * 100
	
	local path = "data/entities/projectiles/deck/black_hole.xml"
	
	local wid = shoot_projectile( entity_id, "data/entities/animals/boss_pit/wand.xml", x, y, vel_x, vel_y )
	edit_component( wid, "VariableStorageComponent", function(comp,vars)
		ComponentSetValue2( comp, "value_string", path )
	end)
	
	EntityAddComponent( wid, "HomingComponent", 
	{ 
		homing_targeting_coeff = "30.0",
		homing_velocity_multiplier = "0.16",
		target_tag = "player_unit",
	} )
	
	EntityAddComponent( wid, "VariableStorageComponent", 
	{ 
		name = "mult",
		value_float = 0.15,
	} )
end