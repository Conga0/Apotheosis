--Golden Statues for beating the game with challenge seeds would be sick, would need to check they were enabled at the start though instead of the end
--Load the relevent flags for the current seed loaded, then enable another flag saying to not allow anymore custom seed flags to be loaded in, would likely work



function towerclimb()

    --Appends Tower Spawns to All vanilla biomes
    local populator_path = "mods/apotheosis/files/scripts/biomes/global_everything_populator_towerclimb.lua"
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
    }

    for k=1,#biomes
    do biomepath = biomes[k]
        ModLuaFileAppend("mods/apotheosis/files/scripts/biomes/newbiome/" .. biomepath .. ".lua", populator_path)
    end
end












local input_seed = string.lower(ModSettingGet( "Apotheosis.custom_seed" ))
local output_seed = "0"
local custom_seed = false

local secret_seeds = {
    {
        ID = "towerclimb",
        func = towerclimb
    },
}



for k=1,#secret_seeds
do local v = secret_seeds[k]
    if (v.ID == input_seed) then
        input_seed = "0"
        v.func()
        custom_seed = true
    end
end



if input_seed == "0" then
    output_seed = "0"
else
    output_seed = input_seed
end

--Set Custom Seed
if output_seed ~= "0" and input_seed ~= "0" then
    local set_seed_xml = '<MagicNumbers WORLD_SEED="' .. output_seed .. '" _DEBUG_DONT_SAVE_MAGIC_NUMBERS="1"/>'
    ModTextFileSetContent("mods/apotheosis/scripts/setup/set_seed.xml", set_seed_xml)
    ModMagicNumbersFileAdd("mods/apotheosis/scripts/setup/set_seed.xml")
    custom_seed = true
end

--Remind player they're on a custom seed
if custom_seed == true then
    function OnPlayerSpawned()
            GamePrint("$sign_apotheosis_custom_seed" )
            --GamePrint(ModSettingGet( "Apotheosis.custom_seed" ))
     end
end

