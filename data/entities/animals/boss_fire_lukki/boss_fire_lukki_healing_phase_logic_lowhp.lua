dofile_once("data/scripts/lib/utilities.lua")
local finale_immortality_check = false
--local finale_limit = 2

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	local health = 0
	local max_health = 0
	edit_component( entity_id, "DamageModelComponent", function(comp,vars)
		health = tonumber(ComponentGetValue( comp, "hp"))
		max_health = tonumber(ComponentGetValue( comp, "max_hp"))
	end)

	--If the boss reaches full health for whatever reason, allow it to do the finale healing phase again
	--[[
	if health == max_health then
		finale_immortality_check = false
	end
	]]--
	
	--If the boss is below 10% hp, is not currently in a healing phase and has not done a "finale" healing phase yet, then it will
	--Do a healing phase regardless of if the 7 second cooldown has occured yet
	--Note it can only do this 2 times, even if it keeps restoring it's 'tickets' by reaching full health to prevent an immortal boss
	if ((max_health * 0.1) <= health) or (finale_immortality_check == true) then return end
	--if ((max_health * 0.1) <= health) or (finale_immortality_check == true) or (finale_limit == 0) then return end

	local eid = EntityLoad( "data/entities/animals/boss_fire_lukki/misc/healing_phase_helper.xml", pos_x, pos_y )
	EntityAddChild( entity_id, eid )
	
	--Causes the boss to spit out a lot of fire bolts in it's final phase 3 panic
	EntityAddComponent2(
		entity_id,
		"LuaComponent",
		{
			execute_on_added = false,
			script_source_file = "data/entities/animals/boss_fire_lukki/boss_fire_lukki_healing_phase_logic_lowhp_burst.lua",
			execute_every_n_frame = 11,
			remove_after_executed = false,
			execute_times=33
		}
	)

	finale_immortality_check = true
	--finale_limit = finale_limit - 1
end
