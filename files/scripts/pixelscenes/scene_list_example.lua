--Here we grab the world size, the idea is if another mod changes the world length, we can grab the length here; otherwise default to the vanilla world length of 35840 pixels
--You do not need to create this file, but if another mod changes the world length, they would need to create it and specify how large their world is
local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
local appends = {"_pixel_scenes","_pixel_scenes_newgame_plus",}
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

for k=1, #appends
do local v = appends[k];

    --Wand Tinkering Crystal guaranteed spawn at Pyramid
    local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="10868" pos_y="-150" skip_biome_checks="1" skip_edge_textures="0"
        material_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png"
        background_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal_background.png"
        colors_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal_visual.png"
    ></PixelScene>
    ]]))
    ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

    --Wand Tinkering Crystal guaranteed spawn (PW East)
    --Here we concatoncate the x position of the pixel scene in the main world with the world length, adding to it for east worlds
    local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="]],(10868 + worldsize),[[" pos_y="-150" skip_biome_checks="1" skip_edge_textures="0"
        material_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png"
        background_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal_background.png"
        colors_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal_visual.png"
    ></PixelScene>
    ]]})))
    ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

    --Wand Tinkering Crystal guaranteed spawn (PW West)
    --And subtracing it for west worlds
    --We also use table.concat here because normal .. concats are famously slow
    local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="]],(10868 - worldsize),[[" pos_y="-150" skip_biome_checks="1" skip_edge_textures="0"
        material_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png"
        background_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal_background.png"
        colors_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal_visual.png"
    ></PixelScene>
    ]]})))
    ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

end

--Demo tower code
do --Tower creature appends
    local creature_table = {"enemy_1","enemy_2","enemy_3",}
  
    local concat_table = table.concat(creature_table, "\",\"")
  
    local path = "data/scripts/biomes/tower.lua"
    local content = ModTextFileGetContent(path)
    content = content:gsub([[local enemy_list = { "acidshooter", "alchemist", "ant",]], table.concat({[[enemy_list = { "acidshooter", "alchemist", "ant","]],concat_table,"\","}))
    ModTextFileSetContent(path, content)
end
