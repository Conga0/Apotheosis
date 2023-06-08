local appends = {"_pixel_scenes","_pixel_scenes_newgame_plus",}
for k=1, #appends
do local v = appends[k];

--- Boss Spawns


--Spawns Toxic Worm boss after filling the dragon egg with toxic sludge
--This was the original intent, now the Toxic Worm spawns inside of a "nest" area of sorts with an egg, approach it and get got!
--local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
--local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
--local xml = nxml.parse(content)
--xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
--    <PixelScene pos_x="2292" pos_y="2286" just_load_an_entity="data/entities/buildings/toxic_worm_nest_populator.xml" />
--]]))
--ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))




--Spawns a Magic Devourer inside the Abandoned Alchemy Lab to show off its' gimmick, only one though, and the only one with cell eater capabilities in the entire game!
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-2484" pos_y="764" just_load_an_entity="data/entities/buildings/devourer_magic_liquidcave_populator.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns a wand editting crystal inside the pyramid, this will provide people incentive to go there and wander around the actual pyramid part for a bit before rushing either the boss or the orb.
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="11036" pos_y="-26" just_load_an_entity="data/entities/buildings/wandedit_crystal.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))


--local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
--local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
--local xml = nxml.parse(content)
--xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
--    <PixelScene pos_x="11062" pos_y="-80" just_load_an_entity="data/entities/buildings/pyramid_wandedit_crystal_book_populator.xml" />
--]]))
--ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Deletes polymorph crystal surrounding the entrance to the Temple of the Art. Wouldn't want to get cockblocked by a poly crystal covering the entrance and a tentacler camping right behind the wall.
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="191" pos_y="10699" just_load_an_entity="data/entities/buildings/polymorphcrystal_deleter.xml" />
]]))

--Same as above but other biomes
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="191" pos_y="1440" just_load_an_entity="data/entities/buildings/polymorphcrystal_deleter.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="191" pos_y="2698" just_load_an_entity="data/entities/buildings/polymorphcrystal_deleter.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="191" pos_y="5037" just_load_an_entity="data/entities/buildings/polymorphcrystal_deleter.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="191" pos_y="6582" just_load_an_entity="data/entities/buildings/polymorphcrystal_deleter.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="191" pos_y="8664" just_load_an_entity="data/entities/buildings/polymorphcrystal_deleter.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns a Hisii Beggar near the essence of earth, hopefully demonstrates or at least hints towards how to interact with them
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="23906" pos_y="-1600" just_load_an_entity="data/entities/buildings/hisii_beggar_populator.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns Wand of Wonders & Pouch inside the wand cave
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="20380" pos_y="-4202" just_load_an_entity="data/entities/buildings/wand_cave_populator.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns Kitty Cats at the start of the game, Cat, I'm a Kitty Cat! And I dance dance dance and I dance dance dance!! Nyaaa!!
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="676" pos_y="-106" just_load_an_entity="data/entities/buildings/intro_kitty_populator.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns Kitty Cats at the end of the game.. It's been a long journey, best of luck, friend.
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3053" pos_y="13113" just_load_an_entity="data/entities/buildings/outro_kitty_populator.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns a book hinting towards Materia Converting Fungal Shift
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2515" pos_y="7428" just_load_an_entity="data/entities/buildings/materia_conversion_book_spawner.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns a book hinting towards the Trophy Room Location
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-1167" pos_y="-1350" just_load_an_entity="mods/Apotheosis/files/entities/items/books/book_trophy_room.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))



--Spawns a book hinting towards which spells to use Mass Materia Conversion on
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-3810" pos_y="4914" just_load_an_entity="data/entities/buildings/materia_conversion_spell_book_spawner.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))
 


--Spawns a book hinting towards luring a cat to the Rat Wand
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="4000" pos_y="3520" just_load_an_entity="mods/Apotheosis/files/entities/items/books/book_cat_rat.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))
 


--Spawns a book hinting instructing how to make mud men
--local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
--local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
--local xml = nxml.parse(content)
--xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
--    <PixelScene pos_x="4000" pos_y="3520" just_load_an_entity="mods/Apotheosis/files/entities/items/books/book_mudman.xml" />
--]]))
--ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))
 

 


----Sets up the Trophy Room for spawning
--local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
--local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
--local xml = nxml.parse(content)
--xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
--    <PixelScene pos_x="227" pos_y="-93" just_load_an_entity="data/entities/buildings/pride_statue_room_injector.xml" />
--]]))
--ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))


--1.1.0 content

--Boss Spawns


--Spawns Asthete of Heat if you throw brimstone into the lava lake
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2631" pos_y="984" just_load_an_entity="mods/Apotheosis/files/entities/buildings/fire_lukki_brimstone_detector.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="2841" pos_y="984" just_load_an_entity="mods/Apotheosis/files/entities/buildings/fire_lukki_brimstone_detector.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="3046" pos_y="984" just_load_an_entity="mods/Apotheosis/files/entities/buildings/fire_lukki_brimstone_detector.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

 
--Spawns a book hinting towards bringing a brimstone to the Lava Lake
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
--This Locations for it to spawn inside Hiisi secret shop
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="1728" pos_y="5522" just_load_an_entity="mods/Apotheosis/files/entities/buildings/fire_lukki_book_spawner_stoneonly.xml" />
]]))
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-2256" pos_y="5512" just_load_an_entity="mods/Apotheosis/files/entities/buildings/fire_lukki_book_spawner_stoneonly.xml" />
]]))
--This location is inside the Lake bunker
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-12530" pos_y="394" just_load_an_entity="mods/Apotheosis/files/entities/buildings/fire_lukki_book_spawner.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

 
--Spawns Volcanic Chest inside the Asthete of Heat's portal room containing RGB portal spells
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-8500" pos_y="16752" just_load_an_entity="mods/Apotheosis/files/entities/items/pickups/chest_volcanic.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

 
--Spawns A guaranteed locust swarm in the desert, weaker than usual but makes bonus insect husk
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9697" pos_y="-141" just_load_an_entity="data/entities/animals/secret/locust_swarm.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

 
--Spawns A guaranteed juvenile centipede in the east PW jungle
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="35529" pos_y="6603" just_load_an_entity="data/entities/animals/giant_centipede.xml" />
]]))
ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

end