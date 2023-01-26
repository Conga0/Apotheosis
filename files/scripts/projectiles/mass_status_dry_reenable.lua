local child_id	= GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)

local comp = EntityGetComponentIncludingDisabled(entity_id,"SpriteStainsComponent")[1]
if comp ~= nil then
	EntitySetComponentIsEnabled(entity_id,comp,true)
end
