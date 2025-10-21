
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local dcomp = EntityGetFirstComponentIncludingDisabled(root,"DamageModelComponent")

if dcomp ~= nil then
    local damage_types = {"melee","projectile","explosion","electricity","fire","slice","drill","ice","radioactive","curse","holy"}
    for k=1,#damage_types do
        ComponentObjectSetValue2( dcomp, "damage_multipliers", damage_types[k], ComponentObjectGetValue2( dcomp, "damage_multipliers", damage_types[k]) / 2 )
    end
end
