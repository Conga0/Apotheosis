function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local comp2 = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.01
    local iframes = ComponentGetValue2(comp2,"value_float")
    local iframes_duration = 5

    if iframes > 0 and iframes ~= iframes_duration then
        return 0, 0
    end

    ComponentSetValue2(comp2,"value_float",iframes_duration)
    local ndmg = math.min(dmg_cap, damage)
    return ndmg, critical_hit_chance
end