dofile("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

--- Boss Spawns


--Spawns heart pickup OR chest in hidden area
local content = ModTextFileGetContent("mods/purgatory/files/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2758" pos_y="9688" just_load_an_entity="mods/Apotheosis/files/entities/spawners/loot_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3487" pos_y="9523" just_load_an_entity="mods/Apotheosis/files/entities/spawners/loot_spawner.xml" />
]]))
ModTextFileSetContent("mods/purgatory/files/biome/_pixel_scenes.xml", tostring(xml))

--Blob Spawner
local content = ModTextFileGetContent("mods/purgatory/files/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2722" pos_y="9525" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2823" pos_y="9501" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3152" pos_y="9654" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3562" pos_y="9716" just_load_an_entity="mods/Apotheosis/files/entities/spawners/blobcave_spawner.xml" />
]]))
ModTextFileSetContent("mods/purgatory/files/biome/_pixel_scenes.xml", tostring(xml))

--Boss Blob Spawner
local content = ModTextFileGetContent("mods/purgatory/files/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="4003" pos_y="9677" just_load_an_entity="data/entities/animals/gold_bosses/boss_blob/blob_titan.xml" />
]]))
ModTextFileSetContent("mods/purgatory/files/biome/_pixel_scenes.xml", tostring(xml))

--Spawns Physics Mushroom
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3370" pos_y="9226" just_load_an_entity="data/entities/props/physics_fungus_big.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3120" pos_y="9175" just_load_an_entity="data/entities/props/physics_fungus_hugeish.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))
