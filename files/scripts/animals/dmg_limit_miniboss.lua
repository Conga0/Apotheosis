
function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local reduced_damage = damage * 0.8 --Reduce all incoming damage by 20%
    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local comp2 = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.02 --Maximum of 2% health damage per instance of damage
    local iframes = ComponentGetValue2(comp2,"value_int")
    local iframes_duration = 5

    --Upon taking damage, become invulnerable for 5 frames
    if iframes > 0 and iframes ~= iframes_duration then
        return 0, 0
    end

    ComponentSetValue2(comp2,"value_int",iframes_duration)
    local ndmg = math.min(dmg_cap, reduced_damage)
    return ndmg, 0
end