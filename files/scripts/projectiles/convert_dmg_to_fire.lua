
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)
local projcomp = EntityGetFirstComponentIncludingDisabled(parent_id,"ProjectileComponent")

local dmg = (ComponentGetValue2(projcomp,"damage") or 0) * 2
ComponentSetValue2(projcomp,"damage",0)

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
do  local v = damagetypes[k]
    local multiplier = 2
    if v == "fire" then
        multiplier = 1.25
    end
    dmg = dmg + ((ComponentObjectGetValue2( projcomp, "damage_by_type", v ) or 0) * multiplier)

    ComponentObjectSetValue2( projcomp, "damage_by_type", v, 0 )
end

--Reward bonus dmg, +200% dmg boost
ComponentObjectSetValue2( projcomp, "damage_by_type", "fire", dmg )
