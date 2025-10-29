
local entity_id = GetUpdatedEntityID()
local lightComps = EntityGetComponentIncludingDisabled(entity_id,"LightComponent") or {}

for k=1,#lightComps do
    local r = ComponentGetValue2(lightComps[k],"r")
    local g =  ComponentGetValue2(lightComps[k],"g")

    if r == 255 and g == 0 then
        ComponentSetValue2(lightComps[k],"g",255)
    elseif r == 255 and g == 255 then
        ComponentSetValue2(lightComps[k],"r",0)
        ComponentSetValue2(lightComps[k],"g",255)
    elseif r == 0 and g == 255 then
        ComponentSetValue2(lightComps[k],"r",255)
        ComponentSetValue2(lightComps[k],"g",0)
    end
end