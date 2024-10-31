function damage_received( damage, desc, entity_who_caused, is_fatal )

	if damage <= 0 then return end

	local entity_id	= GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	local found = false
	SetRandomSeed(x,y)

	local stains = {
		"water",
		"oil",
		"blood",
	}
	local rnd = Random(1,#stains)

	if EntityHasTag(entity_who_caused,"mortal") then

		EntityAddRandomStains( entity_who_caused, CellFactory_GetType(stains[rnd]), 15 )

		local children = EntityGetAllChildren(entity_who_caused)
		if children ~= nil then
			for k=1,#children
			do v = children[k]
				if EntityGetName(v) == "apotheosis_hex_" .. stains[rnd] then
					found = true
				end
			end

			if found ~= true then
				local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_hex_" .. stains[rnd] .. ".xml", x, y)
				EntityAddChild(entity_who_caused,c)
			end

			local t_x, t_y = EntityGetTransform(entity_who_caused)
			local t = EntityLoad("mods/Apotheosis/files/entities/animators/wraith_fx_alchemy.xml", x, y)
			local comps = EntityGetComponentIncludingDisabled(t,"ParticleEmitterComponent")
			for k=1,#comps
			do v = comps[k]
				ComponentSetValue2(v, "mExPosition", t_x, t_y)
			end
		end

		GameEntityPlaySound( entity_id, "shoot" )
	end
end
