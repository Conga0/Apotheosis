local entity_id = GetUpdatedEntityID()
local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "item_identified") --[[@cast spritecomp number]]
local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent") --[[@cast itemcomp number]]
local evil = GameHasFlagRun("apotheosis_evil_knowledge")
local divine = GameHasFlagRun("apotheosis_card_unlocked_secret_knowledge_of_kings_complete")
local path = table.concat{"mods/Apotheosis/files/ui_gfx/gun_actions/learning_orb", evil and divine and "_divine_evil" or divine and "_divne" or evil and "_evil" or "", ".png" }
ComponentSetValue2(itemcomp, "ui_sprite", path)
ComponentSetValue2(spritecomp, "image_file", path)