function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	
	if( is_fatal or Random( 0, 100 ) < 10 ) then
		EntityLoad( "data/entities/animals/lukki_fire_tiny.xml", pos_x, pos_y )
		if ( Random( 1, 8 ) == 8 ) then
			EntityLoad( "data/entities/animals/lukki_fire_tiny.xml", pos_x, pos_y )
		end
		EntityLoad( "mods/apotheosis/files/entities/projectiles/fireball_explosion.xml", pos_x, pos_y )
		EntityKill( entity_id )
	end
end
