--Golden Statues for beating the game with challenge seeds would be sick, would need to check they were enabled at the start though instead of the end
--Load the relevent flags for the current seed loaded, then enable another flag saying to not allow anymore custom seed flags to be loaded in, would likely work

local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
dofile_once("mods/apotheosis/lib/apotheosis/apotheosis_utils.lua")

function AddUI(filename)
    local path = "data/entities/player_base.xml"
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    
    xml:add_child(nxml.parse([[
        <Entity>  <Base file="mods/apotheosis/files/scripts/setup/]] .. filename .. [[_ui.xml" />  </Entity>
    ]]))

    ModTextFileSetContent(path, tostring(xml))
end


function towerclimb()

    GameAddFlagRun("apotheosis_towerclimb")

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

    AddUI("towerclimb")
end



function hardcore()

    GameAddFlagRun("apotheosis_hardmode")

    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_hardmode.lua" )

    dofile_once("mods/apotheosis/files/scripts/setup/hardmode_setup.lua")

    AddUI("hardcore")

end

function glassed()

    GameAddFlagRun("apotheosis_glassed")
    
    local path = "data/entities/player_base.xml"
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    
    xml:add_child(nxml.parse([[
        <Entity>  <Base file="mods/apotheosis/files/scripts/setup/glassed_handler.xml" />  </Entity>
    ]]))

    xml:first_of("DamageModelComponent"):first_of("damage_multipliers").attr.explosion = "0.05"

    ModTextFileSetContent(path, tostring(xml))

end

function missingmagic()

    GameAddFlagRun("apotheosis_missingmagic")

    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_missingmagic.lua" )

    AddUI("missingmagic")

end



--function perkedup()
--
--    local path = "data/entities/player_base.xml"
--    local content = ModTextFileGetContent(path)
--    local xml = nxml.parse(content)
--    
--    xml:add_child(nxml.parse([[
--        <LuaComponent
--            execute_on_added=0
--            script_source_file="mods/apotheosis/files/scripts/setup/perkedup_update.lua"
--            execute_every_n_frame=120
--            remove_after_executed=0
--            execute_times=-1
--            >
--        </LuaComponent>
--    ]]))
--    
--    ModTextFileSetContent(path, tostring(xml))
--
--end













local input_seed = string.lower(ModSettingGet( "Apotheosis.custom_seed" ))
if input_seed == "" then input_seed = "0" end
local output_seed = "0"
custom_seed = false

local secret_seeds = {
    {
        ID = "towerclimb",
        func = towerclimb
    },
    {
        ID = "hardcore",
        func = hardcore
    },
    --[[
    --Conga: kind of boring, either you one shot everything or you get one shot
    --The glassed challenge perk visual looks nice though
    {
        ID = "glassed",
        func = glassed
    },
    ]]--
    {
        ID = "missingmagic",
        func = missingmagic
    },
    --[[
    --Vanilla enemy-perk integration is.. "functional", at best.
    {
        ID = "perkedup",
        func = perkedup
    },
    ]]--
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
    local set_seed_xml = table.concat({'<MagicNumbers WORLD_SEED="',output_seed,'" _DEBUG_DONT_SAVE_MAGIC_NUMBERS="1"/>'})
    ModTextFileSetContent("mods/apotheosis/scripts/setup/set_seed.xml", set_seed_xml)
    ModMagicNumbersFileAdd("mods/apotheosis/scripts/setup/set_seed.xml")
    custom_seed = true
end
