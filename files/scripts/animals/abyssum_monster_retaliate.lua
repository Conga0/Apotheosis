dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	if Random( 1 , 2 ) == 1 then

		if( entity_who_caused == entity_id ) then return end
		if script_wait_frames( entity_id, 2 ) then  return  end
		
		
		local angle_inc = 0
		local angle_inc_set = false
		
		--Speed the projectiles fly out at, 325 by default
		local length = 250
		
		if ( entity_who_caused ~= nil ) and ( entity_who_caused ~= NULL_ENTITY ) then
			local ex, ey = EntityGetTransform( entity_who_caused )
			
			if ( ex ~= nil ) and ( ey ~= nil ) then
				angle_inc = 0 - math.atan2( ( ey - y ), ( ex - x ) )
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

			local spells = { "orb_psychotic", "deck/star_shot" } --Homebringer curse of swapping would be evil... hmmm
			local rnd = Random( 1, #spells )
			local path = table.concat({"mods/apotheosis/files/entities/projectiles/",spells[rnd],".xml"})

			shoot_projectile( entity_id, path, x, y, vel_x, vel_y )
		end

		--local eid = EntityLoad( "data/entities/animals/boss_flesh_monster/misc/shield_red.xml", x, y )
		--EntityAddChild( entity_id, eid )
		
		GameEntityPlaySound( entity_id, "shoot" )
	end
end
