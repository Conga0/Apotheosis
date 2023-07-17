
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	-- do some kind of an effect? throw some particles into the air?

		
	EntityLoad( "data/entities/animals/boss_flesh_monster/boss_flesh_monster_explosion.xml", pos_x, pos_y )
	EntityLoad( "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster.xml", pos_x, pos_y )
	

	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )

	--drop eye
	--drop stone
end
