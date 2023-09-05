
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
ComponentSetValue2(comp,"die_on_liquid_collision",true)