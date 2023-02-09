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

		local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
		if( comp ~= nil ) then
			ComponentSetValue( comp, "max_hp", 0 )
			ComponentSetValue( comp, "hp", 0 )
			ComponentSetValue2(comp, "air_needed", true)
			ComponentSetValue2(comp, "air_in_lungs", 0)
		end

		local lukki_new = EntityLoad("data/entities/animals/boss_fire_lukki/boss_fire_lukki_phase2.xml", pos_x, pos_y)


		--Triggers the mass Death Cross attack upon transformation
		local cid = EntityLoad( "data/entities/animals/boss_fire_lukki/projectiles/deathcross_barrage_setup_long.xml", pos_x, pos_y )
		EntityAddChild( lukki_new, cid )


		--Enables the mass Death Cross attack
		EntityAddComponent2(
			lukki_new,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "data/entities/animals/boss_fire_lukki/boss_fire_lukki_deathcross_barrage_setup.lua",
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
				execute_times=16
			}
		)

		--50% speed boost in phase 2
		local comp = EntityGetComponentIncludingDisabled( lukki_new, "PhysicsAIComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 24)
		ComponentSetValue2(comp, "force_max", 300)
		

	end
end
