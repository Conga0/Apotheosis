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
    "song_room.xml",
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
    "buildings/teleport_teleroom_1.xml",
    "buildings/teleport_teleroom_2.xml",
    "buildings/teleport_teleroom_4.xml",
    "buildings/teleport_teleroom_5.xml",
    "buildings/teleport_teleroom_6.xml",
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

do -- Update Fire Lukki's correction
  local path = "mods/Apotheosis/files/scripts/buildings/fire_lukki_brimstone_populator.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("2631", "-3520")
  content = content:gsub("3046", "-2626")
  ModTextFileSetContent(path, content)
end

do -- Fia Portals
  local path = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_musicstone.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("<TeleportComponent", "<TeleportComponent target_x_is_absolute_position=\"1\" target_y_is_absolute_position=\"1\"")
  content = content:gsub("5350", "-3300")
  content = content:gsub("%-13388", "8320")
  ModTextFileSetContent(path, content)

  local path = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_dragoncave.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("<TeleportComponent", "<TeleportComponent target_x_is_absolute_position=\"1\" target_y_is_absolute_position=\"1\"")
  content = content:gsub("10756", "2850")
  content = content:gsub("%-9316", "5900")
  ModTextFileSetContent(path, content)

  local path = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_tower.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("<TeleportComponent", "<TeleportComponent target_x_is_absolute_position=\"1\" target_y_is_absolute_position=\"1\"")
  content = content:gsub("4301", "-3325")
  content = content:gsub("%-5900", "2100")
  ModTextFileSetContent(path, content)

  local path = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_lavalake.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("<TeleportComponent", "<TeleportComponent target_x_is_absolute_position=\"1\" target_y_is_absolute_position=\"1\"")
  content = content:gsub("10576", "-2430")
  content = content:gsub("%-15719", "12700")
  ModTextFileSetContent(path, content)
end

do -- Update Hourglass transmogrification
  local path = "data/entities/buildings/teleport_hourglass.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("%-3838", "3330")
  content = content:gsub("4908", "8512")
  ModTextFileSetContent(path, content)

  local path = "data/entities/buildings/teleport_hourglass_return.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("5231", "7783")
  ModTextFileSetContent(path, content)

  local path = "data/scripts/buildings/teleport_hourglass_return.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("5223", "7783")
  content = content:gsub("%-2210", "-1717")
  content = content:gsub("1707", "2220")
  ModTextFileSetContent(path, content)
end

do -- Allow Volcanic Eggs to appear
  local path = "mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("for i=1,4 do", "for i=1,8 do")
  content = content:gsub("local biome_x_min = %-1887", "local biome_x_min = -1480")
  content = content:gsub("local biome_x_max = 1843", "local biome_x_max = 2500")
  content = content:gsub("local biome_y_min = 1701", "local biome_y_min = 10820")
  content = content:gsub("local biome_y_max = 2403", "local biome_y_max = 11700")
  ModTextFileSetContent(path, content)

  --Updates Nest portal exit
  local path = "mods/Apotheosis/files/entities/buildings/lava_nest_portal.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("3108", "9764")
  ModTextFileSetContent(path, content)
  
  --Alchemy Room Entry Portal
  local path = "mods/Apotheosis/files/entities/buildings/teleport_alchemy_secret_entry.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("4875", "9995")
  ModTextFileSetContent(path, content)
  
  --Alchemy Room Return Portal
  local path = "mods/Apotheosis/files/entities/buildings/teleport_alchemy_secret_return.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("4021", "9141")
  ModTextFileSetContent(path, content)
end

do --Divine Radar Adjustment
  local path = "mods/apotheosis/files/scripts/perks/plane_radar.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("6445", "4909")
  ModTextFileSetContent(path, content)
end

do --Metal Egg return portal
  local path = "data/entities/buildings/teleport_robot_egg_return.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("6650", "6600")
  content = content:gsub("data/scripts/buildings/teleport_robot_egg_return%.lua", "")
  ModTextFileSetContent(path, content)
end

do --Newgame Plus alteration
  local path = "data/scripts/newgame_plus.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("BiomeMapLoad_KeepPlayer%( \"mods/apotheosis/files/biome_impl/newgame_plus/biome_map_newgame_plus%.lua\", \"data/biome/_pixel_scenes_newgame_plus%.xml\" %)", "BiomeMapLoad_KeepPlayer( \"mods/Apotheosis/files/scripts/setup/downunder_biome_map.lua\", \"data/biome/_pixel_scenes.xml\" )")
  ModTextFileSetContent(path, content)
end

do --Orbmap corrections
  local path = "mods/apotheosis/files/scripts/mod_compatibility/utilities_lua_appends.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("{8,1", "{-9,24")    --Pitboss Orb
  content = content:gsub("{1,%-3", "{1,-3")   --Mountain Temple Orb
  content = content:gsub("{%-9,7", "{-9,17")   --Magical Temple Orb
  content = content:gsub("{%-8,19", "{-7,6")  --Lukki Lair Orb
  content = content:gsub("{%-18,2", "{-18,28")  --Snow Chasm Orb
  content = content:gsub("{%-20,5", "{-20,25")  --Frozen Vault Orb
  content = content:gsub("{%-1,31", "{-1,-13")  --Hell Orb
  content = content:gsub("{20,31", "{25,2")   --Wizard's Den Orb
  content = content:gsub("{19,5", "{19,30")    --Sandcave's Orb
  content = content:gsub("{6,3", "{-9,26")     --Nuke Orb
  content = content:gsub("{19,%-3", "{19,22")  --Pyramid Top Orb
  content = content:gsub("{41,14", "{41,14")   --Temple of Sacriligeous Remanins Orb
  content = content:gsub("{%-42,18", "{-42,18") --Sunken Cavern Orb
  content = content:gsub("{36,32", "{36,32")   --Virulent Caverns Orb
  content = content:gsub("{%-41,2", "{-41,2")  --Forest Chasm Orb
  ModTextFileSetContent(path, content)
end
