
--Holy mountain christmass tree & fairy lights
ModLuaFileAppend("data/scripts/biomes/temple_altar_left.lua", "mods/Apotheosis/files/scripts/mod_compatibility/seasonal_tweaks/temple_altar_left_christmas.lua")
ModLuaFileAppend("data/scripts/biomes/temple_altar_right.lua", "mods/Apotheosis/files/scripts/mod_compatibility/seasonal_tweaks/temple_altar_right_christmas.lua")

if is_holiday_active("smissmass") then
    ModLuaFileAppend("data/scripts/biomes/snowcastle.lua", "mods/Apotheosis/files/scripts/mod_compatibility/seasonal_tweaks/snowcastle_christmas.lua")
end