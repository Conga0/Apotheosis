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
		

	end
end
