
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	-- do some kind of an effect? throw some particles into the air?
	
	EntityLoad( "data/entities/animals/boss_flesh_monster/boss_flesh_monster_explosion.xml", pos_x, pos_y )
	local eid = EntityLoad( "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster.xml", pos_x, pos_y )
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/uncaged/create", pos_x, pos_y )

	local incarncomp = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[2]
	local cowardness = tonumber(GlobalsGetValue("HERETIC_COWARDLY"))
	if cowardness ~= nil then
	ComponentSetValue2( incarncomp, "value_int", cowardness)
	end


	LoadPixelScene( "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_mat_5.png", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_5.png", pos_x-56, pos_y-56, "", true )
	
	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )

	--drop eye
	--drop stone
end
