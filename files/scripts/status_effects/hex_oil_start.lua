local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if comp ~= 0 then

    local materials = {
        "oil",
    }

    for k=1,#materials do
        EntitySetDamageFromMaterial( entity_id, materials[k], 0.003)
    end

end