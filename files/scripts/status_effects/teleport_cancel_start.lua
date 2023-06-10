
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)

--Disable Teleportitis Perk
if GameGetGameEffectCount( player_id, "TELEPORTITIS" ) ~= 0 then
    local comp = GameGetGameEffect( player_id, "TELEPORTITIS" )
    if comp ~= 0 then
        ComponentSetValue2( comp, "effect", "CUSTOM")
        ComponentSetValue2( comp, "custom_effect_id", "TELEPORTITIS_DISABLED")
    end
end

--Disable Teleportitis Dodge Perk
local children = EntityGetAllChildren(player_id)
if children then
    for k=1,#children
    do local v = children[k]
        if EntityHasTag(v,"teleportitis_dodge") then
            local comps = EntityGetAllComponents(v)
            for z=1,#comps
            do local c = comps[z]
                EntitySetComponentIsEnabled(v,c,false)
            end
        end
    end
end

--Disable Swapper mage teleports
EntityAddTag(player_id,"no_swap")
