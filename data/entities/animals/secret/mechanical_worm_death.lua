
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y )

	-- do some kind of an effect? throw some particles into the air?
	local rng = Random(1,50)

	if rng == 1 then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/aimbot_wand.xml", pos_x, pos_y )
		EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_red.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
	elseif rng == 2 then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/mana_battery.xml", pos_x, pos_y )
		EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_red.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
	end
end