
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y )

	-- do some kind of an effect? throw some particles into the air?

	if ( Random( 1, 500 ) == 500 ) then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml", pos_x, pos_y )
		EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_blue.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
	end
end