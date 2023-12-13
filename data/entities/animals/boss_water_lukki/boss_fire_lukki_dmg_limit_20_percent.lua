function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local comp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(),"DamageModelComponent")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.20

    local ndmg = math.min(dmg_cap, damage)
    return ndmg, critical_hit_chance
end