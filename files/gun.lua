---@diagnostic disable-next-line: lowercase-global
apo_state = { -- Altars of apostasy....... pft, -copi
    new_cast = nil,                 ---@type boolean|nil
	min_reload = nil,				---@type number|nil
    old = {                         ---@type table
		draw_shot = draw_shot,      ---@type function
		draw_action = draw_action,  ---@type function
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
        local state = tonumber(GlobalsGetValue("APOTHEOSIS_LUA_SHARING_CAST_STATE", "0"))
        GlobalsSetValue("APOTHEOSIS_LUA_SHARING_CAST_STATE", tostring( state + 1 ))
    end

    if call_end_cast then
        apo_state.new_cast = nil
		apo_state.min_reload = nil
    end

    apo_state.old.draw_shot( ... )
end


---@diagnostic disable-next-line: lowercase-global
function draw_action(...)
	apo_state.old.draw_action(...)
	-- Force recharge if learning orb
	if apo_state.min_reload then current_reload_time = math.max(apo_state.min_reload, current_reload_time) end
end

---@diagnostic disable-next-line: lowercase-global
function set_current_action( action )
    -- CAST STATE VALUE                     -- ACTION VALUE                     -- FALLBACK
    c.action_id                             = action.id
    c.action_name                           = action.name
    c.action_sprite_filename                = action.sprite
    c.action_type                           = action.type
    c.action_recursive                      = action.recursive
    c.action_spawn_level                    = action.spawn_level
    c.action_spawn_probability              = action.spawn_probability
    c.action_spawn_requires_flag            = action.spawn_requires_flag
    c.action_spawn_manual_unlock            = action.spawn_manual_unlock        or false
    c.action_max_uses                       = action.max_uses
    c.custom_xml_file                       = action.custom_xml_file
    c.action_ai_never_uses                  = action.ai_never_uses              or false
    c.action_never_unlimited                = action.never_unlimited            or false
    c.action_is_dangerous_blast             = action.is_dangerous_blast
    c.sound_loop_tag                        = action.sound_loop_tag
    c.action_mana_drain                     = action.mana                       or ACTION_MANA_DRAIN_DEFAULT
    c.action_unidentified_sprite_filename   = action.sprite_unidentified        or ACTION_UNIDENTIFIED_SPRITE_DEFAULT
    c.action_description                    = reflecting and action.description or c.action_description

    current_action = action
end
