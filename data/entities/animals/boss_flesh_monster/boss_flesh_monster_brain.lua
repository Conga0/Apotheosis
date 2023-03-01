dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000
local voiceplayed = false

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local phase = 0

	local health = 0
	local max_health = 0
	edit_component( entity_id, "DamageModelComponent", function(comp,vars)
		health = tonumber(ComponentGetValue( comp, "hp"))
		max_health = tonumber(ComponentGetValue( comp, "max_hp"))
	end)

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
	

	--Phase 2 starts at 40% hp
	if phase == 1 and ((max_health * 0.4) >= health) then
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_int", 2)

		GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );

		--50% speed boost in phase 2
		local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 24)
		ComponentSetValue2(comp, "force_max", 300)
		
		local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
		for k=1,#comps
		do v = comps[k]
			local script_source_file = ComponentGetValue2(v,"script_source_file")
			if script_source_file == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_mass_status_wounded.lua" then
				ComponentSetValue2(v,"script_source_file","data/entities/animals/boss_flesh_monster/boss_flesh_monster_mass_status_hex_blood.lua")
			end
		end

		--Enable emissive phase 2 glyphs
		EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_liquid",true)

		EntityAddChild(entity_id,EntityLoad("data/entities/animals/boss_flesh_monster/phase_change_particles.xml", pos_x, pos_y))

		EntityAddComponent2(
			entity_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_flesh_monster/boss_flesh_monster_minion_summon_phase2.lua",
				execute_every_n_frame = 10,
				remove_after_executed = false,
				execute_times=7
			}
		)
	end
end
