
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		StatsLogPlayerKill( entity_id )
		EntityLoad("mods/Apotheosis/files/entities/items/pickups/toiletpaper_fragment.xml",x,y)
	end
end
