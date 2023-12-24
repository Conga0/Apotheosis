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

    --Increase health of PW bosses
    MultiplyHPSelective("parallel/tentacles/parallel_tentacles",4,false)
    MultiplyHPSelective("parallel/alchemist/parallel_alchemist",4,true)
    MultiplyHPSelective("parallel_apotheosis/boss_toxic_worm/boss_toxic_worm",4,false)

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
MultiplyHPSelective("boss_dragon",4,false)
MultiplyHPSelective("boss_fish/fish_giga",2,false)

--Boosts Health of Wand Tinkering Crystals by x10
MultiplyHPSelectiveBuilding("wandedit_crystal",10,false)

--Note(Conga): This isn't working, no clue why
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
  local appendpath ="mods/apotheosis/files/scripts/setup/enemy_appends_hardmode.lua"

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
  local appendpath ="mods/apotheosis/files/scripts/setup/enemy_appends_hardmode.lua"

  for k=1,#biomes
  do local v = biomes[k]
    local biomepath = table.concat({"mods/apotheosis/files/scripts/biomes/newbiome/", v, ".lua"})
    ModLuaFileAppend(biomepath, appendpath)
  end
end

do --Reduce gold dropped in hardcore by 50%
  local path = "data/scripts/items/drop_money.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("local health = tonumber%(ComponentGetValue%( comp, \"max_hp\"%)%)", "local health = tonumber(ComponentGetValue( comp, \"max_hp\")) * 0.50")
  ModTextFileSetContent(path, content)
end

do --Artifically secret seed game flag is added
  local path = "mods/apotheosis/files/scripts/magic/player_parallel_check.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("%-%-Placeholder", "GameAddFlagRun%(\"apotheosis_hardcore\"%)")
  ModTextFileSetContent(path, content)
end
