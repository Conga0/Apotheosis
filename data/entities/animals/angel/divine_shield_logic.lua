dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local frame = GameGetFrameNum()

	if( entity_who_caused == entity_id ) or (frame <= last_frame + 60*13) then return end
	
	local health = 0
	local max_health = 0
	
	edit_component( entity_id, "DamageModelComponent", function(comp,vars)
		health = tonumber(ComponentGetValue( comp, "hp"))
		max_health = tonumber(ComponentGetValue( comp, "max_hp"))
		--ComponentSetValue( comp, "invincibility_frames", 5) --This should give 5 frames of invincibility after taking damage
	end)
	
	local minion_count = 3
	local minion_interval = max_health / minion_count
	
	local new_health = health - damage
	local nearest_interval = math.floor( health / minion_interval ) * minion_interval
	
	local limit = 3
	local count = 0

	--GamePrint(frame)
	--GamePrint(last_frame + 60*13)
	
	while (nearest_interval > new_health) and (count < limit) and (nearest_interval >= 0) do
		local eid = EntityLoad( "data/entities/animals/angel/divine_shield.xml", pos_x, pos_y )
		EntityAddChild( entity_id, eid )
		
		nearest_interval = nearest_interval - minion_interval

		last_frame = GameGetFrameNum()
		
		count = count + 1
	end
end
