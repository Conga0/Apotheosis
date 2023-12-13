dofile_once( "data/scripts/lib/coroutines.lua" )
dofile_once( "data/scripts/lib/utilities.lua" )
local entity_id = GetUpdatedEntityID()
local is_dead = false
local phase_boss
local death_sound_started

function damage_received( damage, desc, entity_who_caused, is_fatal )
    entity_id = GetUpdatedEntityID()
    phase_boss = check_phase()
    --GamePrint("Current Phase is " .. tostring(phase_boss))
    check_death()
    --GamePrint("Damage Taken")
    --GamePrint("Is Dead state is currently " .. tostring(is_dead))
end

function check_phase()
    local phase = 0

    local storages = EntityGetComponent( entity_id, "VariableStorageComponent" )
    
    --Gets the current Boss phase
    if ( storages ~= nil ) then
        for i,comp in ipairs( storages ) do
            local name = ComponentGetValue2( comp, "name" )
            if ( name == "phase_brain" ) then
                phase = ComponentGetValue2( comp, "value_int" )
                return phase
            end
        end
    end
end

-- The boss can't die normally; if their HP is zero, this does stuff instead
function check_death()
	--if is_dead then return end
	
	SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )

	local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "DamageModelComponent" )
	if( comp ~= nil ) then
        --GamePrint("FOUND DMG COMPONENT")
		local hp = ComponentGetValueFloat( comp, "hp" )
		local max_hp = ComponentGetValueFloat( comp, "max_hp" )
        local pos_x, pos_y = EntityGetTransform( entity_id )

		-- check death
		if ( hp <= 0.0 ) and (is_dead ~= true) and (phase_boss == 4) then
            --GamePrint("IM DEAD")
			GameTriggerMusicFadeOutAndDequeueAll()
			if death_sound_started == false then
                GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/dying", pos_x, pos_y );
				death_sound_started = true
			end

            --DisableAI from attacking while dying
            local compLua = EntityGetComponentIncludingDisabled( entity_id, "LuaComponent" )
            if compLua ~= nil then
                for i,v in ipairs(compLua) do
                    local name = ComponentGetValue2(v, "script_source_file")
                    if name == "data/entities/animals/boss_fire_lukki/boss_fire_lukki_mass_status_fire.lua" or name == "data/entities/animals/boss_fire_lukki/boss_fire_lukki_circle_explosion.lua" or name == "data/entities/animals/boss_fire_lukki/boss_fire_lukki_meteor_barrage_setup.lua" then
                        EntityRemoveComponent(entity_id, v)
                    end

                    name = ComponentGetValue2(v, "script_damage_received")
                    if name == "data/entities/animals/boss_fire_lukki/boss_fire_lukki_retaliation_attack_script.lua" then
                        EntityRemoveComponent(entity_id, v)
                    end
                end
            end

            --Disables AI from triggering a healing phase while dying
            local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
            ComponentSetValue2( storages, "value_int", 5)

            --Panicked movement during death
            local comp = EntityGetComponentIncludingDisabled( entity_id, "PhysicsAIComponent")[1]
            local comp_pathing = EntityGetComponentIncludingDisabled( entity_id, "PathFindingComponent")[1]
            ComponentSetValue2(comp, "force_coeff", 70)
            ComponentSetValue2(comp, "force_balancing_coeff", 0.8)
            ComponentSetValue2(comp, "force_max", 4000)
            ComponentSetValue2(comp, "target_vec_max_len", 150)
    
            ComponentSetValue2(comp_pathing, "distance_to_reach_node_x", 2000)
            ComponentSetValue2(comp_pathing, "distance_to_reach_node_y", 500)
            ComponentSetValue2(comp_pathing, "frames_between_searches", 60)
            ComponentSetValue2(comp_pathing, "frames_to_get_stuck", 60)

			local eid = EntityLoad( "data/entities/animals/boss_fire_lukki/misc/death_helper.xml", pos_x, pos_y )
			EntityAddChild( entity_id, eid )

            --Disable matter eater component so gunpowder can go pop~! pop~!
            comp = EntityGetComponentIncludingDisabled( entity_id, "CellEaterComponent" )[1]
            if comp ~= nil then
				ComponentSetValue( comp, "radius", "0" )
            end
            GameScreenshake( 40 * 1, pos_x, pos_y )

            --Disable Bleeding to prevent lava spam
            comp = EntityGetComponentIncludingDisabled( entity_id, "DamageModelComponent" )[1]
            if comp ~= nil then
				ComponentSetValue( comp, "blood_multiplier", "0" )
            end

			--StatsLogPlayerKill( GetUpdatedEntityID() ) -- this is needed because otherwise the boss kill doesn't get registered as a kill for the player
			is_dead = true

			return
        elseif hp >= max_hp + 1 then
            ComponentSetValue2(comp, "hp", max_hp)
            --GamePrint("Over capped HP fixed")
        elseif hp <= -10 then
            ComponentSetValue2(comp, "hp", 0)
            --GamePrint("Under capped HP fixed")
        elseif hp >= 10 then
            is_dead = false
            death_sound_started = false
            --GamePrint("Is dead set false")
		end
        --GamePrint("Current HP value is " .. tostring(hp))
	end
end