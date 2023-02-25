local child_id	= GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteStainsComponent")
if comp ~= nil then
	EntitySetComponentIsEnabled(entity_id,comp,true)
end
