local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )
local status_count = GameGetGameEffectCount( player_id, "PROTECTION_RADIOACTIVITY" )

if status_count < 1 then
    comp = EntityGetFirstComponent( player_id, "DamageModelComponent" )
	
	if ( comp ~= nil ) then
		local refdmg = ComponentObjectGetValue2( comp, "damage_multipliers", "overeating" ) --Surely nobody will mess with this value.. right?
		ComponentObjectSetValue2( comp, "damage_multipliers", "radioactive", math.max(1,refdmg) )
	end
end

local children = EntityGetAllChildren(player_id) or {}
for k=1,#children do
    if EntityGetName(children[k]) == "inventory_quick" then
        local items = EntityGetAllChildren(children[k])
        for v=1,#items do
            if EntityHasTag( items[v], "effect_protection" ) then

                local comp = EntityGetFirstComponentIncludingDisabled(items[v],"GameEffectComponent")
                if ComponentGetValue2(comp,"effect") == "PROTECTION_FIRE" then
                    ComponentSetValue2( comp, "effect", "CUSTOM")
                    ComponentSetValue2( comp, "custom_effect_id", "PROTECTION_FIRE_DISABLED")
                end
                local comp = EntityGetFirstComponentIncludingDisabled(items[v],"GameEffectComponent")
                if ComponentGetValue2(comp,"effect") == "PROTECTION_ELECTRICITY" then
                    ComponentSetValue2( comp, "effect", "CUSTOM")
                    ComponentSetValue2( comp, "custom_effect_id", "PROTECTION_ELECTRICITY_DISABLED")
                end
                local comp = EntityGetFirstComponentIncludingDisabled(items[v],"GameEffectComponent")
                if ComponentGetValue2(comp,"effect") == "BREATH_UNDERWATER" then
                    ComponentSetValue2( comp, "effect", "CUSTOM")
                    ComponentSetValue2( comp, "custom_effect_id", "BREATH_UNDERWATER_DISABLED")
                end
            end
        end
        break
    end
end