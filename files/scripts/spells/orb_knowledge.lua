local entity_id = GetUpdatedEntityID()
local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "item_identified") --[[@cast spritecomp number]]
local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent") --[[@cast itemcomp number]]
local path = table.concat{"mods/Apotheosis/files/ui_gfx/gun_actions/learning_orb", GameHasFlagRun("apotheosis_evil_knowledge") and "_evil" or "", ".png" }
ComponentSetValue2(itemcomp, "ui_sprite", path)
ComponentSetValue2(spritecomp, "image_file", path)