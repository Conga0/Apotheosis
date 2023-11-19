
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	-- do some kind of an effect? throw some particles into the air?

		
	EntityLoad( "data/entities/animals/lukki_tentacle_hungry.xml", pos_x, pos_y )
	EntityLoad( "mods/apotheosis/files/entities/misc/flesh_curse_explosion.xml", pos_x, pos_y )
	
end
