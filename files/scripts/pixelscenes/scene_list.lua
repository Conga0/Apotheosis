
local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
local appends = {"_pixel_scenes","_pixel_scenes_newgame_plus",}
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

--Conga 20/06/2023: This could be SO optimised
--Why are we setting and getting the content over and over again when we're just adding new xml childs anyways?

for k=1, #appends
do local v = appends[k];

  --Wand Tinkering Crystal guaranteed spawn
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="10868" pos_y="-150" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png"
      background_filename=""
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Wand Tinkering Crystal guaranteed spawn (PW East)
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
  <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="]],(10868 + worldsize),[[" pos_y="-150" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png"
      background_filename=""
      colors_filename=""
  ></PixelScene>
  ]]})))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Wand Tinkering Crystal guaranteed spawn (PW West)
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
  <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="]],(10868 - worldsize),[[" pos_y="-150" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png"
      background_filename=""
      colors_filename=""
  ></PixelScene>
  ]]})))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Hisii Beggar Hint
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="23729" pos_y="-1637" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar_background.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --2nd Hisii Beggar Hint inside the south-west gold room
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-14140" pos_y="16819" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar_background.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Wand Cave Secret
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="20255" pos_y="-4376" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/wand_cave/wand_cave.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/wand_cave/wand_cave_background.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Blob Cave Arena
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="2520" pos_y="8777" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_1_1.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_1_bg.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="2939" pos_y="8777" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_1_2.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="3358" pos_y="8777" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_2_1.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_2_bg.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="3777" pos_y="8777" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_2_2.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --End the chaos here please




  --Just Kidding
  --Statue Room Gold banner, if you 100% the trophy room

  local apotheosis_angel_dead = HasFlagPersistent( "apotheosis_card_unlocked_divinebeing" )
  local apotheosis_worm_dead = HasFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm" )
  local apotheosis_music_dead = HasFlagPersistent( "apotheosis_card_unlocked_musical_boss" )
  local apotheosis_blob_dead = HasFlagPersistent( "apotheosis_card_unlocked_blob_boss" )
  local apotheosis_divine_created = HasFlagPersistent( "apotheosis_card_unlocked_divine_liquid" )
  local apotheosis_donated_beggar = HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar" )
  local apotheosis_enrage_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_rage_aura" )
  local apotheosis_cat_secret_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_cat_secret" )

  --1.1.0 unlocks
  local apotheosis_essence_fungus = HasFlagPersistent( "apotheosis_card_unlocked_essence_fungus" )
  local apotheosis_essence_fungus_moon = HasFlagPersistent( "apotheosis_moon_fungus_unlock" )
  local apotheosis_pandora_rain = HasFlagPersistent( "apotheosis_misc_pandora_chest_rain" )
  local apotheosis_fire_lukki_dead = HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki" )

  if apotheosis_angel_dead and apotheosis_worm_dead and apotheosis_music_dead and apotheosis_blob_dead and apotheosis_divine_created and apotheosis_donated_beggar and apotheosis_enrage_unlocked and apotheosis_cat_secret_unlocked and apotheosis_essence_fungus and apotheosis_essence_fungus_moon and apotheosis_pandora_rain and apotheosis_fire_lukki_dead then

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="4032" pos_y="1988" skip_biome_checks="1" skip_edge_textures="0"
        material_filename="mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room.png"
        background_filename="mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room_background_goldbanner.png"
        colors_filename=""
      ></PixelScene>
    ]]))
    ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  else

    --Statue Room, shows which bosses you've killed
    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="4032" pos_y="1988" skip_biome_checks="1" skip_edge_textures="0"
        material_filename="mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room.png"
        background_filename="mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room_background.png"
        colors_filename=""
      ></PixelScene>
    ]]))
    ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  end

  --Statue Spawner
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="4032" pos_y="1988" just_load_an_entity="mods/Apotheosis/files/scripts/biomes/boss_spawns/statue_room_populator_entity.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))




  -- 1.1.0 CONTENT BELOW ----------------------------------------------------------------------------------------------------------------------------------------------------




  --Essence of Fungus



  --Fire Lukki Portal Room
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-8739" pos_y="16381" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/portal_room_fire_lukki/portal_room_fire_lukki.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/portal_room_fire_lukki/portal_room_fire_lukki_background.png"
      colors_filename="mods/Apotheosis/files/pixel_scenes/portal_room_fire_lukki/portal_room_fire_lukki_visual.png"
    ></PixelScene>
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8624" pos_y="16547" just_load_an_entity="mods/Apotheosis/files/entities/buildings/portal_fire_lukki_musicstone.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8337" pos_y="16554" just_load_an_entity="mods/Apotheosis/files/entities/buildings/portal_fire_lukki_lavalake.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8648" pos_y="16708" just_load_an_entity="mods/Apotheosis/files/entities/buildings/portal_fire_lukki_tower.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8344" pos_y="16711" just_load_an_entity="mods/Apotheosis/files/entities/buildings/portal_fire_lukki_dragoncave.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8480" pos_y="16906" just_load_an_entity="data/entities/buildings/hourglass_music.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8480" pos_y="16906" just_load_an_entity="mods/Apotheosis/files/entities/buildings/divine_knowledge_particles.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8484" pos_y="16913" just_load_an_entity="mods/Apotheosis/files/entities/buildings/divine_knowledge_check.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8539" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/alchemy_centipede_blood.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8484" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/alchemy_redsand.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8429" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/alchemy_insecthusk.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8544" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/boss_toxic_worm.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8509" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/boss_fire_lukki.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8459" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/boss_musical_boss.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="-8424" pos_y="16843" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/boss_blob_titan.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="2239" pos_y="2165" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_pinksand.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="2343" pos_y="2165" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_centipede_blood.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="12020" pos_y="6920" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_insecthusk.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="11920" pos_y="6920" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_divineliquid.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="3916" pos_y="9110" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_redsand.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
      <PixelScene pos_x="4022" pos_y="9110" just_load_an_entity="mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_fungus.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Portal Offset amounts from pixelscene origin in top left
  --115,166 Music Stone         402,173 Lava lake
  --
  --91,327 Tower                395,330 Dragon Cave
  --
  -- Toxic Worm----Divine Being----Fire Lukki----Abandoned Orchestra----Blob Boss
  --
  --
  --Music Stone
  --Lava Lake
  --Tower
  --Dragon Cave

  --Red Sand Hint
  --local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  --local xml = nxml.parse(content)
  --xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
  --  <PixelScene pos_x="3390" pos_y="8957" just_load_an_entity="mods/Apotheosis/files/entities/props/hiddenmessage_redsand.xml" />
  --]]))
  --ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Hiisi Beggar Hint Glyph
  --local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  --local xml = nxml.parse(content)
  --xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
  --  <PixelScene pos_x="12026" pos_y="7104" just_load_an_entity="mods/Apotheosis/files/entities/props/hiddenmessage_hobo_glyph.xml" />
  --]]))
  --ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))


  --Apotheosis Pixelscenes below ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  --Allows you to input the mana core to make a portal to the Core Mines (On second thought.. mana core, core mines, too punny)
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="28" pos_y="3196" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/snowcave/lava_nest.png"
      background_filename="mods/Apotheosis/files/biome_impl/snowcave/lava_nest_background.png"
      colors_filename="mods/Apotheosis/files/biome_impl/snowcave/lava_nest_visual.png"
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="66" pos_y="3231" just_load_an_entity="mods/Apotheosis/files/entities/buildings/lava_nest.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Safe entrance in the Core Mines
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-21519" pos_y="3036" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/lava_excavation/intro.png"
      background_filename=""
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Music Altar in Core Mines
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-19211" pos_y="3283" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/musicspot.png"
      background_filename=""
      colors_filename="mods/Apotheosis/files/biome_impl/musicspot_visual.png"
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --offset from pixelscene by:
  -- x +80
  -- y +80
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-19131" pos_y="3363" just_load_an_entity="mods/Apotheosis/files/entities/buildings/musichints/hint_coremines.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))



  --Music Altar in Sunken Cavern
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-20936" pos_y="7689" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/musicspot.png"
      background_filename=""
      colors_filename="mods/Apotheosis/files/biome_impl/musicspot_visual.png"
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --offset from pixelscene by:
  -- x +80
  -- y +80
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-20856" pos_y="7769" just_load_an_entity="mods/Apotheosis/files/entities/buildings/musichints/hint_sunkencavern.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))



  --Music Altar in Sink Hole
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="18334" pos_y="2422" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/musicspot.png"
      background_filename=""
      colors_filename="mods/Apotheosis/files/biome_impl/musicspot_visual.png"
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --offset from pixelscene by:
  -- x +80
  -- y +80
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="18414" pos_y="2502" just_load_an_entity="mods/Apotheosis/files/entities/buildings/musichints/hint_sinkhole.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))



  --Music Altar above the tree
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-1580" pos_y="-2200" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/musicspot.png"
      background_filename=""
      colors_filename="mods/Apotheosis/files/biome_impl/musicspot_visual.png"
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --offset from pixelscene by:
  -- x +80
  -- y +80
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-1500" pos_y="-2120" just_load_an_entity="mods/Apotheosis/files/entities/buildings/musichints/hint_tree.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))


