dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local lukki_id = EntityGetRootEntity(entity_id)

local comp = EntityGetComponentIncludingDisabled(lukki_id, "CellEaterComponent")[1]
ComponentSetValue2( comp, "eat_probability", 100)


EntityKill(entity_id)