--Golden Statues for beating the game with challenge seeds would be sick, would need to check they were enabled at the start though instead of the end
--Load the relevent flags for the current seed loaded, then enable another flag saying to not allow anymore custom seed flags to be loaded in, would likely work

local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
dofile_once("mods/Apotheosis/lib/apotheosis/apotheosis_utils.lua")

function AddUI(filename)
    local path = "data/entities/player_base.xml"
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    
    xml:add_child(nxml.parse([[
        <Entity>  <Base file="mods/Apotheosis/files/scripts/setup/]] .. filename .. [[_ui.xml" />  </Entity>
    ]]))

    ModTextFileSetContent(path, tostring(xml))
end

--[[
function OnModInit()
    newrun = false
    if SessionNumbersGetValue("is_biome_map_initialized") == "0" then
        newrun = true
    end
    for j=1,20 do
        print("newrun is " .. tostring(newrun))
    end
end
]]--

--if v.IDs[l] == GameHasFlagRun(table.concat({"apotheosis_",v.ID})) and newrun == false then
--This code coooould be useful if the game is struggling to update/remove special seeds?
--Hard to say, results are inconclusive and janky as hell

function towerclimb()

    GameAddFlagRun("apotheosis_towerclimb")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_towerclimb\")")
      ModTextFileSetContent(path, content)
    end

    --Appends Tower Spawns to All vanilla biomes
    local populator_path = "mods/Apotheosis/files/scripts/biomes/global_everything_populator_towerclimb.lua"
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
        ModLuaFileAppend("mods/Apotheosis/files/scripts/biomes/newbiome/" .. biomepath .. ".lua", populator_path)
    end

    AddUI("towerclimb")
end



function hardcore()

    GameAddFlagRun("apotheosis_hardmode")

    do --Artifically secret seed game flag is added
        local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
        local content = ModTextFileGetContent(path)
        content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_hardmode\")")
        ModTextFileSetContent(path, content)
    end

    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_hardmode.lua" )

    dofile_once("mods/Apotheosis/files/scripts/setup/hardmode_setup.lua")

    AddUI("hardcore")

end

function nightcore()

    GameAddFlagRun("apotheosis_hardmode")
    --Adding this just for Heretical Eye dialogue...
    GameAddFlagRun("apotheosis_nightmode")

    do --Artifically secret seed game flag is added
        local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
        local content = ModTextFileGetContent(path)
        content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_hardmode\") GameAddFlagRun(\"apotheosis_nightmode\")")
        ModTextFileSetContent(path, content)
    end

    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_hardmode.lua" )

    dofile_once("mods/Apotheosis/files/scripts/setup/hardmode_setup.lua")
    dofile_once("mods/Apotheosis/files/scripts/setup/nightcore_setup.lua")

    AddUI("nightcore")

end

function glassed()

    GameAddFlagRun("apotheosis_glassed")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_glassed\")")
      ModTextFileSetContent(path, content)
    end
    
    local path = "data/entities/player_base.xml"
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    
    xml:add_child(nxml.parse([[
        <Entity>  <Base file="mods/Apotheosis/files/scripts/setup/glassed_handler.xml" />  </Entity>
    ]]))

    xml:first_of("DamageModelComponent"):first_of("damage_multipliers").attr.explosion = "0.05"

    ModTextFileSetContent(path, tostring(xml))

end

function missingmagic()

    GameAddFlagRun("apotheosis_missingmagic")

    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_missingmagic.lua" )

    AddUI("missingmagic")

end

function alchemistdream()

    GameAddFlagRun("apotheosis_alchemistdream")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_alchemistdream\")")
      ModTextFileSetContent(path, content)
    end

    do -- Replace all normal potions with large potions
      local path = "data/scripts/item_spawnlists.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("\"data/entities/items/pickup/potion.xml\"", "\"mods/Apotheosis/files/entities/items/pickups/potion_reinforced.xml\"")
    
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
            "soarium",
            "slime"
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
        local populator_path = "mods/Apotheosis/files/scripts/setup/alchemistdream_spawns.lua"
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
        local populator_path = "mods/Apotheosis/files/scripts/setup/alchemistdream_spawns.lua"
        local biomes = {
            "ant_hell",
            "lava_excavation",
            --"desert_pit",
            "sunken_cave"
        }
    
        for k=1,#biomes
        do biomepath = biomes[k]
            ModLuaFileAppend("mods/Apotheosis/files/scripts/biomes/newbiome/" .. biomepath .. ".lua", populator_path)
        end
    end

    do --Update alchemy room to use large potions
        local path = "mods/Apotheosis/files/scripts/biomes/newbiome/ant_hell_alchemyroom.lua"
        local content = ModTextFileGetContent(path)
        content = content:gsub("\"data/entities/items/pickup/potion%.xml\"", "\"mods/Apotheosis/files/entities/items/pickups/potion_reinforced.xml\"")
        ModTextFileSetContent(path, content)
    end

    AddUI("alchemistdream")

end

function addict()

    GameAddFlagRun("apotheosis_addict")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_addict\")")
      ModTextFileSetContent(path, content)
    end
    
    local path = "data/entities/player_base.xml"
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    
    xml:add_child(nxml.parse([[
        <Entity>  <Base file="mods/Apotheosis/files/scripts/setup/addict_handler.xml" />  </Entity>
    ]]))

    ModTextFileSetContent(path, tostring(xml))

    AddUI("addict")

end

