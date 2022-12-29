dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000

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

		--Updates Sprite to phase 2, rocks break off
		--local comp = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent")[1]
		--ComponentSetValue2( comp, "image_file", "mods/Apotheosis/files/enemies_gfx/fire_lukki/fire_lukki_phase2.xml")
		--
		--local cid = EntityLoad( "data/entities/animals/boss_fire_lukki/gore/cell_eater_toggle.xml", pos_x, pos_y )
		--EntityAddChild( entity_id, cid )
		--
		--Unnecessary to change sprite & play gore, since gore is handled by killing the existing lukki so limb positions are maintained for a satisfying crunch effect

		GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );

		local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
		if( comp ~= nil ) then
			ComponentSetValue( comp, "max_hp", 0 )
			ComponentSetValue( comp, "hp", 0 )
			ComponentSetValue2(comp, "air_needed", true)
			ComponentSetValue2(comp, "air_in_lungs", 0)
		end

		local lukki_new = EntityLoad("data/entities/animals/gold_bosses/boss_fire_lukki/boss_fire_lukki_phase2.xml", pos_x, pos_y)


		--Triggers the mass Death Cross attack upon transformation
		local cid = EntityLoad( "data/entities/animals/boss_fire_lukki/projectiles/deathcross_barrage_setup_long.xml", pos_x, pos_y )
		EntityAddChild( lukki_new, cid )


		--Enables the mass Death Cross attack
		EntityAddComponent2(
			lukki_new,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/gold_bosses/boss_fire_lukki/boss_fire_lukki_deathcross_barrage_setup.lua",
				execute_every_n_frame = 2400,
				remove_after_executed = false,
				execute_times=-1
			}
		)

		--Spits out a ton of firebolts when the rocks break
		EntityAddComponent2(
			lukki_new,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_fire_lukki/boss_fire_lukki_healing_phase_logic_lowhp_burst.lua",
				execute_every_n_frame = 1,
				remove_after_executed = false,
				execute_times=20
			}
		)

		--50% speed boost in phase 2
		local comp = EntityGetComponentIncludingDisabled( lukki_new, "PhysicsAIComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 30)
		ComponentSetValue2(comp, "force_max", 350)
		

	end
	
	--Phase 3 starts at 10% hp
	if phase == 2 and ((max_health * 0.1) >= health) then
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_int", 3)

		--Initiate Healing Phase, even if it's on cooldown
		--Phase 4 is initiated afterwards to reallow normal healing to avoid overlapping
		local cid = EntityLoad( "data/entities/animals/boss_fire_lukki/misc/healing_phase_helper.xml", pos_x, pos_y )
		EntityAddChild( entity_id, cid )
		last_frame = GameGetFrameNum()
		
		--Causes the boss to spit out a lot of fire bolts in it's final phase 3 panic
		EntityAddComponent2(
			entity_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_fire_lukki/boss_fire_lukki_healing_phase_logic_lowhp_burst.lua",
				execute_every_n_frame = 7,
				remove_after_executed = false,
				execute_times=51
			}
		)


		--Removes the old healing logic to save on performance
		local storages = EntityGetComponent( root_id, "LuaComponent" )
		if ( storages ~= nil ) then
			for i,comp in ipairs( storages ) do
				local name = ComponentGetValue2( comp, "script_damage_received" )
				if ( name == "data/entities/animals/boss_fire_lukki/boss_fire_lukki_healing_phase_logic.lua" ) then
					EntityRemoveComponent( entity_id, comp )
					break
				end
			end
		end

		--Sudden rage speed in panic healing
		local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
		local comp_pathing = EntityGetComponentIncludingDisabled( entity_id, "PathFindingComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 70)
		ComponentSetValue2(comp, "force_balancing_coeff", 0.8)
		ComponentSetValue2(comp, "force_max", 4000)
		ComponentSetValue2(comp, "target_vec_max_len", 150)

		ComponentSetValue2(comp_pathing, "distance_to_reach_node_x", 2000)
		ComponentSetValue2(comp_pathing, "distance_to_reach_node_y", 2000)
		ComponentSetValue2(comp_pathing, "frames_between_searches", 10)
		ComponentSetValue2(comp_pathing, "frames_to_get_stuck", 50)
	end


	--Phase 4 starts at 10% hp when the panic healing phase ends
	if phase == 4 then
		local frame = GameGetFrameNum()
		if( entity_who_caused == entity_id ) or (frame <= last_frame + 60*13) then return end
	
		local minion_count = 5
		local minion_interval = max_health / minion_count
		
		local new_health = health - damage
		local nearest_interval = math.floor( health / minion_interval ) * minion_interval
		
		local limit = 5
		local count = 0
		
		while (nearest_interval > new_health) and (count < limit) and (nearest_interval >= 0) do
			local eid = EntityLoad( "data/entities/animals/boss_fire_lukki/misc/healing_phase_helper.xml", pos_x, pos_y )
			EntityAddChild( entity_id, eid )
			
			nearest_interval = nearest_interval - minion_interval
	
			last_frame = GameGetFrameNum()
			
			count = count + 1
		end

		--33% speed boost in phase 4
		local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
		local comp_pathing = EntityGetComponentIncludingDisabled( entity_id, "PathFindingComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 30)
		ComponentSetValue2(comp, "force_balancing_coeff", 0.9)
		ComponentSetValue2(comp, "force_max", 600)
		ComponentSetValue2(comp, "target_vec_max_len", 40)

		ComponentSetValue2(comp_pathing, "distance_to_reach_node_x", 40)
		ComponentSetValue2(comp_pathing, "distance_to_reach_node_y", 40)
		ComponentSetValue2(comp_pathing, "frames_between_searches", 15)
		ComponentSetValue2(comp_pathing, "frames_to_get_stuck", 90)
	end
end
