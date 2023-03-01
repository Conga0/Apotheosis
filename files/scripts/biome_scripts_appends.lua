--If the player has over 1,000 max hp, soft-cap heart spawns by disabling random heart generation in the wild
function player_health_check(player_id)
	local player_id = EntityGetWithTag("player_unit")[1]
	if player_id ~= 0 then
		local comp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
		if comp ~= nil then
			if ComponentGetValue2(comp,"max_hp") >= 40 then
				return false
			else
				return true
			end
		else return true end
	else return true end
end


function spawn_heart( x, y )
	local r = ProceduralRandom( x, y )
	SetRandomSeed( x, y )
	local heart_spawn_percent = 0.7
	
	local year, month, day = GameGetDateAndTimeLocal()
	if ( month == 2 ) and ( day == 14 ) then heart_spawn_percent = 0.35 end


	if (r > heart_spawn_percent) and player_health_check() then
		local entity = EntityLoad( "data/entities/items/pickup/heart.xml", x, y)
	elseif (r > 0.3) then
		SetRandomSeed( x+45, y-2123 )
		local rnd = Random( 1, 100 )
		
		if (rnd <= 90) or (y < 512 * 3) then
			rnd = Random( 1, 1000 )
			
			if( Random( 1, 300 ) == 1 ) then spawn_mimic_sign( x, y ) end

			if ( rnd < 1000 ) then
				local entity = EntityLoad( "data/entities/items/pickup/chest_random.xml", x, y)
			else
				local entity = EntityLoad( "data/entities/items/pickup/chest_random_super.xml", x, y)
			end
		else
			rnd = Random( 1, 100 )
			if( Random( 1, 30 ) == 1 ) then spawn_mimic_sign( x, y ) end

			if( rnd <= 95 ) then
				local entity = EntityLoad( "data/entities/animals/chest_mimic.xml", x, y)
			else
				local entity = EntityLoad( "data/entities/items/pickup/chest_leggy.xml", x, y)
			end
		end
	end
end