function poverty()

    GameAddFlagRun("apotheosis_poverty")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_poverty\")")
      ModTextFileSetContent(path, content)
    end

    do --Reduce gold dropped in poverty by 100%
        local path = "data/scripts/items/drop_money.lua"
        local content = ModTextFileGetContent(path)
        content = content:gsub("local money = 10 %* amount", "local money = 0")
        ModTextFileSetContent(path, content)
    end

    do --Fools gold the gold room
        local path = "data/biome/gold.xml"
        local content = ModTextFileGetContent(path)
        content = content:gsub("\"gold\"", "\"templebrick_golden_static\"")
        content = content:gsub("\"$biome_gold\"", "\"$mat_templebrick_golden_static\"")
        ModTextFileSetContent(path, content)
    end

    AddUI("poverty")

end

function downunder()

    GameAddFlagRun("apotheosis_downunder")

    dofile_once("mods/Apotheosis/files/scripts/setup/downunder_setup.lua")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_downunder\")")
      ModTextFileSetContent(path, content)
    end

    AddUI("downunder")

end

--I don't expect anyone to beat this, but to quote Sisyphus.
--The struggle itself towards the heights is enough to fill a man's heart. One must imagine Sisyphus happy.
function everything()

    GameAddFlagRun("apotheosis_everything")

    do --Artifically secret seed game flag is added
      local path = "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      local content = ModTextFileGetContent(path)
      content = content:gsub("%-%-DONOTDELETETHIS", "GameAddFlagRun(\"apotheosis_everything\")")
      ModTextFileSetContent(path, content)
    end

    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_hardmode.lua" )
    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/scripts/setup/action_appends_missingmagic_everything.lua" )

    dofile_once("mods/Apotheosis/files/scripts/setup/everything_misc_setup.lua")
    dofile_once("mods/Apotheosis/files/scripts/setup/everything_setup.lua")
    dofile_once("mods/Apotheosis/files/scripts/setup/downunder_setup.lua")
    dofile_once("mods/Apotheosis/files/scripts/setup/nightcore_setup.lua")

    AddUI("everything")

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
--            script_source_file="mods/Apotheosis/files/scripts/setup/perkedup_update.lua"
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
        IDs = {"towerclimb"},
        func = towerclimb
    },
    {
        IDs = {"hardcore"},
        func = hardcore
    },
    {
        IDs = {"nightcore","nightmare"},   --Conga: Anyone else remember this? I remember listening to this a ton when I was younger
        func = nightcore
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
        IDs = {"missingmagic"},
        func = missingmagic
    },
    --[[
    --Vanilla enemy-perk integration is.. "functional", at best.
    {
        ID = "perkedup",
        func = perkedup
    },
    ]]--
    --All liquid bubbles gain the Glass Cannon perk & all potions become large potions, alchemists & liquid bubbles appear much more frequently
    {
        IDs = {"alchemistdream"},
        func = alchemistdream
    },
    {
        IDs = {"addict"},
        func = addict
    },
    {
        IDs = {"poverty"},
        func = poverty
    },
    {
        IDs = {"downunder","sisoehtopa","upsidedown","australia","australian"},
        func = downunder
    },
    {
        IDs = {"everything","getfixedboi","junglejuice","tuonela","jared"},
        func = everything
    },
}

--First scans if a custom seed is already loaded, if so, load their necessary data
--Secondly if one isn't, it'll compare the current seed to possible secret seeds and apply one if it's valid
for z=1,2 do
    for k=1,#secret_seeds do
        local v = secret_seeds[k]
        if z == 1 and not custom_seed then
            for l=1,#v.IDs do
                if v.IDs[l] == GameHasFlagRun(table.concat({"apotheosis_",v.ID})) then
                    input_seed = "0"
                    v.func()
                    custom_seed = true
                    break
                end
            end
        else
            for l=1,#v.IDs do
                if (v.IDs[l] == input_seed) and not custom_seed then
                    input_seed = "0"
                    v.func()
                    custom_seed = true
                    break
                end
            end
        end
    end
end


function generateNormalSeed(input_seed)
    local biggest_seed_possible = 2147483645
    local conversion_number = 0
    
    --Check to see if inputted seed contains only numeric characters
    local is_number = tonumber(input_seed)
    if is_number == nil then
        is_number = false
    else
        if is_number > biggest_seed_possible then input_seed = is_number % biggest_seed_possible end
        is_number = true
    end

    if is_number then
        return input_seed
    else
        for char in input_seed:gmatch "." do
            conversion_number = conversion_number + string.byte(char)
            conversion_number = conversion_number * string.byte(char) ^ 2
            conversion_number = conversion_number % biggest_seed_possible
        end
        input_seed = conversion_number
    end

    for k=1,10 do
        print("input_seed is " .. input_seed)
    end
    return input_seed
end



if input_seed == "0" then
    output_seed = "0"
else
    output_seed = generateNormalSeed(input_seed)
end

--Set Custom Seed
if output_seed ~= "0" and input_seed ~= "0" then
    local set_seed_xml = table.concat({'<MagicNumbers WORLD_SEED="',output_seed,'" _DEBUG_DONT_SAVE_MAGIC_NUMBERS="1"/>'})
    ModTextFileSetContent("mods/Apotheosis/scripts/setup/set_seed.xml", set_seed_xml)
    ModMagicNumbersFileAdd("mods/Apotheosis/scripts/setup/set_seed.xml")
    custom_seed = true
end
