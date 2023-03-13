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
    MultiplyHPOnBiome("custom/sunken_cave", 10, 1.5)
    MultiplyHPOnBiome("custom/evil_temple", 10, 1.5)
    MultiplyHPOnBiome("fungicave", 4, 1)
    MultiplyHPOnBiome("fungiforest", 6, 1)
    MultiplyHPOnBiome("clouds", 6, 2)
    MultiplyHPOnBiome("pyramid", 3, 1.2)
    MultiplyHPOnBiome("robobase", 10, 2)
end


----Boosts the health of various boss monsters
--Angel doesn't need to be done here and it's handled by the above function
--filepath   multiplier   base check
MultiplyHPSelective("boss_fire_lukki/boss_fire_lukki",10,false)
MultiplyHPSelective("boss_flesh_monster/boss_flesh_monster",10,false)
MultiplyHPSelective("boss_musical_ghost/boss_musical_ghost",10,false)
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

--Note(Conga): This isn't working, no clue why
do -- Buff Final Boss's HP as if you grabed 10 orbs
  local path = "data/entities/animals/boss_centipede/boss_centipede_update.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("local boss_hp = 46.0 + ( 2.0 ^ (orbcount + 1.3) ) + (orbcount*15.5)", "local boss_hp = 46.0 + ( 2.0 ^ ((orbcount + 10) + 1.3) ) + ((orbcount + 10)*15.5)")
  ModTextFileSetContent(path, content)
end

