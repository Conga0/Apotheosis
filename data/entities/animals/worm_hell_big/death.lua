
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	StatsLogPlayerKill( entity_id )

	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		GameAddFlagRun( "apotheosis_miniboss_worm_end_big" )
		AddFlagPersistent( "apotheosis_card_unlocked_worm_end_big" )
		AddFlagPersistent( "apotheosis_card_unlocked_worm_end_big_spell" )
		if GameHasFlagRun("apotheosis_hardmode") then
			AddFlagPersistent( "apotheosis_card_unlocked_worm_end_big_goldmode" )
		end
	end

	local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
	for k=1,#variablecomp
	do local v = variablecomp[k]
	    if ComponentGetValue2(v,"name") == "basic_ai" then
	        variablecomp = v
	        break
	    end
	end
	local chilly_meter = tonumber(ComponentGetValue2( variablecomp, "value_string" ))
	if (chilly_meter > 0) then
		local c = EntityGetAllChildren( entity_id )
		if c ~= nil then
		for a,b in ipairs( c ) do
			local childname = EntityGetName( b )

			if ( childname == "segment" ) then
				local s_x, s_y = EntityGetTransform( b )
				GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/create", s_x, s_y );
			end
		end
		end
	end
end