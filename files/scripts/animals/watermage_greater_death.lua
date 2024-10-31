
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)
	EntityLoad("mods/apotheosis/files/entities/projectiles/aquamine_nolla.xml",x,y)
end