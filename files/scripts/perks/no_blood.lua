
local targets = EntityGetWithTag("mortal")
for k=1,#targets
do v = targets[k]
    local comp = EntityGetFirstComponentIncludingDisabled(v, "DamageModelComponent")
    if comp then
        ComponentSetValue2(comp,"blood_multiplier",0)
        ComponentSetValue2(comp,"ragdoll_fx_forced","DISINTEGRATED")
    end
end