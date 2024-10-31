dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000
local voiceplayed = false

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y, rot = EntityGetTransform( entity_id )
	local phase = 0
	local armor = 0

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
				armor = ComponentGetValue2( comp, "value_float" )
				break
			end
		end
	end
	
	--Phase 2 starts at 40% hp
	if phase == 1 and ((max_health * 0.4) >= health) then
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_int", 2)

		--GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/transition", pos_x, pos_y );

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
	

	--Phase 3 (panic) starts at 10% hp
	if phase == 2 and ((max_health * 0.1) >= health) then
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_int", 3)

		--GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/transition", pos_x, pos_y );

		--200% speed boost in phase 2
		local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
		ComponentSetValue2(comp, "force_coeff", 48)
		ComponentSetValue2(comp, "force_max", 600)

		local cid = EntityLoad( "data/entities/animals/boss_flesh_monster/deathlaser/deathlaser_helper_phase3.xml", pos_x, pos_y )
		EntityAddChild( entity_id, cid )

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

	--Handles Heretic's armor breakage
	if armor == 0 and ((max_health * 0.3) >= health) and not GameHasFlagRun("apotheosis_flesh_boss_armor_1") then
		GameAddFlagRun("apotheosis_flesh_boss_armor_1")
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_float", 1)

		local spritecomp = 0
		local spritecomp2 = 0
		local spritecomps = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent") or {}
		for i = 1, #spritecomps do
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor.png" then
		        spritecomp = spritecomps[i]
		    end
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_emissive.png" then
		        spritecomp2 = spritecomps[i]
		    end
		end
		ComponentSetValue2( spritecomp, "image_file", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_1.png")
		ComponentSetValue2( spritecomp2, "image_file", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_emissive_alt.png")
		EntityRefreshSprite( entity_id, spritecomp )
		EntityRefreshSprite( entity_id, spritecomp2 )
		LoadPixelScene( "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_mat_1.png", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_1.png", pos_x-56, pos_y-56, "", true )
		EntityLoad( "data/entities/particles/blood_explosion.xml", pos_x - 26, pos_y - 26 )
		armor = 1
	end

	if armor == 1 and ((max_health * 0.25) >= health) and not GameHasFlagRun("apotheosis_flesh_boss_armor_2") then
		GameAddFlagRun("apotheosis_flesh_boss_armor_2")
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_float", 2)

		local spritecomp = 0
		local spritecomps = EntityGetComponent(entity_id, "SpriteComponent") or {}
		for i = 1, #spritecomps do
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_1.png" then
		        spritecomp = spritecomps[i]
			break
		    end
		end
		ComponentSetValue2( spritecomp, "image_file", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_2.png")
		EntityRefreshSprite( entity_id, spritecomp )
		LoadPixelScene( "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_mat_2.png", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_2.png", pos_x-56, pos_y-56, "", true )
		EntityLoad( "data/entities/particles/blood_explosion.xml", pos_x - 23, pos_y + 28 )
		armor = 2
	end

	if armor == 2 and ((max_health * 0.2) >= health) and not GameHasFlagRun("apotheosis_flesh_boss_armor_3") then
		GameAddFlagRun("apotheosis_flesh_boss_armor_3")
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_float", 3)

		local spritecomp = 0
		local spritecomps = EntityGetComponent(entity_id, "SpriteComponent") or {}
		for i = 1, #spritecomps do
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_2.png" then
		        spritecomp = spritecomps[i]
			break
		    end
		end
		ComponentSetValue2( spritecomp, "image_file", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_3.png")
		EntityRefreshSprite( entity_id, spritecomp )
		LoadPixelScene( "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_mat_3.png", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_3.png", pos_x-56, pos_y-56, "", true )
		EntityLoad( "data/entities/particles/blood_explosion.xml", pos_x + 28, pos_y - 25 )
		armor = 3
	end

	if armor == 3 and ((max_health * 0.15) >= health) and not GameHasFlagRun("apotheosis_flesh_boss_armor_4") then
		GameAddFlagRun("apotheosis_flesh_boss_armor_4")
		local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_float", 4)

		local spritecomp = 0
		local spritecomps = EntityGetComponent(entity_id, "SpriteComponent") or {}
		for i = 1, #spritecomps do
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_3.png" then
		        spritecomp = spritecomps[i]
			break
		    end
		end
		ComponentSetValue2( spritecomp, "image_file", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_4.png")
		EntityRefreshSprite( entity_id, spritecomp )
		LoadPixelScene( "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_mat_4.png", "mods/apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_4.png", pos_x-56, pos_y-56, "", true )
		EntityLoad( "data/entities/particles/blood_explosion.xml", pos_x + 29, pos_y + 29 )
		armor = 4
	end

end
