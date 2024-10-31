function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id = GetUpdatedEntityID()

	local c = EntityGetAllChildren( entity_id )
	for a,b in ipairs( c ) do
		local effectname = EntityGetName( b )

		if ( effectname == "bloodlink" ) then
			local linked_id = 0
			local var_comp = EntityGetFirstComponentIncludingDisabled(b, "VariableStorageComponent") or {}
			linked_id = ComponentGetValue2(var_comp, "value_int")

			if ( entity_who_caused == linked_id ) then
				EntityInflictDamage( linked_id, damage, "DAMAGE_CURSE", "$status_apotheosis_bloodlink_death", "DISINTEGRATED", 0, 0 )
			end
		end
	end
end
