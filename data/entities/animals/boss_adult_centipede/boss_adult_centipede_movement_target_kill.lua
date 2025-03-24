local entity_id = GetUpdatedEntityID()

local bodcomps = EntityGetComponent(entity_id, "PhysicsBodyComponent") or {}
for i, comp in ipairs(bodcomps) do
	EntityRemoveComponent( entity_id, comp )
end
local shapecomps = EntityGetComponent(entity_id, "PhysicsImageShapeComponent") or {}
for i, comp in ipairs(shapecomps) do
	EntityRemoveComponent( entity_id, comp )
end