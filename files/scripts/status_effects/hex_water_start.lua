local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local dmg = 0.0005
--Original amount was 0.003, no MHP scaling

--If water protection is detected, stop material damage from being added
local water_immune = false

local children = EntityGetAllChildren(entity_id)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_protection_water" then
            local effect_id = GetUpdatedEntityID()
            water_immune = true
        end
    end
end

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if comp and water_immune == false then

    local hp = ComponentGetValue2(comp,"max_hp")
    local dmgscaled = dmg * (hp / 4)

    local materials = {
        "water",
        "mud",
        "water_swamp",
        "water_salt",
        "swamp",
        "peat",
        "snow",
        "slush",
        "water_temp",
        "water_ice",
        "water_fading",
        "apotheosis_water_fading_fast",
        "apotheosis_sweat",
    }

    for k=1,#materials do
        EntitySetDamageFromMaterial( entity_id, materials[k], dmgscaled)
    end

end