function damage_received( damage, desc, entity_who_caused, is_fatal )
	if is_fatal or damage < 0 or not EntityGetIsAlive( entity_who_caused ) then return end

	local entity_id = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(entity_id)

	--Just a funny idea if it ever happens... >:)
	if not EntityHasTag(entity_id,"polymorphed_player") then
		if not EntityHasTag(entity_who_caused,"player_unit") then return end
	end

	local var_comp = nil
	local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
	for i, comp in ipairs(var_comps) do
		if ComponentGetValue2(comp,"name") == "bloodlinker" then
			var_comp = comp
		end
	end

	local frame = ComponentGetValue2(var_comp, "value_int")
	local bloodlinked = ComponentGetValue2(var_comp, "value_bool")

	if ( bloodlinked == false and frame < GameGetFrameNum() ) then
		local animation_length = 234
		local duration = 60 * 10 --Effect lasts for 10 seconds

		ComponentSetValue2(var_comp, "value_bool", true)

		local prot_id = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_protection_all_short_returner.xml", pos_x, pos_y )
		local lifetime_comp = EntityGetFirstComponentIncludingDisabled(prot_id, "LifetimeComponent")
		ComponentSetValue2(lifetime_comp, "lifetime", animation_length)
		local effect_comp = EntityGetFirstComponentIncludingDisabled(prot_id, "GameEffectComponent")
		ComponentSetValue2(effect_comp, "frames", animation_length)
		local effect_comp2 = EntityGetComponentIncludingDisabled(prot_id, "GameEffectComponent")[2]
		ComponentSetValue2(effect_comp2, "frames", animation_length)
		local effect_comp3 = EntityGetComponentIncludingDisabled(prot_id, "GameEffectComponent")[3]
		ComponentSetValue2(effect_comp3, "frames", animation_length)
		EntityAddChild( entity_id, prot_id )

		local effect_id = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_bloodlink_returner.xml", pos_x, pos_y )
		--local lifetime_compe = EntityGetFirstComponentIncludingDisabled(effect_id, "LifetimeComponent")
		--ComponentSetValue2(lifetime_compe, "lifetime", animation_length + duration)
		local effect_compe = EntityGetFirstComponentIncludingDisabled(effect_id, "GameEffectComponent")
		ComponentSetValue2(effect_compe, "frames", animation_length + duration)
		local var_compe = EntityGetFirstComponentIncludingDisabled(effect_id, "VariableStorageComponent")
		ComponentSetValue2(var_compe, "value_int", entity_id)
		EntityAddChild( entity_who_caused, effect_id )

		local effect_id2 = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_bloodlink_returner.xml", pos_x, pos_y )
		local effect_compe2 = EntityGetFirstComponentIncludingDisabled(effect_id2, "GameEffectComponent")
		ComponentSetValue2(effect_compe2, "frames", animation_length + duration)
		local var_compe2 = EntityGetFirstComponentIncludingDisabled(effect_id2, "VariableStorageComponent")
		ComponentSetValue2(var_compe2, "value_int", entity_who_caused)
		EntityAddChild( entity_id, effect_id2 )
		
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/magic/bloodlinked", pos_x, pos_y )

		--Disable movement
		local velocity_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
		local characterdata_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
		EntitySetComponentIsEnabled(entity_id, velocity_comp, false)
		EntitySetComponentIsEnabled(entity_id, characterdata_comp, false)

		local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
		for i, comp in ipairs(sprite_comps) do
			if ComponentHasTag( comp, "enable_when_player_seen" ) or ComponentHasTag( comp, "disabled_by_liquid" ) then
				ComponentRemoveTag(comp, "character" )
				ComponentSetValue2(comp, "rect_animation", "bloodlink")
				ComponentSetValue2(comp, "next_rect_animation", "stand")
			end
		end

		ComponentSetValue2(var_comp, "value_string", tostring(entity_id))

		--MMmm animatioonnnzzzz
		EntityAddComponent(entity_id, "LuaComponent", {
			script_source_file="mods/Apotheosis/files/scripts/animals/wizard_corrupt_returner_bloodlink_end.lua",
			execute_every_n_frame=animation_length,
			execute_on_added=0,
			remove_after_executed=1
		}) 
	end
end
