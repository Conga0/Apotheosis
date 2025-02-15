
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	EntityLoad("mods/Apotheosis/files/entities/items/pickups/pearl_1000.xml",x,y)
	EntityLoad("mods/Apotheosis/files/entities/items/pickups/pearl.xml",x,y)
	EntityLoad("mods/Apotheosis/files/entities/items/pickups/pearl.xml",x,y)
	EntityLoad("mods/Apotheosis/files/entities/items/pickups/pearl.xml",x,y)
	EntityLoad("mods/Apotheosis/files/entities/items/pickups/pearl.xml",x,y)
	EntityLoad("mods/Apotheosis/files/entities/items/pickups/pearl.xml",x,y)
end
