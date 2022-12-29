dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity( entity_id ) 

if EntityHasTag( target, "weaken_NOT") then
    EntityKill(entity_id)
end