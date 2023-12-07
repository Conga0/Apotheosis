local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
dofile_once("mods/apotheosis/lib/apotheosis/apotheosis_utils.lua")


do --Addict Changes
  local path = "data/entities/player_base.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)

  local max_hp
  attrpath = xml:first_of("DamageModelComponent").attr
  max_hp = attrpath.hp
  max_hp = max_hp * 2
  attrpath.max_hp = tostring(max_hp)
  attrpath.hp = tostring(max_hp)

  xml:add_child(nxml.parse([[
      <Entity>  <Base file="mods/apotheosis/files/scripts/setup/addict_handler_10.xml" />  </Entity>
  ]]))

  ModTextFileSetContent(path, tostring(xml))
end







do --Alchemist Dream changes
  do -- Replace all normal potions with large potions
    local path = "data/scripts/item_spawnlists.lua"
    local content = ModTextFileGetContent(path)
    content = content:gsub("\"data/entities/items/pickup/potion.xml\"", "\"mods/apotheosis/files/entities/items/pickups/potion_reinforced.xml\"")
  
    ModTextFileSetContent(path, content)
  end

  do -- Add GC script to liquid bubbles
      local path = "data/entities/animals/bubbles/"
      local opts = {
          "acid",
          "alchemicprecursor",
          "ambrosia",
          "blood",
          "cursed_liquid",
          "deceleratium",
          "freezing_liquid",
          "healthium",
          "magic_catalyst",
          "pandorium",
          "sliceLiquid",
          "stophittingyourself",
          "unstablePandorium",
          "voidliquid",
          "water",
          "berserkium",
          "milk",
          "soarium"
      }

      for k=1,#opts
      do local v = table.concat({path,opts[k],"/bubble_liquid.xml"})
          local content = ModTextFileGetContent(v)
          local xml = nxml.parse(content)
          xml:add_child(nxml.parse([[
              <LuaComponent
              script_source_file="mods/Apotheosis/files/scripts/DEBUG/GC_Test.lua"
              execute_times="1"
              remove_after_executed="1"
              >
          </LuaComponent>
          ]]))
          ModTextFileSetContent(v, tostring(xml))
      end
  end

  do --Add alchemist & liquid bubble spawns to all biomes
      local populator_path = "mods/apotheosis/files/scripts/setup/alchemistdream_spawns.lua"
      local biomes = {
          "wizardcave",       --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
          "coalmine",         --Coal Mine, first area, goodluck on your run
          "desert",           --Desert above ground, careful not to die to any Stendari
          "crypt",            --Temple of the Arts.. who died here?
          "pyramid",          --Presumably everything below the entrance to the pyramid
          "fungicave",        --BUNGUS!! cave, west side of area 2 for example
          "coalmine_alt",     --Coalmine but to the west side near damp cave
          "pyramid_hallway",  --Pyramid entrance, presumably
          "excavationsite",   --Coal Pits, area 2
          "fungiforest",      --Overgrowth
          "snowcave",         --Snowy Depths
          "wandcave",         --Magical temple.. huh
          "sandcave",         --Desert sand cave, I don't think it includes desert chasm
          "winter",           --Winter appears to be the snow chasm... terrifying. Also line 69!
          "rainforest",       --Jungle
          "rainforest_dark",  --Lukki Lair.. creepy
          "liquidcave",       --Abandoned Alchemy Lab
          "the_end",          --Heaven, or Hell, your choice. Either are The Work.
          "vault",            --The Vault
          "robot_egg",        --I'm sure you can guess
          "vault_frozen",     --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
          "snowcastle",       --Hisii Base... Interesting name.. I won't judge.. too much, I've used some really weird inengine names myself in the past
          "robobase",         --Power Plant
          "clouds",           --Cloudscapes
          "hills",            --Hills, aka forest.
      }
  
      for k=1,#biomes
      do biomepath = biomes[k]
          ModLuaFileAppend("data/scripts/biomes/" .. biomepath .. ".lua", populator_path)
      end
  end

  do --Add alchemist & liquid bubble spawns to all biomes (Apotheosis)
      local populator_path = "mods/apotheosis/files/scripts/setup/alchemistdream_spawns.lua"
      local biomes = {
          "ant_hell",
          "lava_excavation",
          --"desert_pit",
          "sunken_cave"
      }
  
      for k=1,#biomes
      do biomepath = biomes[k]
          ModLuaFileAppend("mods/apotheosis/files/scripts/biomes/newbiome/" .. biomepath .. ".lua", populator_path)
      end
  end

  do --Update alchemy room to use large potions
      local path = "mods/apotheosis/files/scripts/biomes/newbiome/ant_hell_alchemyroom.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("\"data/entities/items/pickup/potion%.xml\"", "\"mods/apotheosis/files/entities/items/pickups/potion_reinforced.xml\"")
      ModTextFileSetContent(path, content)
  end
