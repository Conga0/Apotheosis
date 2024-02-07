local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
dofile_once("mods/apotheosis/lib/apotheosis/apotheosis_utils.lua")

----Boosts Health of various in-world creatures

--Mainpath
--[[
]]--
function OnWorldInitialized() 
    MultiplyHPOnBiome("coalmine", 1, 1)
    MultiplyHPOnBiome("excavationsite", 1.2, 1)
    MultiplyHPOnBiome("snowcave", 2, 1)
    MultiplyHPOnBiome("custom/lava_excavation", 2, 1)
    MultiplyHPOnBiome("snowcastle", 1, 1.5)
    MultiplyHPOnBiome("rainforest", 4, 1)
    MultiplyHPOnBiome("vault", 6, 1)
    MultiplyHPOnBiome("vault_frozen", 6, 1)
    MultiplyHPOnBiome("crypt", 5, 1.2) --Note: Crypt enemies already have their hp multiplied by x2

    --Optional
    MultiplyHPOnBiome("the_end", 3, 2) --Note: Heaven & Hell enemies already have their hp multiplied by x10
    MultiplyHPOnBiome("the_sky", 3, 2) --Note: Heaven & Hell enemies already have their hp multiplied by x10
    MultiplyHPOnBiome("desert", 2, 1)
    MultiplyHPOnBiome("sandcave", 5, 1.2)
    MultiplyHPOnBiome("wandcave", 5, 1)
    MultiplyHPOnBiome("wizardcave", 10, 1.5)
    MultiplyHPOnBiome("liquidcave", 4, 1)
    MultiplyHPOnBiome("custom/ant_hell", 2, 1.5)
    MultiplyHPOnBiome("custom/slime_hell", 5, 1.2)
    MultiplyHPOnBiome("custom/sunken_cave", 10, 1.5)
    MultiplyHPOnBiome("custom/evil_temple", 20, 1.5)
    MultiplyHPOnBiome("custom/evil_temple_sand", 20, 1.5)
    MultiplyHPOnBiome("fungicave", 4, 1)
    MultiplyHPOnBiome("fungiforest", 6, 1)
    MultiplyHPOnBiome("clouds", 6, 2)
    MultiplyHPOnBiome("pyramid", 3, 1.2)
    MultiplyHPOnBiome("robobase", 10, 2)
    MultiplyHPOnBiome("meat", 1, 4)

    --Secret Biomes
    MultiplyHPOnBiome("custom/plane_yggdrasil", 10, 1.5)
    MultiplyHPOnBiome("custom/plane_magic", 10, 1.5)
    MultiplyHPOnBiome("custom/plane_mechanical", 10, 1.5)
end


----Boosts the health of various boss monsters
--Angel doesn't need to be done here and it's handled by the above function
--filepath   multiplier   base check
MultiplyHPSelective("boss_flesh_monster/boss_flesh_monster",20,false)
MultiplyHPSelective("boss_flesh_monster/phase3/boss_flesh_monster",20,false)
MultiplyHPSelective("boss_fire_lukki/boss_fire_lukki",10,false)
MultiplyHPSelective("boss_fire_lukki/boss_fire_lukki_phase2",10,false)
MultiplyHPSelective("boss_musical_ghost/boss_musical_ghost",20,false)
MultiplyHPSelective("boss_meat/boss_meat",20,false)
MultiplyHPSelective("boss_blob/blob_titan",10,true)
MultiplyHPSelective("boss_blob/blob_huge",10,true)
MultiplyHPSelective("boss_blob/blob_big",5,true)
MultiplyHPSelective("boss_blob/blob",2,true)
MultiplyHPSelective("boss_robot/boss_robot",10,false)
MultiplyHPSelective("boss_wizard/boss_wizard",10,true)
MultiplyHPSelective("boss_wizard/wizard_orb_death",10,false)
MultiplyHPSelective("boss_pit/boss_pit",10,false)
MultiplyHPSelective("boss_alchemist/boss_alchemist",10,true)
MultiplyHPSelective("boss_ghost/boss_ghost",10,false)
MultiplyHPSelective("boss_limbs/boss_limbs",10,false)
MultiplyHPSelective("boss_toxic_worm/boss_toxic_worm",4,false)
MultiplyHPSelective("boss_spirit/islandspirit",4,true)
MultiplyHPSelective("boss_dragon",4,false)
MultiplyHPSelective("boss_fish/fish_giga",2,false)

--Increase health of PW bosses
MultiplyHPSelective("parallel/tentacles/parallel_tentacles",2,false)
MultiplyHPSelective("parallel/alchemist/parallel_alchemist",2,true)
MultiplyHPSelective("parallel_apotheosis/boss_toxic_worm/boss_toxic_worm",4,false)

--Boosts Health of Wand Tinkering Crystals by x10
MultiplyHPSelectiveBuilding("wandedit_crystal",10,false)

