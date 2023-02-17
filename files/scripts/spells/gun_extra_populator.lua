extra_modifiers["apotheosis_use_no_charges"] = function()
    if current_action.uses_remaining > 0 then
        current_action.uses_remaining = current_action.uses_remaining + 1;
    end
end

extra_modifiers["apotheosis_no_recoil"] = function()
    shot_effects.recoil_knockback = 0
end

extra_modifiers["apotheosis_homing"] = function()
    c.extra_entities = c.extra_entities .. "data/entities/misc/homing.xml,data/entities/particles/tinyspark_white_weak.xml,"
end