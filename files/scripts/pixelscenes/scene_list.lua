local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
local files_to_append = { "data/biome/_pixel_scenes.xml", "data/biome/_pixel_scenes_newgame_plus.xml" }
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua") ---@type nxml

--Conga 20/06/2023: This could be SO optimised
--Why are we setting and getting the content over and over again when we're just adding new xml childs anyways?
--Lamia 22/04/2024: Jesus Christ guys

local unlocks = {
	"apotheosis_card_unlocked_divinebeing",
	"apotheosis_card_unlocked_boss_toxic_worm",
	"apotheosis_card_unlocked_musical_boss",
	"apotheosis_card_unlocked_blob_boss",
	"apotheosis_card_unlocked_divine_liquid",
	"apotheosis_card_unlocked_donated_beggar",
	"apotheosis_card_unlocked_rage_aura",
	"apotheosis_card_unlocked_cat_secret",

	--1.1.0 unlocks
	"apotheosis_card_unlocked_essence_fungus",
	"apotheosis_moon_fungus_unlock",
	"apotheosis_misc_pandora_chest_rain",
	"apotheosis_card_unlocked_fire_lukki",
}

local all_unlocks_unlocked = true
for i = 1, #unlocks do
	if not HasFlagPersistent(unlocks[i]) then
		all_unlocks_unlocked = false
		break
	end
end

