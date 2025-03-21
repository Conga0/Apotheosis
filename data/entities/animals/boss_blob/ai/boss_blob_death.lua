
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	--If this doesn't work I'm confused
	local x,y = EntityGetTransform(GetUpdatedEntityID())
	EntityLoad("data/entities/animals/boss_blob/ai/boss_blob_death_check.xml",x,y)
end
