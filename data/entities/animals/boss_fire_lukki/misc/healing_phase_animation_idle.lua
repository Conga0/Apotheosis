dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local sprite_comps = EntityGetComponent(root_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do

	ComponentSetValue2(comp, "rect_animation", "healing_idle")

end