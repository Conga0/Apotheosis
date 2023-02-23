dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	local health = 0
	local max_health = 0
	edit_component( entity_id, "DamageModelComponent", function(comp,vars)
		health = tonumber(ComponentGetValue( comp, "hp"))
		max_health = tonumber(ComponentGetValue( comp, "max_hp"))
	end)
	

	--Phase 2 starts at 40% hp
	if (max_health * 0.4) >= health then
		local storages = EntityGetComponentIncludingDisabled( entity_id, "LuaComponent" )
		for k=1,#storages
		do local v = storages[k]
			if ComponentGetValue2( v, "script_death") == "mods/Apotheosis/files/scripts/animals/lukki_fire_miniboss_death_phase1.lua" then
				ComponentSetValue2(v, "script_death", "")
				EntitySetComponentIsEnabled(entity_id, v, false)
			end
		end

		GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );

		local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
		if( comp ~= nil ) then
			ComponentSetValue( comp, "max_hp", 0 )
			ComponentSetValue( comp, "hp", 0 )
			ComponentSetValue2(comp, "air_needed", true)
			ComponentSetValue2(comp, "air_in_lungs", 0)
		end

		local lukki_new = EntityLoad("data/entities/animals/secret/lukki_fire_miniboss_phase2.xml", pos_x, pos_y)

		--Spits out a ton of firebolts when the rocks break
		EntityAddComponent2(
			lukki_new,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_fire_lukki/boss_fire_lukki_healing_phase_logic_lowhp_burst.lua",
				execute_every_n_frame = 1,
				remove_after_executed = false,
				execute_times=7
			}
		)

		--50% speed boost in phase 2
		local comp = EntityGetComponentIncludingDisabled( lukki_new, "PhysicsAIComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 24)
		ComponentSetValue2(comp, "force_max", 300)
	end
end
