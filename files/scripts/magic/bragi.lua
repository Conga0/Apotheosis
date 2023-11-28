
local year, month, day, hour, minute = GameGetDateAndTimeLocal()
local path = "mods/apotheosis/files/entities/misc/effect_bragi.xml"

if (month == 8 and day == 31) then
    path = "mods/apotheosis/files/entities/misc/effect_bragi_long.xml"
end

local minas = EntityGetWithTag("player_unit") or {}
for k=1,#minas do
    local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_bragi.xml")
    EntityAddChild(minas[k],c)
end

EntityKill(GetUpdatedEntityID())