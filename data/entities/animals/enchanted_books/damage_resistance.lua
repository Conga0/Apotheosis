function find_vsc(name)
    local entity_id = GetUpdatedEntityID()
    local vsc = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent") or {}
    for k=1,#vsc do
        if ComponentGetValue2(vsc[k],"name") == name then
            return vsc[k]
        end
    end
end

function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local reduced_damage = damage * 0.3 --Reduce all incoming damage by 70%
    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local vsc_comp = find_vsc("iframe_data")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.01
    local iframes = ComponentGetValue2(vsc_comp,"value_int")
    local iframes_duration = 5

    if iframes > 0 and iframes ~= iframes_duration then
        return 0, 0
    end

    local ndmg = math.min(dmg_cap, reduced_damage)
    return ndmg, 0
end