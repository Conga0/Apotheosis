local entity_id = GetUpdatedEntityID()
local scs = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent") or {}
local vsc = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent") --[[@cast vsc number]]
local ic = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent") --[[@cast ic number]]
local str = ComponentGetValue2(vsc, "value_string")
if string.byte(str)>122 or string.byte(str)<97 then str = string.char(math.random(97,122)) ComponentSetValue2(vsc, "value_string", str) end
--local exec = ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted")
local path = table.concat{"mods/Apotheosis/files/ui_gfx/gun_actions/spellbook/spellbook_glyph_",str,".png"}
for i=1, #scs do
    if ComponentGetValue2(scs[i], "image_file") == "data/ui_gfx/gun_actions/sea_acid_unidentified.png" then
        local sc = scs[i]
        ComponentSetValue2(sc, "image_file", path)
        ComponentSetValue2(sc, "alpha", 1)
        ComponentSetValue2(ic, "ui_sprite", path)
        EntityRefreshSprite( entity_id, sc )
        break
    end
end