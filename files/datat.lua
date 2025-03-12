-- ONLY use latest version of this code across mods
-- Copi tech below.
local ver = 1.0
if ver > (Datat_ver or 0) then
	Datat_ver = ver
	-- Add Datat as a place to insert data. Modders should coordinate on what maps to what.
	--[[
		Standardization: 
			1: Cast State
			2: C
			...
	]]

	function ResetDatat()
		DontTouch_Data = {}
		Datat = setmetatable(
			{__maxindx = -math.huge},
			{__newindex = function(t, k, v)
				if type(k) == "number" and k > t.__maxindx then t.__maxindx = k end
				DontTouch_Data[k] = v
			end}
		)
	end
	ResetDatat()

	-- Writes the cast state to indx i.
	---@param c table
	function WriteCToDatat(c)
		local a = {
			c.action_id,
			c.action_name,
			c.action_description,
			c.action_sprite_filename,
			c.action_unidentified_sprite_filename,
			c.action_type,
			c.action_spawn_level,
			c.action_spawn_probability,
			c.action_spawn_requires_flag,
			c.action_spawn_manual_unlock,
			c.action_max_uses,
			c.custom_xml_file,
			c.action_mana_drain,
			c.action_is_dangerous_blast,
			c.action_draw_many_count,
			c.action_ai_never_uses,
			c.action_never_unlimited,
			c.state_shuffled,
			c.state_cards_drawn,
			c.state_discarded_action,
			c.state_destroyed_action,
			c.fire_rate_wait,
			c.speed_multiplier,
			c.child_speed_multiplier,
			c.dampening,
			c.explosion_radius,
			c.spread_degrees,
			c.pattern_degrees,
			c.screenshake,
			c.recoil,
			c.damage_melee_add,
			c.damage_projectile_add,
			c.damage_electricity_add,
			c.damage_fire_add,
			c.damage_explosion_add,
			c.damage_ice_add,
			c.damage_slice_add,
			c.damage_healing_add,
			c.damage_curse_add,
			c.damage_drill_add,
			c.damage_null_all,
			c.damage_critical_chance,
			c.damage_critical_multiplier,
			c.explosion_damage_to_materials,
			c.knockback_force,
			c.reload_time,
			c.lightning_count,
			c.material,
			c.material_amount,
			c.trail_material,
			c.trail_material_amount,
			c.bounces,
			c.gravity,
			c.light,
			c.blood_count_multiplier,
			c.gore_particles,
			c.ragdoll_fx,
			c.friendly_fire,
			c.physics_impulse_coeff,
			c.lifetime_add,
			c.sprite,
			c.extra_entities,
			c.game_effect_entities,
			c.sound_loop_tag,
			c.projectile_file,
		}
		for i=1, #a do
			a[i]=tostring(a[i])
		end
		Datat[2] = table.concat(a, string.char(255))
	end

	if not DidWePatchThisShitCopi then
		-- Patch ConfigGunActionInfo_PassToGame to inject data last minute
		local ConfigGunActionInfo_PassToGame_old = ConfigGunActionInfo_PassToGame
		function ConfigGunActionInfo_PassToGame(...)
			if not reflecting then
				for i=1, math.max(Datat.__maxindx,13) do if not DontTouch_Data[i] then DontTouch_Data[i]="" end end
				c.action_description = table.concat(DontTouch_Data, "\n")
			end
			ConfigGunActionInfo_PassToGame_old(...)
			if not reflecting then GlobalsSetValue("GLOBAL_CAST_STATE", tostring(tonumber(GlobalsGetValue("GLOBAL_CAST_STATE", "0"))+1)) end
			ResetDatat()
		end
		DidWePatchThisShitCopi = true
	end
end
