dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000
local voiceplayed = false

function IncrementPhase(eid,currentphase)
	local storages = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )
	if ( storages ~= nil ) then
		for i,comp in ipairs( storages ) do
			local name = ComponentGetValue2( comp, "name" )
			if ( name == "phase_brain" ) then
				ComponentSetValue2( comp, "value_int", currentphase + 1 )
				break
			end
		end
	end
end

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local phase = 0

    local dmgcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
	local health = tonumber(ComponentGetValue( dmgcomp, "hp"))
	local max_health = tonumber(ComponentGetValue( dmgcomp, "max_hp"))

	local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )

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

	--Towerclimb Phase #1 starts at 66% hp
	if phase == 1 and ((max_health * 0.66) >= health) then
		IncrementPhase(entity_id,phase)

		--Enter "tower climb" phase, only take 1 damage per hit until at 65% health
		--Maybe on the final tower climb phase he doesn't gain 1 hamage per hit protection

		GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y )
		ComponentSetValue2( dmgcomp, "hp", max_health * 0.66)

		--Slow down the worm but give it very high turn speed
		local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
		ComponentSetValue2( wormAiComp, "speed", 1 )
		ComponentSetValue2( wormAiComp, "speed_hunt", 3 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.15 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.45 )

		EntitySetComponentsWithTagEnabled(entity_id,"disabled_by_liquid",true)	--Enable TowerClimb phase components
		EntitySetComponentsWithTagEnabled(entity_id,"counter",false)	--Disable normal phase components
	end
	

	--Towerclimb Phase #1 ends at 64% hp
	if phase == 2 and ((max_health * 0.64) >= health) then
		IncrementPhase(entity_id,phase)

		--Bring worm back up to it's normal speed
		local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
		ComponentSetValue2( wormAiComp, "speed", 6 )
		ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )  

		EntitySetComponentsWithTagEnabled(entity_id,"disabled_by_liquid",false)	--Disable TowerClimb phase components
		EntitySetComponentsWithTagEnabled(entity_id,"counter",true)	--Enable normal phase components
	end
	

	--Towerclimb Phase #2 starts at 33% hp
	if phase == 3 and ((max_health * 0.33) >= health) then
		IncrementPhase(entity_id,phase)

		--Enter "tower climb" phase, only take 1 damage per hit until at 65% health
		--Maybe on the final tower climb phase he doesn't gain 1 hamage per hit protection

		GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y )
		ComponentSetValue2( dmgcomp, "hp", max_health * 0.33)

		--Slow down the worm but give it very high turn speed
		local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
		ComponentSetValue2( wormAiComp, "speed", 1 )
		ComponentSetValue2( wormAiComp, "speed_hunt", 3 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.15 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.45 )

		EntitySetComponentsWithTagEnabled(entity_id,"disabled_by_liquid",true)	--Enable TowerClimb phase components
		EntitySetComponentsWithTagEnabled(entity_id,"counter",false)	--Disable normal phase components
	end
	

	--Towerclimb Phase #2 ends at 31% hp
	if phase == 4 and ((max_health * 0.31) >= health) then
		IncrementPhase(entity_id,phase)

		--Bring worm back up to it's normal speed
		local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
		ComponentSetValue2( wormAiComp, "speed", 6 )
		ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
		ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )  

		EntitySetComponentsWithTagEnabled(entity_id,"disabled_by_liquid",false)	--Disable TowerClimb phase components
		EntitySetComponentsWithTagEnabled(entity_id,"counter",true)	--Enable normal phase components

		--Lets the worm die
		local dmgComp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
		ComponentSetValue( dmgComp, "kill_now", "1" )
	end

end
