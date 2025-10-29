function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	AddFlagPersistent( "apotheosis_card_unlocked_constellation_jellyfish" )
	
	EntityLoad("mods/Apotheosis/files/entities/items/pickups/orb_jellyfish_pearl.xml",pos_x,pos_y)
end