--Note(Conga): This isn't working, no clue why
--14/01/2024: Fixed
do -- Buff Final Boss's HP as if you grabed 10 orbs
  local path = "data/entities/animals/boss_centipede/boss_centipede_update.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("%(orbcount %+ 1.3%) %) %+ %(orbcount%*15%.5%)", "((orbcount + 11) + 1.3) ) + ((orbcount + 11)*15.5)")
  ModTextFileSetContent(path, content)
end

do --Reduces the NG+ count of each biome's enemy pool by 1
  local biomes = {
    "wizardcave",       --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
    "coalmine",         --Coal Mine, first area, goodluck on your run
    "coalmine_alt",     --Coalmine but to the west side near damp cave
    "desert",           --Desert above ground, careful not to die to any Stendari
    "crypt",            --Temple of the Arts.. who died here?
    "pyramid",          --Presumably everything below the entrance to the pyramid
    "fungicave",        --BUNGUS!! cave, west side of area 2 for example
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
  local appendpath ="mods/apotheosis/files/scripts/setup/enemy_appends_everything.lua"

  for k=1,#biomes
  do local v = biomes[k]
    local biomepath = table.concat({"data/scripts/biomes/", v, ".lua"})
    ModLuaFileAppend(biomepath, appendpath)
  end
end

do --Reduces the NG+ count of each biome's enemy pool by 1 (modded)
  local biomes = {
    "ant_hell", --Ant Nest
    "desert_pit", --Sink Hole
    "esoteric_den", --Esoteric Den
    "evil_temple",  --Temple of Sacriligious Remains
    "lava_excavation",  --Core Mines
    "sunken_cave",  --Sunken Cavern
  }
  local appendpath ="mods/apotheosis/files/scripts/setup/enemy_appends_everything.lua"

  for k=1,#biomes
  do local v = biomes[k]
    local biomepath = table.concat({"mods/apotheosis/files/scripts/biomes/newbiome/", v, ".lua"})
    ModLuaFileAppend(biomepath, appendpath)
  end
end

do --Reduce gold dropped in apotheotic by 75%
  local path = "data/scripts/items/drop_money.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("local health = tonumber%(ComponentGetValue%( comp, \"max_hp\"%)%)", "local health = tonumber(ComponentGetValue( comp, \"max_hp\")) * 0.25")
  ModTextFileSetContent(path, content)
end

do --Remove fungal & creature shift icons to avoid ui clog
  local path = "mods/Apotheosis/files/scripts/magic/fungal_shift_spam.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("if add_icon then", "if add_icon and 1 == 2 then")
  content = content:gsub("apotheosis_redstone", "apotheosis_unholy_concoction")
  content = content:gsub("apotheosis_insect_husk", "apotheosis_magic_liquid_divine")
  content = content:gsub("\"water\"", "\"magic_liquid_hp_regeneration\"")
  content = content:gsub("\"copper\"", "\"apotheosis_milk_powder\"")
  content = content:gsub("\"material_confusion\"", "\"apotheosis_radioactive_mud\"")
  content = content:gsub("\"rock_hard\"", "\"apotheosis_radioactive_mud\"")
  content = content:gsub("\"rock_hard_border\"", "\"apotheosis_radioactive_mud\"")
  content = content:gsub("\"rock_hard_border\"", "\"apotheosis_radioactive_mud\"")
  content = content:gsub("\"templebrick_static\"", "\"apotheosis_radioactive_mud\"")
  content = content:gsub("\"snow_static\"", "\"apotheosis_magic_liquid_mimic\"")
  content = content:gsub("\"steel_static\"", "\"apotheosis_magic_liquid_pure_light\"")
  content = content:gsub("\"rock_static\"", "\"corruption_static\"")
  content = content:gsub("\"rock_static_wet\"", "\"apotheosis_smoke_static_slowburn\"")
  content = content:gsub("\"rock_static_cursed\"", "\"concrete_static\"")
  content = content:gsub("\"templeslab_static\"", "\"concrete_static\"")
  content = content:gsub("\"templeslab_crumbling_static\"", "\"apotheosis_radioactive_liquid_strong\"")
  content = content:gsub("\"lava\"", "\"apotheosis_magic_liquid_moon_portal\"")
  ModTextFileSetContent(path, content)

  local path = "mods/apotheosis/files/scripts/magic/creature_shift_file.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("if add_icon then", "if add_icon and 1 == 2 then")
  content = content:gsub("\"bubbles/freezing_liquid/bubble_liquid\", \"fish\", \"forsaken_eye\"", "\"bubbles/freezing_liquid/bubble_liquid\", \"forsaken_eye\"")
  content = content:gsub("%( EntityGetName%( v %) == \"creature_shift_ui_icon\" %)", "%( EntityGetName%( v %) == \"creature_shift_ui_icon\" %) and 1 == 2")
  ModTextFileSetContent(path, content)
end

do --Heretic drops the plane radar perk for convinience
  local path = "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster_death.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("%-%-EntityLoad%( \"mods/apotheosis/files/entities/items/pickups/stone_heretic%.xml\", pos_x, pos_y %)", "do dofile_once(\"data/scripts/perks/perk.lua\") perk_spawn( pos_x, pos_y, \"APOTHEOSIS_PLANE_RADAR\" ) end")
  ModTextFileSetContent(path, content)
end

do --Disable winning at mountain altar & the work
  local path = "data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("ending_sampo_spot_mountain", "acid")
  ModTextFileSetContent(path, content)

  local path = "data/entities/animals/boss_centipede/ending/ending_sampo_spot_underground.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("ending_sampo_spot_underground", "acid")
  ModTextFileSetContent(path, content)

  local path = "data/entities/animals/boss_centipede/boss_centipede_update.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"data/entities/buildings/teleport_ending_victory_delay%.xml\"", "\"mods/apotheosis/files/entities/spawners/everything_kolmiloot.xml\"")
  ModTextFileSetContent(path, content)
end

do --Portal displays the Divine Radar icon to indicate the perk is required to progress
  local path = "mods/apotheosis/files/entities/buildings/gateway_base.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("portal.png", "portal_everything.png")
  ModTextFileSetContent(path, content)
end

do --Artifically secret seed game flag is added
  local path = "mods/apotheosis/files/scripts/magic/player_parallel_check.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("%-%-Placeholder", "GameAddFlagRun%(\"apotheosis_everything\"%)")
  ModTextFileSetContent(path, content)
end

do --Update the Hiisi Shop to always spawn a water stone & update the aesthete spawner to look for a water stone, and also remove the Volcanic Chest from the teleporter room so you HAVE to kill aesthete for them
  local path = "mods/apotheosis/files/scripts/biomes/hiisi_shop_populator.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("brimstone", "waterstone")
  ModTextFileSetContent(path, content)

  local path = "mods/apotheosis/files/scripts/buildings/fire_lukki_brimstone_populator.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("/boss_fire_lukki/", "/boss_water_lukki/")
  ModTextFileSetContent(path, content)

  local path = "mods/apotheosis/files/entities/buildings/fire_lukki_brimstone_detector.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"brimstone\"", "\"waterstone\"")
  ModTextFileSetContent(path, content)

  local path = "mods/apotheosis/files/biome/special/_pixel_scenes.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("mods/Apotheosis/files/entities/items/pickups/chest_volcanic%.xml", "")
  ModTextFileSetContent(path, content)
