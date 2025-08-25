local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local comps = EntityGetComponentIncludingDisabled(entity_id,"HitboxComponent") or {}
for k=1,#comps do
    ComponentSetValue2(comps[k],"damage_multiplier",ComponentGetValue2(comps[k],"damage_multiplier") * 0.5)
end