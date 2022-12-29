dofile_once("data/scripts/lib/utilities.lua")

--I'm a lazy cunt so I'll just do it this way

local entity_id = GetUpdatedEntityID()
EntityRemoveTag(entity_id, "homing_target")