end

do --Change all lukkis in the red jungle into Heretics & Clear foliage
  local path = "data/scripts/biomes/rainforest.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("lukki/lukki_longleg%.xml", "lukki_tentacle_hungry.xml")
  content = content:gsub("lukki/lukki%.xml", "lukki_tentacle_hungry.xml")
  content = content:gsub("load_random_pixel_scene%( g_pixel_scene_04, x, y %)", "--disabled")
  content = content:gsub("spawn%(g_trees,x%+5,y%+5%)", "--disabled")
  content = content:gsub("spawn%(g_vines,x%+5,y%+5%)", "--disabled")
  content = content:gsub("spawn%(g_vines,x,y%+5%)", "--disabled")
  content = content:gsub("EntityLoad%( \"data/entities/props/root_grower%.xml\", x%+5, y%+5 %)", "--disabled")
  ModTextFileSetContent(path, content)
end

do --Swaps the lake into a lava lake
  local path = "mods/Apotheosis/files/scripts/biomes/newbiome/sunken_cave_entrance_lake_alt_lava.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("entrance_lake_alt_lava", "entrance_lake_lava")
  ModTextFileSetContent(path, content)

  local path = "mods/Apotheosis/files/scripts/biomes/newbiome/essenceroom_fire.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("essenceroom_submerged", "essenceroom_submerged_lava")
  ModTextFileSetContent(path, content)

  local path = "data/scripts/biomes/essenceroom_alc.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("essenceroom_submerged", "essenceroom_submerged_lava")
  ModTextFileSetContent(path, content)

  local path = "mods/apotheosis/files/biome/special/_pixel_scenes.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("data/biome_impl/spliced/lake_statue%.xml", "mods/apotheosis/files/biome_impl/spliced/lake_statue_lava.xml")
  ModTextFileSetContent(path, content)
end

--Preconvert Empyrean to flesh
--ConvertMaterialEverywhere(CellFactory_GetType( "apotheosis_templebrick_static_invincible" ),CellFactory_GetType( "apotheosis_corrupt_flesh_static" ))


--Some fun biome changes to keep things interesting
do
  local overrides = {
    "rainforest.xml",
    "rainforest_open.xml",
    "lake_deep.xml",
    "lake.xml",
    "lava.xml",
    "lava_90percent.xml",
    "custom/sunken_cave_entrance_lake_alt.xml",
    "custom/sunken_cave_entrance_lake_alt_lava.xml",
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
