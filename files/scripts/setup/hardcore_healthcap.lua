function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
    local entity_id = GetUpdatedEntityID()
    local comp_id = GetUpdatedComponentID()
    if ComponentGetIsEnabled( comp_id ) == false then
        return damage, critical_hit_chance
    end
    local healthcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local hp_max = ComponentGetValue2(healthcomp,"max_hp")
    local hp = ComponentGetValue(healthcomp,"hp")

    if damage < 0 then
        local health_cap = tonumber(GlobalsGetValue("apotheosis_healthcap","1"))
        local hp_limit = hp_max * health_cap
        if hp + (damage * -1) > hp_limit then
            local new_heal = damage + ((hp_limit - (hp + (damage * -1))) * -1)
            damage = new_heal
        end
    end

    return damage, critical_hit_chance
end