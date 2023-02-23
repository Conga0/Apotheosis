
local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CellEaterComponent")
ComponentSetValue2(comp,"radius",10)
ComponentSetValue2(comp,"eat_probability",20)