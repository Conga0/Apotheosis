dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000
local voiceplayed = false

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local phase = 0

    local dmgcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
	local health = tonumber(ComponentGetValue( dmgcomp, "hp"))
	local max_health = tonumber(ComponentGetValue( dmgcomp, "max_hp"))

	GlobalsSetValue("HERETIC_HEALTH", tostring(health))
	--print("heretic_health: " .. tostring(GlobalsGetValue("HERETIC_HEALTH")))

	local storages = EntityGetComponent( entity_id, "VariableStorageComponent" )

	--Gets the current Boss phase
	if ( storages ~= nil ) then
		for i,comp in ipairs( storages ) do
			local name = ComponentGetValue2( comp, "name" )
			if ( name == "phase_brain" ) then
				phase = ComponentGetValue2( comp, "value_int" )
				break
			end
		end
	end

	--Transition back to Phase 1 at 60% hp
	if phase == 2 and ((max_health * 0.6) <= health) then
		local storages = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		ComponentSetValue2( storages, "value_int", 1)

		local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		for k=1,#comps
		do v = comps[k]
			local script_source = ComponentGetValue2(v,"script_source_file")
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_2_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2_setup.lua")
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2_setup.lua")
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_barrage_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_hexskull_arc.lua")
			end
		end
		else
		for k=1,#comps
		do v = comps[k]
			local script_source = ComponentGetValue2(v,"script_source_file")
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2.lua")
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_barrage_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_hexskull_arc.lua")
			end
		end
		end
	end
	
	--Phase 2 starts at 50% hp
	if phase == 1 and ((max_health * 0.5) >= health) then
		local storages = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		ComponentSetValue2( storages, "value_int", 2)

		--GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/transition", pos_x, pos_y );
	
		local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")	
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		for k=1,#comps
		do v = comps[k]
			local script_source = ComponentGetValue2(v,"script_source_file")
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_2_setup.lua")
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hexskull_arc.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_barrage_setup.lua")
			end
		end
		else
		for k=1,#comps
		do v = comps[k]
			local script_source = ComponentGetValue2(v,"script_source_file")
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_setup.lua")
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hexskull_arc.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_barrage_setup.lua")
			end
		end
		end

		EntityAddChild(entity_id,EntityLoad("data/entities/animals/boss_flesh_monster/phase_change_particles.xml", pos_x, pos_y))

		EntityAddComponent2(
			entity_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster_minion_summon_flesh.lua",
				execute_every_n_frame = 10,
				remove_after_executed = true,
			}
		)

		EntityAddComponent2(
			entity_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster_minion_summon_flesh_wands.lua",
				execute_every_n_frame = 10,
				remove_after_executed = true,
			}
		)
	end

	if (GameHasFlagRun("apotheosis_flesh_boss_mind_warp") == false and (GameHasFlagRun("apotheosis_flesh_boss_mind_warp_norm") == false or GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") == true)) and (phase >= 2 and phase <= 4) and ModIsEnabled("raksa") == false then
		local player = EntityGetInRadiusWithTag(pos_x, pos_y, 400, "player_unit")[1] or nil
		if player ~= nil then
			GameAddFlagRun("apotheosis_flesh_boss_mind_warp_norm")
			if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
				GameAddFlagRun("apotheosis_flesh_boss_mind_warp")
			end
			local warp_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_mind_warp.xml", pos_x, pos_y)
			EntityAddChild(player, warp_id)
		end
	end
	
	--Transition back to Phase 2 at 40% hp
	if phase == 3 or phase == 4 and ((max_health * 0.4) <= health) then
		local storages = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		ComponentSetValue2( storages, "value_int", 2)

		--GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/transition", pos_x, pos_y );

		--???% speed boost in phase 3
		local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		ComponentSetValue2(comp, "force_coeff", 50)
		ComponentSetValue2(comp, "torque_coeff", 32)
		ComponentSetValue2(comp, "torque_max", 50)
		ComponentSetValue2(comp, "target_vec_max_len", 24)
		else
		ComponentSetValue2(comp, "force_coeff", 32)
		end

		if not GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
		for k=1,#comps
		do v = comps[k]
			local script_source = ComponentGetValue2(v,"script_source_file")
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua" then
				ComponentSetValue2(v,"execute_every_n_frame",3000)
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_2_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_setup.lua")
			end
		end
		end
	end

	--Phase 3 (panic) starts at 25% hp
	if phase == 2 and ((max_health * 0.25) >= health) then
		local storages = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		ComponentSetValue2( storages, "value_int", 3)

		--GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/transition", pos_x, pos_y );

		--???% speed boost in phase 3
		local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		--SPEEEEEEEEDD
		ComponentSetValue2(comp, "force_coeff", 60)
		ComponentSetValue2(comp, "torque_coeff", 100)
		ComponentSetValue2(comp, "torque_max", 300)
		ComponentSetValue2(comp, "target_vec_max_len", 200)
		else
		ComponentSetValue2(comp, "force_coeff", 48)
		end

		if not GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
		for k=1,#comps
		do v = comps[k]
			local script_source = ComponentGetValue2(v,"script_source_file")
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua" then
				ComponentSetValue2(v,"execute_every_n_frame",1800)
			end
			if script_source == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_setup.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_2_setup.lua")
			end
		end
		end

		EntityAddComponent2(
			entity_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua",
				execute_every_n_frame = 10,
				remove_after_executed = true,
			}
		)


		EntityAddComponent2(
			entity_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster_minion_summon_flesh_wands.lua",
				execute_every_n_frame = 10,
				remove_after_executed = true,
			}
		)

		local cid = EntityLoad( "data/entities/animals/boss_flesh_monster/deathlaser/deathlaser_helper_phase4.xml", pos_x, pos_y )
		EntityAddChild( entity_id, cid )
	end

end
