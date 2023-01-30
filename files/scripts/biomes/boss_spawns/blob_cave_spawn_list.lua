local appends = {"_pixel_scenes","_pixel_scenes_newgame_plus",}
for k=1, #appends
do local v = appends[k];

local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

--- Boss Spawns


--Spawns heart pickup OR chest in hidden area
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2769" pos_y="9113" just_load_an_entity="mods/Apotheosis/files/entities/spawners/loot_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3498" pos_y="8948" just_load_an_entity="mods/Apotheosis/files/entities/spawners/loot_spawner.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

--Blob Spawner
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2733" pos_y="8950" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2834" pos_y="8926" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3163" pos_y="9079" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3573" pos_y="9141" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

--Boss Blob Spawner
if ModIsEnabled("nightmare") then
    local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
        <PixelScene pos_x="4014" pos_y="9102" just_load_an_entity="data/entities/animals/gold_bosses/boss_blob/blob_titan.xml" />
    ]]))
    ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))
else
    local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
        <PixelScene pos_x="4014" pos_y="9102" just_load_an_entity="data/entities/animals/boss_blob/blob_titan.xml" />
    ]]))
    ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))
end

--Spawns Physics Mushroom
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3381" pos_y="9226" just_load_an_entity="data/entities/props/physics_fungus_big.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3090" pos_y="9175" just_load_an_entity="data/entities/props/physics_fungus_hugeish.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

end