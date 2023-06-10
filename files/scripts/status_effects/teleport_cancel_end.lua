
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)

--Enable Teleportitis Perk
if GameGetGameEffectCount( player_id, "CUSTOM" ) ~= 0 then
    local comp = GameGetGameEffect( player_id, "CUSTOM" )
    if comp ~= 0 then
        if ComponentGetValue2( comp, "custom_effect_id") == "TELEPORTITIS_DISABLED" then
            ComponentSetValue2( comp, "effect", "TELEPORTITIS")
            ComponentSetValue2( comp, "custom_effect_id", "")
        end
    end
end

--Enable Teleporitis Dodge Perk
local children = EntityGetAllChildren(player_id)
if children then
    for k=1,#children
    do local v = children[k]
        if EntityHasTag(v,"teleportitis_dodge") then
            local comps = EntityGetAllComponents(v)
            for z=1,#comps
            do local c = comps[z]
                EntitySetComponentIsEnabled(v,c,true)
            end
        end
    end
end

--Enable Swapper mage teleports
EntityRemoveTag(player_id,"no_swap")
