local function BuildStainIDs()
    -- Cache stain IDs
    local stain_ids = {}
    if stain_ids.bloody == nil or stain_ids.slimy == nil then
        dofile("data/scripts/status_effects/status_list.lua")
        for sindex = 1, #status_effects do
            stain_ids[status_effects[sindex].id] = sindex
        end
    end
    return stain_ids
end

function shot(projectile_entity)
    -- Build Stain ID table and cance it
    StainIDs = StainIDs or BuildStainIDs()

    -- Get Data
    local shooter_id = GetUpdatedEntityID()
    shooter_id = EntityGetRootEntity(shooter_id)
    local statuscomp = EntityGetFirstComponentIncludingDisabled(shooter_id, "StatusEffectDataComponent")
    local stains = ComponentGetValue2(statuscomp, "stain_effects")
    local effect = math.max(stains[StainIDs["BLOODY"]], stains[StainIDs["SLIMY"]])
    local multiplier = 1.0 + (1.0 * effect) -- DO YOUR MATH HERE USING 'effect'

    -- Damage affector for projectile comps
    local projectile = EntityGetFirstComponentIncludingDisabled(projectile_entity, "ProjectileComponent");
    if projectile then
        -- Set damage
        ComponentSetValue2(projectile, "damage", ComponentGetValue2(projectile, "damage") * multiplier)
        -- Set typed damage
        for _, type in ipairs({ "curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee",
            "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice" }) do
            local damage = ComponentObjectGetValue2(projectile, "damage_by_type", type)
            ComponentObjectSetValue2(projectile, "damage_by_type", type, damage * multiplier)
        end
        -- Set explosion damage
        ComponentObjectSetValue2(projectile, "config_explosion", "damage",
        ComponentObjectGetValue2(projectile, "config_explosion", "damage") * multiplier)
    end

    -- Damage affector for area damage comps
    local areacomps = EntityGetComponentIncludingDisabled(projectile_entity, "AreaDamageComponent") or {}
    for _, areacomp in ipairs(areacomps) do
        -- Set damage
        ComponentSetValue2(areacomp, "damage_per_frame", ComponentGetValue2(areacomp, "damage_per_frame") * multiplier);
    end

    -- Damage affector for lightning comps
    local lightning = EntityGetFirstComponentIncludingDisabled(projectile_entity, "LightningComponent");
    if lightning then
        -- Set damage
        ComponentObjectSetValue2(lightning, "config_explosion", "damage", ComponentObjectGetValue2(lightning, "config_explosion", "damage") * multiplier)
    end

    --Damage affector for plasma comps
    local plasma = EntityGetFirstComponentIncludingDisabled(projectile_entity, "LaserEmitterComponent")
    if plasma then
        --Set damage
        ComponentObjectSetValue2(lightning, "laser", "damage_to_entities", ComponentObjectGetValue2(lightning, "laser", "damage_to_entities") * multiplier)
    end
end