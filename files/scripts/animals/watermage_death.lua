
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	local children = EntityGetAllChildren( entity_id )
	if ( children ~= nil ) then
	for a,b in ipairs( children ) do
		local effect_comps = EntityGetComponent(b,"GameEffectComponent") or {}
		for i,v in ipairs( effect_comps ) do
		if ( ComponentGetValue2(v,"effect") == "RADIOACTIVE" ) then
			local damage_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
			ComponentSetValue2(damage_comp, "create_ragdoll", false)
			EntityLoad("data/entities/animals/watermage_toxic.xml",x,y)
			break
		end
		end
	end
	end
end