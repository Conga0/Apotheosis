
local entity_id = GetUpdatedEntityID()
local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
ComponentSetValue2(sprite_comp,"image_file","mods/apotheosis/files/enemies_gfx/playerghost/playerghost.xml")
