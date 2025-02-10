dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id	= GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )

	if( entity_who_caused == entity_id ) then return end
	if script_wait_frames( entity_id, 2 ) then  return  end
	
	SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	
	local angle_inc = 0
	local angle_inc_set = false
	
	local length = 600
	
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

		local proj = ""

		local s = EntityGetComponent( entity_id, "VariableStorageComponent" )
		if ( s ~= nil ) then
			for i,v in ipairs( s ) do
				local name = ComponentGetValue2( v, "name" )
				
				if ( name == "proj_file" ) then
					proj_data = SplitStringOnCharIntoTable(ComponentGetValue2( v, "value_string" ), ",")
				end
			end
		end

		local projectile = shoot_projectile( entity_id, proj_data[1], x, y, vel_x, vel_y )
		local projComp = EntityGetFirstComponent( projectile, "ProjectileComponent" )
		ComponentSetValue2( projComp, "damage", tonumber(proj_data[2]) )

		local damagetypes = {
			"melee",
			"explosion",
			"electricity",
			"slice",
			"ice",
			"curse",
			"drill",
			"fire",
			"radioactive",
			"healing",
			"holy",
		}
		
		for k=1,#damagetypes
		do  local v = damagetypes[k]
			ComponentObjectSetValue2( projComp, "damage_by_type", v, tonumber(proj_data[k+2]) )
			if v == "ice" and tonumber(proj_data[k+2]) > 0 then
				ComponentSetValue2(projComp, "damage_game_effect_entities", ComponentGetValue2(projComp,"damage_game_effect_entities") .. "data/entities/misc/effect_frozen.xml,")
			elseif v == "fire" and tonumber(proj_data[k+2]) > 0 then
				ComponentSetValue2(projComp, "damage_game_effect_entities", ComponentGetValue2(projComp,"damage_game_effect_entities") .. "data/entities/misc/effect_apply_on_fire.xml,")
			end
		end

	end
	
	GameEntityPlaySound( entity_id, "shoot" )
end
