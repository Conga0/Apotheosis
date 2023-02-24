local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if comp ~= nil then

    local materials = {
        "blood",
        "apotheosis_blood_infectious",
        "apotheosis_eviltemple_stone",
        "apotheosis_redstone",
    }

    for k=1,#materials do
        EntitySetDamageFromMaterial( entity_id, materials[k], 0.003)
    end

end