local new_scenes = {
	--Wand Tinkering Crystal guaranteed spawn
	{
		pos_x = 10868,
		pos_y = -150,
		material_filename = "mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Wand Tinkering Crystal guaranteed spawn (PW East)
	{
		pos_x = 10868 + worldsize,
		pos_y = -150,
		material_filename = "mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Wand Tinkering Crystal guaranteed spawn (PW West)
	{
		pos_x = 10868 - worldsize,
		pos_y = -150,
		material_filename = "mods/Apotheosis/files/pixel_scenes/pyramid_wand_crystal/pyramid_wand_crystal.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Ceasement Spawn Location
	{
		pos_x = 8455,
		pos_y = 240,
		material_filename = "mods/Apotheosis/files/biome_impl/no_gold.png",
		background_filename = "mods/Apotheosis/files/biome_impl/no_gold_background.png",
		--colors_filename = "mods/Apotheosis/files/biome_impl/no_gold_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Ceasement Entity
	{
		pos_x = 8561,
		pos_y = 356,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/no_gold_check.xml",
	},
	--Hisii Beggar Hint
	{
		pos_x = 23729,
		pos_y = -1637,
		material_filename = "mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar_background.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--2nd Hisii Beggar Hint inside the south-west gold room
	{
		pos_x = -14140,
		pos_y = 16819,
		material_filename = "mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/hisii_beggar/hisii_beggar_background.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Wand Cave Secret
	{
		pos_x = 20255,
		pos_y = -4376,
		material_filename = "mods/Apotheosis/files/pixel_scenes/wand_cave/wand_cave.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/wand_cave/wand_cave_background.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Blob Cave Arena
	{
		pos_x = 2520,
		pos_y = 8777,
		material_filename = "mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_1_1.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_1_bg.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = 2939,
		pos_y = 8777,
		material_filename = "mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_1_2.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = 3358,
		pos_y = 8777,
		material_filename = "mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_2_1.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_2_bg.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = 3777,
		pos_y = 8777,
		material_filename = "mods/Apotheosis/files/pixel_scenes/blob_cavern/blob_cavern_2_2.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},

	--End the chaos here please (ok)

	--Just Kidding
	--Statue Room Gold banner, if you 100% the trophy room

	--Statue Room, shows which bosses you've killed
	{
		pos_x = 4032,
		pos_y = 1988,
		material_filename = "mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room.png",
		background_filename = all_unlocks_unlocked and "mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room_background_goldbanner.png"
			or "mods/Apotheosis/files/pixel_scenes/pride_statues/statue_room_background.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Statue Spawner
	{
		pos_x = 4032,
		pos_y = 1988,
		just_load_an_entity = "mods/Apotheosis/files/scripts/biomes/boss_spawns/statue_room_populator_entity.xml",
	},

	-- 1.1.0 CONTENT BELOW ----------------------------------------------------------------------------------------------------------------------------------------------------

	--Essence of Fungus

	--Fire Lukki Portal Room
	{
		pos_x = -8739,
		pos_y = 16381,
		material_filename = "mods/Apotheosis/files/pixel_scenes/portal_room_fire_lukki/portal_room_fire_lukki.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/portal_room_fire_lukki/portal_room_fire_lukki_background.png",
		colors_filename = "mods/Apotheosis/files/pixel_scenes/portal_room_fire_lukki/portal_room_fire_lukki_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = -8624,
		pos_y = 16547,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_musicstone.xml",
	},
	{
		pos_x = -8337,
		pos_y = 16554,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_lavalake.xml",
	},
	{
		pos_x = -8648,
		pos_y = 16708,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_tower.xml",
	},
	{
		pos_x = -8344,
		pos_y = 16711,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_dragoncave.xml",
	},
	{
		pos_x = -8480,
		pos_y = 16906,
		just_load_an_entity = "data/entities/buildings/hourglass_music.xml",
	},
	{
		pos_x = -8480,
		pos_y = 16906,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/divine_knowledge_particles.xml",
	},
	{
		pos_x = -8484,
		pos_y = 16913,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/divine_knowledge_check.xml",
	},
	{
		pos_x = -8539,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/alchemy_centipede_blood.xml",
	},
	{
		pos_x = -8484,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/alchemy_redsand.xml",
	},
	{
		pos_x = -8429,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/alchemy_insecthusk.xml",
	},
	{
		pos_x = -8544,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/boss_toxic_worm.xml",
	},
	{
		pos_x = -8509,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/boss_fire_lukki.xml",
	},
	{
		pos_x = -8459,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/boss_musical_boss.xml",
	},
	{
		pos_x = -8424,
		pos_y = 16843,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/boss_blob_titan.xml",
	},
	{
		pos_x = 2239,
		pos_y = 2165,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_pinksand.xml",
	},
	{
		pos_x = 2343,
		pos_y = 2165,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_centipede_blood.xml",
	},
	{
		pos_x = 12020,
		pos_y = 6920,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_insecthusk.xml",
	},
	{
		pos_x = 11920,
		pos_y = 6920,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_divineliquid.xml",
	},
	{
		pos_x = 3916,
		pos_y = 9110,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_redsand.xml",
	},
	{
		pos_x = 4022,
		pos_y = 9110,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/alchemy/hidden/alchemy_fungus.xml",
	},

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
	{
		pos_x = 28,
		pos_y = 3196,
		material_filename = "mods/Apotheosis/files/biome_impl/snowcave/lava_nest.png",
		background_filename = "mods/Apotheosis/files/biome_impl/snowcave/lava_nest_background.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/snowcave/lava_nest_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = 66,
		pos_y = 3231,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/lava_nest.xml",
	},
	--Safe entrance in the Core Mines
	{
		pos_x = -21519,
		pos_y = 3036,
		material_filename = "mods/Apotheosis/files/biome_impl/lava_excavation/intro.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Music Altar in Core Mines
	{
		pos_x = -19211,
		pos_y = 3283,
		material_filename = "mods/Apotheosis/files/biome_impl/musicspot.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/musicspot_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},

	--offset from pixelscene by:
	-- x +80
	-- y +80
	{
		pos_x = -19131,
		pos_y = 3363,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/musichints/hint_coremines.xml",
	},

	--Music Altar in Sunken Cavern
	{
		pos_x = -20936,
		pos_y = 7689,
		material_filename = "mods/Apotheosis/files/biome_impl/musicspot.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/musicspot_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},

	--offset from pixelscene by:
	-- x +80
	-- y +80
	{
		pos_x = -20856,
		pos_y = 7769,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/musichints/hint_sunkencavern.xml",
	},
	--Music Altar in Sink Hole
	{
		pos_x = 18334,
		pos_y = 2422,
		material_filename = "mods/Apotheosis/files/biome_impl/musicspot.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/musicspot_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--offset from pixelscene by:
	-- x +80
	-- y +80
	{
		pos_x = 18414,
		pos_y = 2502,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/musichints/hint_sinkhole.xml",
	},
	--Music Altar above the tree
	{
		pos_x = -1580,
		pos_y = -2200,
		material_filename = "mods/Apotheosis/files/biome_impl/musicspot.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/musicspot_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--offset from pixelscene by:
	-- x +80
	-- y +80
	{
		pos_x = -1500,
		pos_y = -2120,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/musichints/hint_tree.xml",
	},
	--Music Altar in Ant Hell
	{
		pos_x = -3316,
		pos_y = 5711,
		material_filename = "mods/Apotheosis/files/biome_impl/musicspot.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/musicspot_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--offset from pixelscene by:
	-- x +80
	-- y +80
	{
		pos_x = -3236,
		pos_y = 5791,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/musichints/hint_anthell.xml",
	},
	--Alchemy Notes in Ant Hell
	{
		pos_x = -17340,
		pos_y = 3765,
		material_filename = "mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_entry.png",
		background_filename = "mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_entry_background.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_entry_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	--Teleporter Path Hints
	{
		pos_x = 9740,
		pos_y = 8787,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_mines.xml",
	},
	{
		pos_x = 9740,
		pos_y = 8403,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_excavation_site.xml",
	},
	{
		pos_x = 9740,
		pos_y = 8013,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_snowy_depths.xml",
	},
	{
		pos_x = 9740,
		pos_y = 7468,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_hiisi_base.xml",
	},
	{
		pos_x = 9740,
		pos_y = 6406,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_jungle.xml",
	},
	{
		pos_x = 9740,
		pos_y = 5896,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_vault.xml",
	},
	{
		pos_x = 9740,
		pos_y = 5397,
		just_load_an_entity = "mods/Apotheosis/files/entities/props/background/teleport_puzzle_crypt.xml",
	},
	--True Gods Message
	{
		pos_x = -17150,
		pos_y = 4292,
		material_filename = "mods/Apotheosis/files/pixel_scenes/true_gods/true_gods.png",
		background_filename = "mods/Apotheosis/files/pixel_scenes/true_gods/true_gods_background.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},

	--Spell Machine
	--[[
	{
		pos_x = -2920,
		pos_y = 10000,
		material_filename = "mods/Apotheosis/files/biome_impl/vault/spell_machine.png",
		--background_filename = "mods/Apotheosis/files/pixel_scenes/true_gods/true_gods_background.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	]]--

	--RealQuest Grave
	{
		pos_x = 4660,
		pos_y = -100,
		material_filename = "mods/Apotheosis/files/biome_impl/forest/realquest.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/forest/realquest_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = 4863,
		pos_y = 260,
		just_load_an_entity = "data/entities/props/physics_skull_03.xml",
	},
	{
		pos_x = 4863,
		pos_y = 255,
		just_load_an_entity = "data/entities/props/physics_bone_01.xml",
	},
	{
		pos_x = 4883,
		pos_y = 260,
		just_load_an_entity = "mods/Apotheosis/files/entities/items/books/book_realquest.xml",
	},
	{
		pos_x = 4843,
		pos_y = 260,
		just_load_an_entity = "mods/Apotheosis/files/entities/items/books/book_realquest_alt.xml",
	},
	{
		pos_x = 4800,
		pos_y = -120,
		just_load_an_entity = "mods/Apotheosis/files/entities/spawners/wolf_spawner.xml",
	},
	{
		pos_x = 4750,
		pos_y = -120,
		just_load_an_entity = "mods/Apotheosis/files/entities/spawners/wolf_spawner.xml",
	},
	{
		pos_x = 4850,
		pos_y = -120,
		just_load_an_entity = "mods/Apotheosis/files/entities/spawners/wolf_spawner.xml",
	},
	{
		pos_x = -17860,
		pos_y = -100,
		material_filename = "mods/Apotheosis/files/biome_impl/forest/realquest.png",
		colors_filename = "mods/Apotheosis/files/biome_impl/forest/realquest_visual.png",
		skip_biome_checks = true,
		skip_edge_textures = false,
	},
	{
		pos_x = -17657,
		pos_y = 260,
		just_load_an_entity = "data/entities/props/physics_skull_03.xml",
	},
	{
		pos_x = -17657,
		pos_y = 255,
		just_load_an_entity = "data/entities/props/physics_bone_01.xml",
	},
	{
		pos_x = -17677,
		pos_y = 260,
		just_load_an_entity = "mods/Apotheosis/files/entities/items/books/book_realquest_tale.xml",
	},
	{
		pos_x = -12472,
		pos_y = 197,
		just_load_an_entity = "mods/Apotheosis/files/entities/items/pickups/fishing_rod.xml",
	},
	--Fixing Music Machines not spawning in PWs properly
	{
		pos_x = 14698,
		pos_y = -90,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_00.xml",
	},
	{
		pos_x = 14698 + worldsize,
		pos_y = -90,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_00.xml",
	},
	{
		pos_x = 14698 - worldsize,
		pos_y = -90,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_00.xml",
	},
	{
		pos_x = -1905,
		pos_y = -1412,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_01.xml",
	},
	{
		pos_x = -1905 + worldsize,
		pos_y = -1412,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_01.xml",
	},
	{
		pos_x = -1905 - worldsize,
		pos_y = -1412,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_01.xml",
	},
	{
		pos_x = -12187 + worldsize,
		pos_y = -421,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_02.xml",
	},
	{
		pos_x = -12187 - worldsize,
		pos_y = -421,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_02.xml",
	},
	{
		pos_x = 2800,
		pos_y = 250,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_03.xml",
	},
	{
		pos_x = 2800 + worldsize,
		pos_y = -550,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_03.xml",
	},
	{
		pos_x = 2800 - worldsize,
		pos_y = -550,
		just_load_an_entity = "data/entities/props/music_machines/music_machine_03.xml",
	},

	--Spawn Forest Monolith
	{
		pos_x = -19100,
		pos_y = -160,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/forest_monolith_spawner.xml",
	},

	--Spawn Whisp Shrine
	{
		pos_x = 3275,
		pos_y = -120,
		just_load_an_entity = "mods/Apotheosis/files/entities/buildings/shrine_puzzle_whisp_spawner.xml",
	},

	--Spawn Magic Fountain
	{
		pos_x = 2925,
		pos_y = 12335,
		just_load_an_entity = "mods/Apotheosis/files/entities/spawners/magic_fountain_spawner.xml",
	},

	--Christmas Lights
	--Starting Mountain
	{
		pos_x = 470,
		pos_y = -105,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},
	--Pyramid Greed Room
	{
		pos_x = 8560,
		pos_y = 330,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},
	--Lake Cabin
	{
		pos_x = -12438,
		pos_y = 187,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},
	--Tree
	{
		pos_x = -1540,
		pos_y = -760,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},
	{
		pos_x = -1600,
		pos_y = -760,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},
	{
		pos_x = -1620,
		pos_y = -760,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},
	{
		pos_x = -1730,
		pos_y = -760,
		just_load_an_entity = is_holiday_active("smissmass") and "mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml" or "",
	},

	-- {
	-- 	pos_x = 23829,
	-- 	pos_y = 79532,
	-- 	material_filename = "mods/Apotheosis/files/pixel_scenes/test_01/test_01.png",
	-- 	background_filename = "mods/Apotheosis/files/pixel_scenes/test_01/test_01_background.png",
	-- 	skip_biome_checks = true,
	-- 	skip_edge_textures = false,
	-- },
}

--Guarantee tablet hint ghost encounter after killing fire lukki
if not HasFlagPersistent("apotheosis_tablet_ghost_encounter") and HasFlagPersistent("apotheosis_card_unlocked_fire_lukki") then
	new_scenes[#new_scenes + 1] = {
		pos_x = 195,
		pos_y = 6678,
		just_load_an_entity = "data/entities/animals/playerghost_apotheosis/temp/playerghost_spawner.xml",
	}
end

local ghost_pixel_positions = {
	{ 20892, 11400 },
	{ 19715, -4823 },
	{ -21032, -4000 },
	{ -6815, 16565 },
	{ 9377, 10002 },
	{ 23914, 22783 },
	{ 24634, 6886 },
	{ 7249, 3033, },
}

for k = 1, 5 do
	SetRandomSeed((k * 9) + 20, 392)
	local rng = Random(1, #ghost_pixel_positions)

	new_scenes[#new_scenes + 1] = {
		pos_x = ghost_pixel_positions[rng][1],
		pos_y = ghost_pixel_positions[rng][2],
		skip_biome_checks = true,
		skip_edge_textures = false,
		material_filename = "mods/Apotheosis/files/biome_impl/ghost_pixel.png",
		background_filename = string.format("mods/Apotheosis/files/props_gfx/symbols/starglyphs_0%d.png", k),
	}
	table.remove(ghost_pixel_positions, rng)
end

local new_scene_elements = {}
for i = 1, #new_scenes do
	new_scene_elements[#new_scene_elements + 1] = nxml.new_element("PixelScene", new_scenes[i])
end

for i = 1, #files_to_append do
	for xml in nxml.edit_file(files_to_append[i]) do
		local mbuffer = xml:first_of("mBufferedPixelScenes")
		if mbuffer then
			for j = 1, #new_scene_elements do
				mbuffer:add_child(new_scene_elements[j])
			end
		end
	end
end
