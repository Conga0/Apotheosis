
local entity_id    = GetUpdatedEntityID()
local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do
	ComponentSetValue2(comp, "rect_animation", "rapid")
end