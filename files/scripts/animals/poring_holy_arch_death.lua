
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y )

	-- do some kind of an effect? throw some particles into the air?
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/gourd_holy.xml", pos_x, pos_y )
	if not GameHasFlagRun("apotheosis_porring_hinted") then
		EntityLoad( "mods/Apotheosis/files/entities/misc/porring_hint.xml", pos_x, pos_y )
		EntityLoad( "data/entities/particles/image_emitters/wand_effect.xml", pos_x, pos_y )
		GameAddFlagRun("apotheosis_porring_hinted")
	end

	local rng = Random( 1, 500)

	if rng == 500 then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml", pos_x, pos_y )
		EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_blue.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
	elseif rng > 495 then
		EntityLoad( "data/entities/animals/fairy_cheap.xml", pos_x, pos_y )
	end
end