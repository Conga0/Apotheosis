dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
local entity_id = GetUpdatedEntityID()
local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "item_identified") --[[@cast spritecomp number]]
local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent") --[[@cast itemcomp number]]
local evil = GameHasFlagRun("apotheosis_evil_knowledge")
local divine = GameHasFlagRun("apotheosis_card_unlocked_secret_knowledge_of_kings_complete")
local path = table.concat{"mods/Apotheosis/files/ui_gfx/gun_actions/learning_orb", (GameGetOrbCountThisRun() == 0 or is_holiday_active("april_fools") and "_april_fools") or evil and divine and "_divine_evil" or divine and "_divine" or evil and "_evil" or "", ".png" }
ComponentSetValue2(itemcomp, "ui_sprite", path)
ComponentSetValue2(spritecomp, "image_file", path)