end







do --Towerclimb setup (significantly reduced spawnrates on most creatures)
  --Appends Tower Spawns to All vanilla biomes
  local populator_path = "mods/apotheosis/files/scripts/biomes/global_everything_populator_towerclimb_everything.lua"
  local biomes = {
      "wizardcave",       --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
      "coalmine",         --Coal Mine, first area, goodluck on your run
      "desert",           --Desert above ground, careful not to die to any Stendari
      "crypt",            --Temple of the Arts.. who died here?
      "pyramid",          --Presumably everything below the entrance to the pyramid
      "fungicave",        --BUNGUS!! cave, west side of area 2 for example
      "coalmine_alt",     --Coalmine but to the west side near damp cave
      "pyramid_hallway",  --Pyramid entrance, presumably
      "excavationsite",   --Coal Pits, area 2
      "fungiforest",      --Overgrowth
      "snowcave",         --Snowy Depths
      "wandcave",         --Magical temple.. huh
      "sandcave",         --Desert sand cave, I don't think it includes desert chasm
      "winter",           --Winter appears to be the snow chasm... terrifying. Also line 69!
      "rainforest",       --Jungle
      "rainforest_dark",  --Lukki Lair.. creepy
      "liquidcave",       --Abandoned Alchemy Lab
      "the_end",          --Heaven, or Hell, your choice. Either are The Work.
      "vault",            --The Vault
      "robot_egg",        --I'm sure you can guess
      "vault_frozen",     --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
      "snowcastle",       --Hisii Base... Interesting name.. I won't judge.. too much, I've used some really weird inengine names myself in the past
      "robobase",         --Power Plant
      "clouds",           --Cloudscapes
      "hills",            --Hills, aka forest.
  }

  for k=1,#biomes
  do biomepath = biomes[k]
      ModLuaFileAppend("data/scripts/biomes/" .. biomepath .. ".lua", populator_path)
  end

  

  --Appends Tower Spawns to All new biomes
  local biomes = {
      "lava_excavation",       --Core Mines, Volcanic lava filled land in the desert with plenty of loot but plenty of death
      "evil_temple",           --Temple of Sacriligious Remains
      "sunken_cave",           --Sunken Cavern, aquamages be ware!
      "slime_hell",            --Virulent Caverns, Slime Hell
      "desert_pit",            --Desert Sinkhole
  }

  for k=1,#biomes
  do biomepath = biomes[k]
      ModLuaFileAppend("mods/apotheosis/files/scripts/biomes/newbiome/" .. biomepath .. ".lua", populator_path)
  end
end







do --Poverty Setup
    local path = "data/biome/gold.xml"
    local content = ModTextFileGetContent(path)
    content = content:gsub("\"gold\"", "\"templebrick_golden_static\"")
    content = content:gsub("\"$biome_gold\"", "\"$mat_templebrick_golden_static\"")
    ModTextFileSetContent(path, content)
end
