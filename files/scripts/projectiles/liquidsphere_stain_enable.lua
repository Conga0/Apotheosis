local entity_id = GetUpdatedEntityID()

EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_liquid",true)

local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
local elec_dmg = ComponentObjectGetValue2( projcomp, "damage_by_type", "electricity" ) or 0
elec_dmg = elec_dmg * 20
ComponentObjectSetValue2( projcomp, "damage_by_type", "electricity", elec_dmg)