local entity_id = GetUpdatedEntityID()

local dmgcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if dmgcomp ~= nil then
    
    ComponentObjectSetValue2( dmgcomp, "damage_multipliers", "projectile", -1.0 )

end