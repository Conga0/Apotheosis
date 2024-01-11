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
    if c.spread_degrees < 20 then
        c.spread_degrees = 20
    end
end

extra_modifiers["apotheosis_bragi"] = function()
    if not c.extra_entities:find("mods/apotheosis/files/entities/misc/bragi_fx.xml,") then
        c.extra_entities = table.concat({c.extra_entities,"mods/apotheosis/files/entities/misc/bragi_fx.xml,"})
        c.fire_rate_wait = c.fire_rate_wait - 30
        current_reload_time = current_reload_time - 30
    end
end