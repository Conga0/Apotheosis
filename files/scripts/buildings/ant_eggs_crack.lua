

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local options = { "ant.xml", "ant_fire.xml", "ant_suffocate.xml", }
	SetRandomSeed(pos_x, pos_y)
	local output = options[Random(1,#options)]

	EntityLoad("data/entities/animals/" .. output, pos_x, pos_y)
	GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/egg/hatch", pos_x, pos_y );
end