--Music Altar in Ant Hell
local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
  <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-3316" pos_y="5711" skip_biome_checks="1" skip_edge_textures="0"
    material_filename="mods/Apotheosis/files/biome_impl/musicspot.png"
    background_filename=""
    colors_filename="mods/Apotheosis/files/biome_impl/musicspot_visual.png"
  ></PixelScene>
]]))
ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

--offset from pixelscene by:
-- x +80
-- y +80
local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
local xml = nxml.parse(content)
xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
  <PixelScene pos_x="-3236" pos_y="5791" just_load_an_entity="mods/Apotheosis/files/entities/buildings/musichints/hint_anthell.xml" />
]]))
ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))


  --Alchemy Notes in Ant Hell
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-17340" pos_y="3765" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_entry.png"
      background_filename="mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_entry_background.png"
      colors_filename="mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_entry_visual.png"
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Teleporter Path Hints
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="8787" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_mines.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="8403" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_excavation_site.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="8013" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_snowy_depths.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="7468" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_hiisi_base.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="6406" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_jungle.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="5896" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_vault.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="9740" pos_y="5397" just_load_an_entity="mods/Apotheosis/files/entities/props/background/teleport_puzzle_crypt.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --True Gods Message
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-17150" pos_y="4292" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/pixel_scenes/true_gods/true_gods.png"
      background_filename="mods/Apotheosis/files/pixel_scenes/true_gods/true_gods_background.png"
      colors_filename=""
    ></PixelScene>
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --RealQuest Grave
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
  <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="4660" pos_y="-100" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/forest/realquest.png"
      background_filename=""
      colors_filename="mods/Apotheosis/files/biome_impl/forest/realquest_visual.png"
  ></PixelScene>
  ]]})))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="4863" pos_y="260" just_load_an_entity="data/entities/props/physics_skull_03.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="4863" pos_y="255" just_load_an_entity="data/entities/props/physics_bone_01.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="4883" pos_y="260" just_load_an_entity="mods/apotheosis/files/entities/items/books/book_realquest.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="4843" pos_y="260" just_load_an_entity="mods/apotheosis/files/entities/items/books/book_realquest_alt.xml" />
  ]]))

  
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
  <PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="-17860" pos_y="-100" skip_biome_checks="1" skip_edge_textures="0"
      material_filename="mods/Apotheosis/files/biome_impl/forest/realquest.png"
      background_filename=""
      colors_filename="mods/Apotheosis/files/biome_impl/forest/realquest_visual.png"
  ></PixelScene>
  ]]})))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-17657" pos_y="260" just_load_an_entity="data/entities/props/physics_skull_03.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-17657" pos_y="255" just_load_an_entity="data/entities/props/physics_bone_01.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-17677" pos_y="260" just_load_an_entity="mods/apotheosis/files/entities/items/books/book_realquest_tale.xml" />
  ]]))
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-12472" pos_y="197" just_load_an_entity="mods/apotheosis/files/entities/items/pickups/fishing_rod.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

  --Fixing Music Machines not spawning in PWs properly
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_children(nxml.parse_many([[
    <PixelScene pos_x="14698" pos_y="-90" just_load_an_entity="data/entities/props/music_machines/music_machine_00.xml" />
    <PixelScene pos_x="]] .. (10868 + worldsize)  .. [[" pos_y="-90" just_load_an_entity="data/entities/props/music_machines/music_machine_00.xml" />
    <PixelScene pos_x="]] .. (10868 - worldsize)  .. [[" pos_y="-90" just_load_an_entity="data/entities/props/music_machines/music_machine_00.xml" />

    <PixelScene pos_x="-1905" pos_y="-1412" just_load_an_entity="data/entities/props/music_machines/music_machine_01.xml" />
    <PixelScene pos_x="]] .. (-1905 + worldsize)  .. [[" pos_y="-1412" just_load_an_entity="data/entities/props/music_machines/music_machine_01.xml" />
    <PixelScene pos_x="]] .. (-1905 - worldsize)  .. [[" pos_y="-1412" just_load_an_entity="data/entities/props/music_machines/music_machine_01.xml" />

    <PixelScene pos_x="24166" pos_y="-421" just_load_an_entity="data/entities/props/music_machines/music_machine_02.xml" />
    <PixelScene pos_x="]] .. (24166 + worldsize)  .. [[" pos_y="-421" just_load_an_entity="data/entities/props/music_machines/music_machine_02.xml" />
    <PixelScene pos_x="]] .. (24166 - worldsize)  .. [[" pos_y="-421" just_load_an_entity="data/entities/props/music_machines/music_machine_02.xml" />

    <PixelScene pos_x="2800" pos_y="250" just_load_an_entity="data/entities/props/music_machines/music_machine_03.xml" />
    <PixelScene pos_x="]] .. (2800 + worldsize)  .. [[" pos_y="-550" just_load_an_entity="data/entities/props/music_machines/music_machine_03.xml" />
    <PixelScene pos_x="]] .. (2800 - worldsize)  .. [[" pos_y="-550" just_load_an_entity="data/entities/props/music_machines/music_machine_03.xml" />
  ]]))

  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))

