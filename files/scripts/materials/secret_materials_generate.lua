
function GenerateMagicCatalyst()
    --math.randomseed(tonumber(final_seed))
    SetRandomSeed(111,222)

    --List of possible materials for Magic Catalyst
    local options = {
    "water",
    "water_ice",
    "water_salt",
    "swamp",
    "radioactive_liquid",
    "oil",
    "slime",
    "blood",
    "blood_fungi",
    "blood_worm",
    "alcohol",
    "blood_cold",
    "poison",
    "cement",
    "honey",
    "soil",
    "material_darkness",
    "material_rainbow",
    "rotten_meat",
    "wax",
    "glue",
    "coal",
    "copper",
    "silver",
    "gold",
    "diamond",
    "brass",
    "snow",
    "sand",
    "mud",
    "acid",
    "lava",
    --[[
    "magic_liquid_unstable_teleportation",
    "magic_liquid_polymorph",
    "magic_liquid_random_polymorph",
    "magic_liquid_berserk",
    "magic_liquid_charm",
    "magic_liquid_invisibility",
    "material_confusion",
    "magic_liquid_movement_faster",
    "magic_liquid_faster_levitation",
    "magic_liquid_worm_attractor",
    "magic_liquid_protection_all",
    "magic_liquid_mana_regeneration",
    "apotheosis_magic_liquid_velocium",
    "apotheosis_magic_liquid_suffocatium",
    "apotheosis_magic_liquid_pure_light",
    "apotheosis_magic_liquid_attunium",
    "apotheosis_magic_liquid_infinite_flight",
    ]]--
    "apotheosis_blood_worm_centipede",
    "apotheosis_insect_husk",
    "apotheosis_redstone",
    "apotheosis_milk",
    "apotheosis_sand_pink",
    "apotheosis_magic_liquid_pure_light",
    "apotheosis_radioactive_liquid_strong",
    }

    --local rng = math.random(1,#options)
    local rng = Random(1,#options)
    local mat_1 = options[rng]
    table.remove(options,rng)

    --local rng = math.random(1,#options)
    local rng = Random(1,#options)
    local mat_2 = options[rng]
    table.remove(options,rng)

    --local rng = math.random(1,#options)
    local rng = Random(1,#options)
    local mat_3 = options[rng]
    table.remove(options,rng)

    local chance = Random(1,100)

    do -- Apply random materials to the recipe file
        local path = "mods/apotheosis/files/scripts/materials/secret_materials.xml"
        local content = ModTextFileGetContent(path)
        content = content:gsub("random_material_01",mat_1)
        content = content:gsub("random_material_02",mat_2)
        content = content:gsub("random_material_03",mat_3)
        content = content:gsub("elixir_reaction_chance",chance)
        ModTextFileSetContent(path, content)
    end

    --[[
    if DebugGetIsDevBuild() then
        for k=1,3 do
            print("Magic Catalyst recipe is: " .. mat_1 .. " " .. mat_2 .. " " .. mat_3)
            print("With a chance of " .. chance)
        end
    end
    ]]--
    --This is handled in init.lua
    --ModMaterialsFileAdd( "mods/Apotheosis/files/scripts/materials/secret_materials.xml" )
end
