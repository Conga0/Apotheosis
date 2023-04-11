
local entity_id = EntityGetUpdatedID()

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
ComponentSetValue2(comp,"damage_every_x_frames",10)