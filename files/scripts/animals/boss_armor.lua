--damage to resist when you would deal 100% damage. this should be less than or equal to 1
local values = {
	["Default"] = 0.6,
	["Weak"] = 0.3,
	["Off"] = 0,
	["Strong"] = 0.9,
}
local _DAMAGERESISTANCEAT100 = values["Default"]

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    if damage < 0 or GameGetGameEffectCount(GetUpdatedEntityID(), "PROTECTION_ALL") > 0 or _DAMAGERESISTANCEAT100 == 0 then
        return damage, critical_hit_chance
    end
    local comp = EntityGetFirstComponent(GetUpdatedEntityID(), "VariableStorageComponent", "boss_reworks_armor") or 0
    local health_component = EntityGetFirstComponent(GetUpdatedEntityID(), "DamageModelComponent") or 0
    local max_hp = ComponentGetValue2(health_component, "max_hp")
    local crit_res = ComponentGetValue2(health_component, "critical_damage_resistance")
    local recent_relative_damage = ComponentGetValue2(comp, "value_float")

    local critmult=critical_hit_chance/100 --here to reduce calculations, and because i don't want to modify critical_hit_chance
    --since crits are 5x damage, we have to account for the base damage, which means only 4x is crit damage. however, double crits are 10x damage but still 1x base. math hard.
    local expected_damage = damage + (1.0-crit_res)*( damage*critmult*5.0 -damage*(critmult<1.0 and critmult or 1.0) )

    local relative_damage= expected_damage/max_hp
    recent_relative_damage=recent_relative_damage+relative_damage
    ComponentSetValue2(comp, "value_float", recent_relative_damage)

    local armor_multipler = -_DAMAGERESISTANCEAT100/(_DAMAGERESISTANCEAT100-1.0) --intermediate step to make it easier to read.
    local armor= 1.0-(1.0/(armor_multipler*recent_relative_damage+1.0))
    local new_damage=(1.0 - armor) * damage

    return new_damage, critical_hit_chance
end