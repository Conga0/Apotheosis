local comp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(),"DamageModelComponent")
local max_hp = ComponentGetValue2(comp,"max_hp")
local dmg_cap = max_hp * 0.02

function damage_about_to_be_received( damage )
    return math.min(dmg_cap, damage)
end