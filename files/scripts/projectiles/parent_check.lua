local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then
    EntityKill(entity_id)
end