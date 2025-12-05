---@diagnostic disable-next-line: lowercase-global
apo_state = { -- Altars of apostasy....... pft, -copi
    new_cast = nil,                 ---@type boolean|nil
	min_reload = -math.huge,				---@type number|nil
	min_cast_delay = -math.huge,			---@type number|nil
    mana_multiplier = 1.0,          ---@type number|nil
	trigger_nesting = 0,			---@type number|nil
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
		apo_state.mana_multiplier = 1.0
		apo_state.min_reload = -math.huge
    end

    apo_state.old.draw_shot( ... )
end


---@diagnostic disable-next-line: lowercase-global
function draw_action(...)
	local ret = apo_state.old.draw_action(...)
	-- Force recharge if learning orb
	if apo_state.min_reload then current_reload_time = math.max(apo_state.min_reload, current_reload_time) end
	return ret
end

function BeginProjectile(entity_filename)
	local replace = {
		knowledge = {
			ADD_TRIGGER = true,
			ADD_TIMER = true,
			ADD_DEATH_TRIGGER = true,
		}
	}
	if replace.knowledge[current_action.id] and entity_filename == "mods/Apotheosis/files/entities/projectiles/deck/orb_knowledge.xml" then
		entity_filename = "mods/Apotheosis/files/entities/projectiles/deck/orb_knowledge_trigger.xml"
	end
	apo_state.old.BeginProjectile(entity_filename)
end

do	--Detect if a spell is being cast from within a trigger, and if so how deep
	local fns = {"BeginTriggerDeath", "BeginTriggerHitWorld","BeginTriggerTimer"}

	for _, fn in ipairs(fns) do
		local _fn = _G[fn]
		_G[fn] = function(...)
			apo_state.trigger_nesting = apo_state.trigger_nesting + 1
			_fn(...)
		end
	end

	local _EndTrigger = EndTrigger
	EndTrigger = function(...)
		apo_state.trigger_nesting = apo_state.trigger_nesting - 1
		_EndTrigger(...)
	end
end




-- Patch order_deck to allow mana skip/multiply
local order_deck_old = order_deck
function order_deck(...)
	for i=1, #deck do
		local action = deck[i]
		if action.mana_calculated==nil then
			-- store base mana
			local base_mana = action.mana or 0
			action.mana = nil
			-- Multiply the mana cost on indexing the mana cost, or skip it outright
			setmetatable(action, { __index=function(table, key) if key == "mana" then return action.skip_mana and 0 or (base_mana * apo_state.mana_multiplier) end end })
			action.mana_calculated = true
		end
	end
	order_deck_old(...)
end

dofile_once("mods/Apotheosis/files/datat.lua")
