
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)
local projcomp = EntityGetFirstComponentIncludingDisabled(parent_id,"ProjectileComponent")
local vcomps = EntityGetComponentIncludingDisabled(parent_id)
local outcome_damage = ""
for k=1,#vcomps do
    if ComponentGetValue2(vcomps[k],"name") == "sigil_chromatic" then
        outcome_damage = ComponentGetValue2(vcomps[k],"value_string")
        break
    end
end

local proj_dmg = ComponentGetValue2(projcomp,"damage") or 0
ComponentSetValue2(projcomp,"damage",0)

local total_damage = (proj * 0.1)
if outcome_damage == "projectile" then
    total_damage = proj
end

local damagetypes = {
    "melee",
    "explosion",
    "electricity",
    "slice",
    "ice",
    "curse",
    "drill",
    "fire",
    "radioactive",
    "healing",
    "holy",
}

for k=1,#damagetypes
do local v = damagetypes[k]
    local multiplier = 1.0
    local dmg = ComponentObjectGetValue2( projcomp, "damage_by_type", v ) or 0
    ComponentObjectSetValue2( projcomp, "damage_by_type", v, 0 )

    if v == "explosion" then
        dmg = dmg * 0.5
    elseif v == "holy" then
        if outcome_damage == "holy" then
            dmg = dmg * 2.0
        else
            dmg = dmg * 1.5
        end
    end
    total_damage = total_damage + dmg
    
end

if outcome_damage == "holy" then
    total_damage = total_damage * 0.5
end

--Update new damage
ComponentSetValue2(projcomp,"damage",total_damage)
--ComponentObjectSetValue2( projcomp, "damage_by_type", "fire", dmg )
