local entity_id = GetUpdatedEntityID()

local comps = EntityGetComponentIncludingDisabled(entity_id,"AreaDamageComponent")
for k=1,#comps
do local v = comps[k]
    EntitySetComponentIsEnabled(entity_id,v,true)
end