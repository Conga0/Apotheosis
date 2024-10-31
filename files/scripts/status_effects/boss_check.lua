local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity( entity_id ) 

if EntityHasTag( target, "boss") then
    EntityKill(entity_id)
end