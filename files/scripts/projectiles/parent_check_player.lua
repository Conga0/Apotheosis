local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
if EntityHasTag(root,"player_unit") then
    EntityKill(entity_id)
end