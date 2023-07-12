
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	AddFlagPersistent("apotheosis_card_unlocked_boss_monolith")

	EntityLoad("data/entities/items/pickup/chest_random_super.xml", pos_x, pos_y - 400)
end