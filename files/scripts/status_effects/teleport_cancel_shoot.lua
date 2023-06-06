
function shot( entity_id )

    --Grabs a list of all TeleportProjectileComponents and disables them
    local comps = EntityGetComponentIncludingDisabled(entity_id,"TeleportProjectileComponent")
    if comps then
        for k=1,#comps
        do local v = comps[k]
            EntityRemoveComponent(entity_id,v)
        end
    end

    --Grabs a list of all Swapper Components and disables them
    local comps = EntityGetComponentIncludingDisabled(entity_id,"HitEffectComponent")
    if comps then
        for k=1,#comps
        do local v = comps[k]
            if ComponentGetValue2(v,"effect_hit") == "SWAPPER" then
                EntityRemoveComponent(entity_id,v)
            end
        end
    end

    --Disables RGB Portals from teleporting you
    EntitySetComponentsWithTagEnabled(entity_id,"apotheosis_blob_boss",false)
end
