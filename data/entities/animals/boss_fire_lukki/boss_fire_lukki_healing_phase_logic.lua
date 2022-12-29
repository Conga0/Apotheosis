dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000
local finale_immortality_check = false

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local frame = GameGetFrameNum()

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

	--If the boss has performed a healing phase in the last 15 seconds, then it can not do another one until 15 seconds have passed
	--The timer starts when the healing phase starts
	--Note the healing phase itself lasts for 7 seconds in total, so 15 - 7 is 8 seconds of vulnerability
	if( entity_who_caused == entity_id ) or (frame <= last_frame + 60*15) or ((max_health * 0.1) > health) or (phase >= 3) then return end
	
	local minion_count = 5
	local minion_interval = max_health / minion_count
	
	local new_health = health - damage
	local nearest_interval = math.floor( health / minion_interval ) * minion_interval
	
	local limit = 5
	local count = 0

	--Debug info
	--[[
	GamePrint(frame)
	GamePrint(last_frame + 60*3)
	]]--
	
	while (nearest_interval > new_health) and (count < limit) and (nearest_interval >= 0) do
		local eid = EntityLoad( "data/entities/animals/boss_fire_lukki/misc/healing_phase_helper.xml", pos_x, pos_y )
		EntityAddChild( entity_id, eid )
		
		nearest_interval = nearest_interval - minion_interval

		last_frame = GameGetFrameNum()
		
		count = count + 1
	end
end
