local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )

local c_check = false

local children = EntityGetAllChildren(player_id) or {}
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_breath_drain_effect" then
            c_check = true
        end
    end
end

if c_check ~= true and player_id ~= 0 then
    --Disables Suffocatium if target has Breathless
	if GameGetGameEffectCount( player_id, "BREATH_UNDERWATER" ) >= 1 then
        local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
        ComponentSetValue2(dmgcomp,"air_in_lungs",ComponentGetValue2(dmgcomp,"air_in_lungs_max"))
    end
end