local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
dofile_once("mods/apotheosis/lib/apotheosis/apotheosis_utils.lua")

--Boosts Health of Wand Tinkering Crystals by x10
MultiplyHPSelectiveBuilding("wandedit_crystal",10,false)

ModMagicNumbersFileAdd("mods/Apotheosis/files/scripts/setup/downunder_magic_numbers.xml") --Sets the biome map

do
  local overrides = {
    "temple_altar_top_shared.lua",
    "temple_altar.lua",
    "temple_altar_left.lua",
    "temple_altar_right.lua",
    "temple_wall.lua",
    "temple_wall_ending.lua",
    "mountain/mountain_left_entrance.lua",
  }

  for k=1,#overrides do -- Change mountain altar portals to use their flipped varient
    local content = ModTextFileGetContent(table.concat({"mods/apotheosis/files/scripts/biomes/newbiome/special/",overrides[k]}))
    ModTextFileSetContent(table.concat({"data/scripts/biomes/",overrides[k]}),content)
  end
end


do
  local overrides = {
    "pyramid_top.xml",
    "_pixel_scenes.xml",
    "the_sky.xml",
    "the_end.xml",
    "solid_wall.xml",
  }

  for k=1,#overrides do -- Change mountain altar portals to use their flipped varient
    local content = ModTextFileGetContent(table.concat({"mods/apotheosis/files/biome/special/",overrides[k]}))
    ModTextFileSetContent(table.concat({"data/biome/",overrides[k]}),content)
    --[[
    if k == 2 then
      for l=1,10 do
        print("We are about to print pixel scene data")
      end
      print(content)
    end
    ]]--
  end
end


do
  local overrides = {
    "buildings/teleport_liquid_powered.xml",
    "buildings/mystery_teleport.xml",
    "buildings/mystery_teleport_back.xml",
    "buildings/mystery_teleport_back_apotheosis.xml",
    "buildings/teleport_ending.xml",
    "items/pickup/essence_water.xml",
    "misc/essences/water_bullet.xml",
    "misc/essences/water_explosion.xml",
  }

  for k=1,#overrides do -- Change mountain altar portals to use their flipped varient
    local content = ModTextFileGetContent(table.concat({"mods/apotheosis/files/entities/downunder/",overrides[k]}))
    ModTextFileSetContent(table.concat({"data/entities/",overrides[k]}),content)
  end
end


do
  local overrides = {
    "items/generate_shop_item.lua"  --local biomepixel = math.floor(((y * -1) + offset) / 512)
  }

  for k=1,#overrides do -- Change mountain altar portals to use their flipped varient
    local content = ModTextFileGetContent(table.concat({"mods/apotheosis/files/entities/downunder/scripts/",overrides[k]}))
    ModTextFileSetContent(table.concat({"data/scripts/",overrides[k]}),content)
  end
end


do
  local overrides = {
    "skull.xml"  --le skull
  }

  for k=1,#overrides do -- Change mountain altar portals to use their flipped varient
    local content = ModTextFileGetContent(table.concat({"mods/apotheosis/files/biome/special/",overrides[k]}))
    ModTextFileSetContent(table.concat({"data/biome_impl/spliced/",overrides[k]}),content)
  end
end

--Fixes Hiisi not being in Hiisi base
ModLuaFileAppend("data/scripts/biomes/snowcastle.lua","mods/apotheosis/files/entities/downunder/scripts/biomes/snowcastle_appends.lua")

--Flip The Work spawns
ModLuaFileAppend("data/scripts/biomes/the_end.lua","mods/apotheosis/files/entities/downunder/scripts/biomes/the_sky_appends.lua")

do -- Flip the Suns
  local path = "data/biome_impl/spliced/moon.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("-26104", "37513")
  ModTextFileSetContent(path, content)

  local path = "data/biome_impl/spliced/moon_dark.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("37513", "-26104")
  ModTextFileSetContent(path, content)
end

--[[
do -- Adjust lake island position
  local path = "data/biome_impl/spliced/lake_statue.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("pos_x=\"%-14848\" pos_y=\"160\"", "pos_x=\"-15896\" pos_y=\"13984\"")
  content = content:gsub("pos_x=\"%-14336\" pos_y=\"23\"","pos_x=\"-16384\" pos_y=\"13847\"")
  content = content:gsub("pos_x=\"%-13824\" pos_y=\"156\"","pos_x=\"%-15872\" pos_y=\"13980\"")
  ModTextFileSetContent(path, content)
end
]]--
