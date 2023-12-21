
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local path = ComponentGetValue2(comp,"value_string")
EntityLoad(path,x,y)
EntityKill(entity_id)