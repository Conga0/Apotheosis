local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if comp ~= nil then

    local materials = {
        "radioactive_liquid",
        "apotheosis_radioactive_liquid_strong",
        "apotheosis_radioactive_mud",
        "rock_static_radioactive",
        "radioactive_gas",
    }

    for k=1,#materials do
        EntitySetDamageFromMaterial( entity_id, materials[k], 0)
    end

    local toxic_immune_test = GameGetGameEffectCount( entity_id, "PROTECTION_RADIOACTIVITY" )
    local toxic_immune_test2 = ComponentObjectGetValue2( comp, "damage_multipliers", "radioactive" )

    --Checks if a creature isn't innately toxic immune, if so, re-apply these vulnerabilities
    if toxic_immune_test < 0 or toxic_immune_test2 > 0 then
        EntitySetDamageFromMaterial( entity_id, "rock_static_radioactive", 0.001)
        EntitySetDamageFromMaterial( entity_id, "radioactive_gas", 0.001)
    end

end