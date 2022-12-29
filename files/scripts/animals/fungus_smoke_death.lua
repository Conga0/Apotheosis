dofile_once("data/scripts/lib/utilities.lua")

-- kill self

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	-- do some kind of an effect? throw some particles into the air?
	EntityLoad( "mods/Apotheosis/files/entities/projectiles/fungus_tiny_explosion.xml", pos_x, pos_y )
	


	local how_many = 10
	local angle_inc = ( 2 * 3.14159 ) / how_many
	local theta = 0
	local length = 150 --Originally 200.. but needs to be artifically made faster to compensate for moist modifier decreasing projectile speed
	
	for i=1,how_many do
		local vel_x = math.cos( theta ) * length
		local vel_y = math.sin( theta ) * length
		theta = theta + angle_inc
	
		shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/fungus_smoke_maker.xml", pos_x, pos_y, vel_x, vel_y )
	end
	
	
	

end

function collision_trigger_timer_finished()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	-- do some kind of an effect? throw some particles into the air?
	EntityLoad( "mods/Apotheosis/files/entities/projectiles/fungus_tiny_explosion.xml", pos_x, pos_y )
	
	
	local how_many = 20
	local angle_inc = ( 2 * 3.14159 ) / how_many
	local theta = 0
	local length = 350 --Originally 200.. but needs to be artifically made faster to compensate for moist modifier decreasing projectile speed
	
	for i=1,how_many do
		local vel_x = math.cos( theta ) * length
		local vel_y = math.sin( theta ) * length
		theta = theta + angle_inc
	
		shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/fungus_smoke_maker.xml", pos_x, pos_y, vel_x, vel_y )
	end
	

end