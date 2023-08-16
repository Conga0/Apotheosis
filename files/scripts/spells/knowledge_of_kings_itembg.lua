local entity_id = GetUpdatedEntityID()
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i=1, #spcs do
	local sprite = ComponentGetValue2(spcs[i], "image_file")
	if sprite == "data/ui_gfx/inventory/item_bg_other.png" then
		ComponentSetValue2(spcs[i], "image_file", "mods/Apotheosis/files/ui_gfx/gun_actions/knowledge_extras/item_bg_knowledge_of_kings.png")
	elseif sprite == "mods/Apotheosis/files/ui_gfx/gun_actions/knowledge_of_kings.png" then
		ComponentSetValue2(spcs[i], "image_file", "mods/Apotheosis/files/ui_gfx/gun_actions/knowledge_extras/knowledge_of_kings_inworld.png")
	end
end