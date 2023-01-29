if StreamingGetIsConnected() == false then return end

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local enemy_level = 1
local currentLevel = tonumber( GlobalsGetValue( "apotheosis_biome_level", "1" ) )
local currbiome = BiomeMapGetName( x, y )
currbiome = tostring(currbiome)
local prefix = "$biome_"


if (currbiome == prefix .. "coalmine") or (currbiome == prefix .. "coalmine_alt") or (currbiome == prefix .. "forest") then
    enemy_level = 1 --Mines
elseif (currbiome == prefix .. "excavationsite") or (currbiome == prefix .. "desert") or (currbiome == prefix .. "fungicave") then
    enemy_level = 2 --Coal pits
elseif (currbiome == prefix .. "snowcave") or (currbiome == prefix .. "snowcastle") then
    enemy_level = 3 --Snowy depths & Hisii base
elseif (currbiome == prefix .. "rainforest") or (currbiome == prefix .. "rainforest_open") or (currbiome == prefix .. "rainforest_dark") then
    enemy_level = 4 --Rainforest
elseif (currbiome == prefix .. "fungiforest") or (currbiome == prefix .. "vault") then
    enemy_level = 5 --Vault
elseif (currbiome == prefix .. "crypt") or (currbiome == prefix .. "robobase") or (currbiome == prefix .. "wizardcave") or (currbiome == prefix .. "clouds") then
    enemy_level = 6 --Temple of the Art
elseif (currbiome == prefix .. "boss_victoryroom") then
    enemy_level = 7 --Heaven & Hell
end

if enemy_level > currentLevel then
    currentLevel = enemy_level
    GlobalsSetValue( "apotheosis_biome_level", tostring(currentLevel) )
end

