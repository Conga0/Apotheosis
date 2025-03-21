---@diagnostic disable-next-line: lowercase-global
apo_state = { -- Altars of apostasy....... pft, -copi
    new_cast = nil,                 ---@type boolean|nil
	min_reload = -math.huge,				---@type number|nil
    mana_multiplier = 1.0,          ---@type number|nil
    old = {                         ---@type table
		draw_shot = draw_shot,      ---@type function
		draw_action = draw_action,  ---@type function
		BeginProjectile = BeginProjectile ---@type function
    }
}

---@diagnostic disable-next-line: lowercase-global
function draw_shot( ... )
    -- Don't ask why this works -copi
    -- okay -conga
    local call_end_cast = false
    if apo_state.new_cast == nil then
        call_end_cast = true
        apo_state.new_cast = false
    end

    if call_end_cast then
        apo_state.new_cast = nil
		apo_state.min_reload = -math.huge
    end

    apo_state.old.draw_shot( ... )
end


---@diagnostic disable-next-line: lowercase-global
function draw_action(...)
	apo_state.old.draw_action(...)
	-- Force recharge if learning orb
	if apo_state.min_reload then current_reload_time = math.max(apo_state.min_reload, current_reload_time) end
end

function BeginProjectile(entity_filename)
	local replace = {
		knowledge = {
			ADD_TRIGGER = true,
			ADD_TIMER = true,
			ADD_DEATH_TRIGGER = true,
		}
	}
	if replace.knowledge[current_action.id] == "APOTHEOSIS_ORB_KNOWLEDGE" then
		entity_filename = "mods/Apotheosis/files/entities/projectiles/deck/orb_knowledge_trigger.xml"
	end
	apo_state.old.BeginProjectile(entity_filename)
end

dofile_once("mods/Apotheosis/files/datat.lua")