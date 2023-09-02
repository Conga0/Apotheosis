
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )

if player_id ~= 0 then
    --Disables Suffocatium if target has Breathless
	if GameGetGameEffectCount( player_id, "BREATH_UNDERWATER" ) >= 1 then
        local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        ComponentSetValue2(dmgcomp,"air_in_lungs",ComponentGetValue2(dmgcomp,"air_in_lungs_max"))
    end
end
