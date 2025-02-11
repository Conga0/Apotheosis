function kick( entity_who_kicked )
    local comp_id = GetUpdatedComponentID()
    if (ComponentGetIsEnabled(comp_id) == true) then
	local entity_id = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(entity_id)

	local kickcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
	local kicks_row = (ComponentGetValue2( kickcomp, "value_int") + 1)
	local kicks_timer = ComponentGetValue2( kickcomp, "value_float")
	local kick_time = 300 --5 seconds

	GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/summon_generic/create", pos_x, pos_y )

	if (GameGetFrameNum() >= kicks_timer + kick_time) then
	    kicks_row = 1
	end

	if (kicks_row >= 3) then
	    EntityLoad( "mods/Apotheosis/files/entities/items/pickups/stone_heretic.xml", pos_x, pos_y )
	    EntityKill(entity_id)
	end

	ComponentSetValue2( kickcomp, "value_int", kicks_row)
	ComponentSetValue2( kickcomp, "value_float", GameGetFrameNum())
    end
end
