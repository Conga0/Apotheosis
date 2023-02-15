extra_modifiers["apotheosis_use_no_charges"] = function()
    if current_action.uses_remaining > 0 then
        current_action.uses_remaining = current_action.uses_remaining + 1;
    end
end