do  --Spawn Forest Monolith
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="-19100" pos_y="-160" just_load_an_entity="mods/apotheosis/files/entities/buildings/forest_monolith_spawner.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))
end


if HasFlagPersistent("apotheosis_tablet_ghost_encounter") == false and HasFlagPersistent("apotheosis_card_unlocked_fire_lukki") == true then --Guarantee tablet hint ghost encounter after killing fire lukki
  local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
  local xml = nxml.parse(content)
  xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
    <PixelScene pos_x="195" pos_y="6678" just_load_an_entity="data/entities/animals/playerghost_apotheosis/temp/playerghost_spawner.xml" />
  ]]))
  ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))
end



--local content = ModTextFileGetContent("data/biome/" .. v .. ".xml")
--local xml = nxml.parse(content)
--xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse(table.concat({[[
--<PixelScene DEBUG_RELOAD_ME="0" clean_area_before="0" pos_x="23829" pos_y="79532" skip_biome_checks="1" skip_edge_textures="0"
--    material_filename="mods/Apotheosis/files/pixel_scenes/test_01/test_01.png"
--    background_filename="mods/Apotheosis/files/pixel_scenes/test_01/test_01_background.png"
--    colors_filename=""
--></PixelScene>
--]]})))
--ModTextFileSetContent("data/biome/" .. v .. ".xml", tostring(xml))


end
