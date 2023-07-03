
function damage_about_to_be_received( damage )
    if damage > 0 then
        return 0.04
    else
        return damage
    end
end