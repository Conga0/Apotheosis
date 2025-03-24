local entity_id = GetUpdatedEntityID()
local spritecomp = EntityGetFirstComponent( entity_id, "SpriteComponent" )
local animation = ComponentGetValue2(spritecomp, "rect_animation")
if (animation:sub(1, -2) ~= "freezing_") then return end
local value = tonumber(string.sub(animation, -1)) - 1

if (value <= 0) then
	local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
	for i, comp in ipairs(sprite_comps) do
		ComponentSetValue2(comp, "rect_animation", "stand")
		ComponentSetValue2(comp, "next_rect_animation", "stand")
	end
	local comp_id = GetUpdatedComponentID()
	EntityRemoveComponent( entity_id, comp_id )
else
	ComponentSetValue2(spritecomp, "rect_animation", "freezing_" .. tostring(value) )
	ComponentSetValue2(spritecomp, "next_rect_animation", "freezing_"  .. tostring(value))
end