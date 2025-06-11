local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )
local status_count = 0
if player_id > 0 then
    status_count = GameGetGameEffectCount( player_id, "PROTECTION_RADIOACTIVITY" )
end

if status_count > 0 then
    comp = EntityGetFirstComponent( player_id, "DamageModelComponent" )
	
	if ( comp ~= nil ) then

		ComponentObjectSetValue2( comp, "damage_multipliers", "radioactive", 0 )
	end
end

local children = EntityGetAllChildren(player_id) or {}
for k=1,#children do
    if EntityGetName(children[k]) == "inventory_quick" then
        local items = EntityGetAllChildren(children[k]) or {}
        for v=1,#items do
            if EntityHasTag( items[v], "effect_protection" ) then
                local comp = EntityGetFirstComponentIncludingDisabled(items[v],"GameEffectComponent")
                if comp ~= 0 then
                    if ComponentGetValue2( comp, "custom_effect_id") == "PROTECTION_FIRE_DISABLED" then
                        ComponentSetValue2( comp, "effect", "PROTECTION_FIRE")
                        ComponentSetValue2( comp, "custom_effect_id", "")
                    end
                    if ComponentGetValue2( comp, "custom_effect_id") == "PROTECTION_ELECTRICITY_DISABLED" then
                        ComponentSetValue2( comp, "effect", "PROTECTION_ELECTRICITY")
                        ComponentSetValue2( comp, "custom_effect_id", "")
                    end
                    if ComponentGetValue2( comp, "custom_effect_id") == "BREATH_UNDERWATER_DISABLED" then
                        ComponentSetValue2( comp, "effect", "BREATH_UNDERWATER")
                        ComponentSetValue2( comp, "custom_effect_id", "")
                    end
                end
            end
        end
        break
    end
end