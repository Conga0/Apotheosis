---@diagnostic disable: undefined-global
extra_modifiers["apotheosis_use_no_charges"] = function()
    if current_action.uses_remaining > 0 then
        current_action.uses_remaining = current_action.uses_remaining + 1;
    end

    --Caps the firerate of possessed wands
    if c.fire_rate_wait < 15 then c.fire_rate_wait = 15 end
    if current_reload_time < 15 then current_reload_time = 15 end
end

extra_modifiers["apotheosis_no_recoil"] = function()
    shot_effects.recoil_knockback = 0
end

extra_modifiers["apotheosis_homing"] = function()
    c.extra_entities = c.extra_entities .. "data/entities/misc/homing.xml,data/entities/particles/tinyspark_white_weak.xml,"
end

extra_modifiers["apotheosis_speedup"] = function()
    c.speed_multiplier = c.speed_multiplier * 2.5
end

extra_modifiers["apotheosis_braindamage"] = function()
    c.spread_degrees = c.spread_degrees + 30
end