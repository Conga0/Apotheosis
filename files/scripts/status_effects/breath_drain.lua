local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )

if player_id ~= 0 then

    --Disables Suffocatium if target has Breathless
	if GameGetGameEffectCount( player_id, "BREATH_UNDERWATER" ) >= 1 and (EntityHasTag(player_id,"vulnerable") ~= true) then
        local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        ComponentSetValue2(dmgcomp,"air_in_lungs",7)
    return end

    local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
    local air = ComponentGetValue2(dmgcomp, "air_in_lungs")

    if air > 0.1 then
        ComponentSetValue2(dmgcomp,"air_in_lungs",air - 0.1)
    end

    if EntityHasTag(player_id,"player_unit") and air < 0.11 then
        EntityInflictDamage( player_id, 0.012, "DAMAGE_CURSE", "$damage_drowning", "NONE", 0, 0, 0 )
        ComponentSetValue2(dmgcomp,"air_in_lungs",0.1)
    end

end