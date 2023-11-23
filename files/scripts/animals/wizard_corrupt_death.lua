
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	EntityLoad( "mods/Apotheosis/files/entities/misc/wizard_corrupt_death_check.xml", pos_x, pos_y )
end