local entity_id = GetUpdatedEntityID()

local bodcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
local shapecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsImageShapeComponent")

if bodcomp ~= nil and shapecomp ~= nil then
	EntityRemoveComponent( entity_id, bodcomp )
	EntityRemoveComponent( entity_id, shapecomp )
end