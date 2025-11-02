dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local apoth_version = "v1.4.0 Beta Branch"

--local modCompatibilityConjurer = ModSettingGet( "Apotheosis.mod_compat_mode_conjurer" )
local modCompatibilitySpellEvolutions = ModSettingGet("Apotheosis.mod_compat_mode_spell_evolution")
local motdSetting = ModSettingGet("Apotheosis.motd_setting")
local seasonalSetting = ModSettingGet("Apotheosis.seasonal_events")
local spoopyGFXSetting = ModSettingGet("Apotheosis.spoopy_graphics")

local experimental_biomemap = ModSettingGet("Apotheosis.exp_biomemap")

local capeSetting = ModSettingGet("Apotheosis.secret_golden_cape")

--Debug flag removals, be sure to remove before release!!!
--RemoveFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" )
--RemoveFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings_spell" )

--Spawn Bosses

--This was a coding marathon and a half, huge shoutouts to Horscht for the help on this one.
--And Zathers for making this lua file
--Note: This has been moved lower down for cleaner organisation & implementing mod compatibility
--Note: 16/06/2023 Some boss spawns may be moved into biome files as well

if ModIsEnabled("quant.ew") then
    ModLuaFileAppend("mods/quant.ew/files/api/extra_modules.lua", "mods/Apotheosis/files/scripts/mod_compatibility/entangled_alt_fire_fix.lua")
    ModLuaFileAppend("mods/quant.ew/files/api/global_perks.lua", "mods/Apotheosis/files/scripts/mod_compatibility/ew_global_perks.lua")
end

-- Spell Unlock Fixes
-- If someone attains a spell through another mod, twitch integration, etc, this is just to make sure they aren't getting unlocks they shouldn't.
-- They'll still get the spell, it just won't be added to their permanent record
-- Rat bite isn't "verified" because it's a funny spell

-- Protect spell progress in case of accidental unlocks
do
  for _, entry in ipairs({
    "divinebeing",
    "boss_toxic_worm",
    "musical_boss",
    "blob_boss",
    "fire_lukki",
    "boss_flesh_monster",
    "cat_secret",
    "orb_12",
    "orb_14",
    "orb_15",
    "orb_16",
    "lost_alchemy",
    "omega_cross",
	"support_bullet",
  }) do
    local progressflag = "apotheosis_card_unlocked_" .. entry
    if HasFlagPersistent( progressflag ) then
      AddFlagPersistent( progressflag .. "_spell" )
    else
      RemoveFlagPersistent( progressflag .. "_spell" )
    end
  end
end

--Ending Reward
if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02") then
	AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02_spell")
else
	RemoveFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02_spell")
end

--Ensure this flag is never enabled, so spells can properly be disabled in hardcore mode while still appearing in the progress log
RemoveFlagPersistent("this_should_never_spawn")











--Description fix for Ghostly Vision Perk
--Wow, I've come a long way since then.
--Thankyou for all the help, gamers!
--Thankyou Nathan for the cleaner translation implementation
local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/Apotheosis/translations.csv")
translations = translations .. "\n" .. new_translations .. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)

--Yggdrasil's Knowledge (The knowledge of life)
--
--Custom Spell Border for one-off spells would be sick
--
--Previous contact damage description
--perk_apotheosis_contactdamage_description,"You take no damage from close-range enemy attacks but enemies near you take damage; the damage is higher the lower your health gets.",,,,,,,,,,,,,




--Regular Spawns

ModLuaFileAppend("data/scripts/biomes/wizardcave.lua", "mods/Apotheosis/files/scripts/biomes/wizardcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/tower_end.lua", "mods/Apotheosis/files/scripts/biomes/tower_end_populator.lua")
ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/coalmine_populator.lua")
ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/the_end_populator.lua")
ModLuaFileAppend("data/scripts/biomes/desert.lua", "mods/Apotheosis/files/scripts/biomes/desert_populator.lua")

ModLuaFileAppend("data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/crypt_populator.lua")
ModLuaFileAppend("data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/pyramid_populator.lua")
ModLuaFileAppend("data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/fungicave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua","mods/Apotheosis/files/scripts/biomes/coalmine_alt_populator.lua")
ModLuaFileAppend("data/scripts/biomes/pyramid_hallway.lua","mods/Apotheosis/files/scripts/biomes/pyramid_hallway_populator.lua")
ModLuaFileAppend("data/scripts/biomes/liquidcave.lua", "mods/Apotheosis/files/scripts/biomes/liquidcave_populator.lua")


ModLuaFileAppend("data/scripts/biomes/snowcastle_cavern.lua", "mods/Apotheosis/files/scripts/biomes/hiisi_shop_populator.lua")


ModLuaFileAppend("data/scripts/biomes/excavationsite.lua","mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua")
ModLuaFileAppend("data/scripts/biomes/vault_frozen.lua","mods/Apotheosis/files/scripts/biomes/vault_frozen_populator.lua")
ModLuaFileAppend("data/scripts/biomes/fungiforest.lua", "mods/Apotheosis/files/scripts/biomes/fungiforest_populator.lua")
ModLuaFileAppend("data/scripts/biomes/snowcastle.lua", "mods/Apotheosis/files/scripts/biomes/snowcastle_populator.lua")
ModLuaFileAppend("data/scripts/biomes/snowcave.lua", "mods/Apotheosis/files/scripts/biomes/snowcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/wandcave.lua", "mods/Apotheosis/files/scripts/biomes/wandcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/meat.lua", "mods/Apotheosis/files/scripts/biomes/meat_populator.lua")
ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/sandcave_populator.lua")
ModLuaFileAppend("data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/vault_populator.lua")
--ModLuaFileAppend( "data/scripts/biomes/tower.lua", "mods/Apotheosis/files/scripts/biomes/tower_populator.lua" )
ModLuaFileAppend("data/scripts/biomes/rainforest.lua", "mods/Apotheosis/files/scripts/biomes/rainforest_populator.lua")   --Jungle
ModLuaFileAppend("data/scripts/biomes/rainforest_dark.lua","mods/Apotheosis/files/scripts/biomes/rainforest_dark_populator.lua")                                                 --Lukki Lair
ModLuaFileAppend("data/scripts/biomes/winter.lua", "mods/Apotheosis/files/scripts/biomes/winter_populator.lua")           --Snow Chasm
ModLuaFileAppend("data/scripts/biomes/clouds.lua", "mods/Apotheosis/files/scripts/biomes/clouds_populator.lua")           --Cloud Scape, for example coral chest area & essence of air area
ModLuaFileAppend("data/scripts/biomes/robobase.lua", "mods/Apotheosis/files/scripts/biomes/robobase_populator.lua")       --Power Plant
ModLuaFileAppend("data/scripts/biomes/lake_statue.lua", "mods/Apotheosis/files/scripts/biomes/lake_statue_populator.lua") --Lake Island
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/Apotheosis/files/scripts/biomes/hills_populator.lua")             --Hills and shallow caves
ModLuaFileAppend("data/scripts/biomes/robot_egg.lua", "mods/Apotheosis/files/scripts/biomes/robot_egg_populator.lua")     --End of Everything Robotic Egg

--Not looking quite as good as the statues, might need a different art approach
--ModLuaFileAppend( "data/scripts/biomes/mountain_tree.lua", "mods/Apotheosis/files/scripts/biomes/mountain_tree_populator.lua" ) --Treechievements


ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/actions.lua")

-- Could this be gsubbed?
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/Apotheosis/files/gun.lua")

dofile_once("mods/Apotheosis/lib/injection.lua")


inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "gl_FragColor.a = 1.0;",
	"mods/Apotheosis/files/scripts/shader/constellation_transition_white.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "varying vec2 tex_coord_fogofwar;",
	"mods/Apotheosis/files/scripts/shader/constellation_transition_global.frag")

GameSetPostFxParameter("conga_constellation_transition_amount", 0, 0, 0, 0)


inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "// liquid distortion",
	"mods/Apotheosis/files/scripts/shader/trip_red_pre.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "gl_FragColor",
	"mods/Apotheosis/files/scripts/shader/trip_red_post.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "varying vec2 tex_coord_fogofwar;",
	"mods/Apotheosis/files/scripts/shader/trip_red_global.frag")

GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)


inject(args.StringFile, modes.APPEND, "data/shaders/post_final.frag", "vec2 tex_coord_glow = tex_coord_glow_;",
	"mods/Apotheosis/files/scripts/shader/mind_warp_wavy.frag")
inject(args.StringFile, modes.APPEND, "data/shaders/post_final.frag", "gl_FragColor.a = 1.0;",
	"mods/Apotheosis/files/scripts/shader/mind_warp_red.frag")
inject(args.StringFile, modes.PREPEND, "data/shaders/post_final.frag", "varying vec2 tex_coord_fogofwar;",
	"mods/Apotheosis/files/scripts/shader/mind_warp_global.frag")

GameSetPostFxParameter("conga_mind_warp_effect_amount", 0, 0, 0, 0)

--Appends Global Spawns to vanilla biome
do -- Global Spawns
	--DO NOT INCLUDE ANYTHING TOWER RELATED HERE, they're... "special" and need to be done in their own unique way
	for _, append in ipairs({
		{ -- General
			script = "global_populator",
			biomes = {
				"wizardcave", --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
				"coalmine", --Coal Mine, first area, goodluck on your run
				"desert", --Desert above ground, careful not to die to any Stendari
				"crypt", --Temple of the Arts.. who died here?
				"pyramid", --Presumably everything below the entrance to the pyramid
				"fungicave", --BUNGUS!! cave, west side of area 2 for example
				"coalmine_alt", --Coalmine but to the west side near damp cave
				"pyramid_hallway", --Pyramid entrance, presumably
				"excavationsite", --Coal Pits, area 2
				"fungiforest", --Overgrowth
				"snowcave", --Snowy Depths
				"wandcave", --Magical temple.. huh
				"sandcave", --Desert sand cave, I don't think it includes desert chasm
				"winter", --Winter appears to be the snow chasm... terrifying. Also line 69!
				"rainforest", --Jungle
				"rainforest_dark", --Lukki Lair.. creepy
				"liquidcave", --Abandoned Alchemy Lab
			}
		},
		{ -- No Magic
			script = "global_populator_no_magic",
			biomes = {
				"the_end", --Heaven, or Hell, your choice. Either are The Work.
				"vault", --The Vault
				"robot_egg", --I'm sure you can guess
				"vault_frozen", --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
				"snowcastle", --Hisii Base... Interesting name.. I won't judge.. too much, I've used some really weird inengine names myself in the past
				"robobase", --Power Plant
			}
		},
		{ -- Small Only
			script = "global_populator_smallonly",
			biomes = {
				"clouds", --Cloudscapes
				"hills", --Hills, aka forest.
			}
		},
	}) do
		-- Generate append script file path
		local appendpath = table.concat({ "mods/Apotheosis/files/scripts/biomes/", append.script, ".lua" })
		-- Iterate over all biomes for the path
		for _, biome in ipairs(append.biomes) do
			-- Generate biome file path
			local biomepath = table.concat({ "data/scripts/biomes/", biome, ".lua" })
			-- Add the stuff
			ModLuaFileAppend(biomepath, appendpath)
		end
	end
end

--Appends Global Spawns to new biome files
do -- Global Spawns
	--DO NOT INCLUDE ANYTHING TOWER RELATED HERE, they're... "special" and need to be done in their own unique way
	for _, append in ipairs({
		{ -- General
			script = "global_populator",
			biomes = {
				"lava_excavation", --Core Mines, Volcanic lava filled land in the desert with plenty of loot but plenty of death
				"evil_temple", --Temple of Sacriligious Remains
			}
		},
	}) do
		-- Generate append script file path
		local appendpath = table.concat({ "mods/Apotheosis/files/scripts/biomes/", append.script, ".lua" })
		-- Iterate over all biomes for the path
		for _, biome in ipairs(append.biomes) do
			-- Generate biome file path
			local biomepath = table.concat({ "mods/Apotheosis/files/scripts/biomes/newbiome/", biome, ".lua" })
			-- Add the stuff
			ModLuaFileAppend(biomepath, appendpath)
		end
	end
end






--Spawns all the above spawns in a single file and appends to pixel scenes to prevent double spawning
-- If Conjurer is enabled, disable this for a fix.
if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
	dofile_once("mods/Apotheosis/files/scripts/biomes/boss_spawns/boss_spawn_list.lua")
	dofile_once("mods/Apotheosis/files/scripts/biomes/boss_spawns/blob_cave_spawn_list.lua")
end



--Spawns statues in the trophy room
--Deprecated, now down through a spawner w/ pixelscenes

--[[
if ModIsEnabled("purgatory") then
  ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/purgatory/statue_room_populator.lua" )
else
  ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/statue_room_populator.lua" )
end
]]
--





--Modded compatibility

--Alternate Biomes
--Remember to make specific files for these at some point.. it'd be weird if there were totally normal guys spawning in irridiated mines, or magical people in the robotics factory
if ModIsEnabled("biome-plus") then
	--Normal Spawns
	ModLuaFileAppend("data/scripts/biomes/mod/floodcave.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/aquifer_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/the_void.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/void_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/floating_mountain.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/floating_mountain_populator.lua")

	ModLuaFileAppend("data/scripts/biomes/mod/holy_temple.lua","mods/Apotheosis/files/scripts/biomes/crypt_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/collapsed_lab.lua","mods/Apotheosis/files/scripts/biomes/fungicave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/irradiated_mines.lua",
		"mods/Apotheosis/files/scripts/biomes/coalmine_alt_populator.lua")

	ModLuaFileAppend("data/scripts/biomes/mod/blast_pit.lua","mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/snowvillage.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/hisiivillage_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/frozen_passages.lua","mods/Apotheosis/files/scripts/biomes/snowcave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/catacombs.lua","mods/Apotheosis/files/scripts/biomes/wandcave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/sandcave_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/robofactory.lua","mods/Apotheosis/files/scripts/biomes/vault_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/swamp.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/swamp_populator.lua") --Jungle, could probably include bonus fungus here
	ModLuaFileAppend("data/scripts/biomes/mod/rainforest_wormy.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/wormtunnels_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/winter_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/sulfur_cave.lua","mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/hiddengrove_populator.lua") --Hidden Grove, Overgrowth populator

	--Global Spawns
	ModLuaFileAppend("data/scripts/biomes/mod/floodcave.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/irradiated_mines.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/blast_pit.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/frozen_passages.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/collapsed_lab.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/catacombs.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/swamp.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/robofactory.lua","mods/Apotheosis/files/scripts/biomes/global_populator_no_magic.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/holy_temple.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/snowvillage.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/rainforest_wormy.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/sulfur_cave.lua","mods/Apotheosis/files/scripts/biomes/global_populator.lua")

	--Dark Areas
	ModLuaFileAppend("data/scripts/biomes/mod/irradiated_mines.lua","mods/Apotheosis/files/scripts/biomes/suspicious.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")
	ModLuaFileAppend("data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")
end


--New Enemies, boosts ghost spawnrate in sandcave so they aren't flushed out by the quantity of other creatures.
--Also boosts Divine Being & Divine Poring spawnrates in Heaven & Hell for unlocks
if ModIsEnabled("new_enemies") then
	ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/sandcave_ghostbooster_populator.lua")
	--ModLuaFileAppend( "data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/the_end_angelboost_populator.lua" )
end

--New Enemies, boosts ghost spawnrate in sandcave so they aren't flushed out by the quantity of other creatures, compatibility for alt biomes.
if ModIsEnabled("new_enemies") then
	if ModIsEnabled("biome-plus") then
		ModLuaFileAppend("data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/sandcave_ghostbooster_populator.lua")
	end
end




-- Conjurer Mod, adds enemies, buildings and wands to a custom tab
if ModIsEnabled("raksa") then
	ModLuaFileAppend("mods/raksa/files/scripts/lists/entity_categories.lua", "mods/Apotheosis/files/scripts/mod_compatibility/conjurer_populator.lua")
end

if ModIsEnabled("conjurer_reborn") then
	ModLuaFileAppend("mods/conjurer_reborn/files/wandhelper/ent_list_pre.lua", "mods/Apotheosis/files/scripts/mod_compatibility/conjurer_populator.lua")
end



--Worse Enemies, Overrides Hisii Minecart visuals & attacks to match those from the mod
if ModIsEnabled("worse_enemies") then
	local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
	local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_tnt.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
	"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_tnt.xml"
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"data/entities/projectiles/cocktail_gunpowder.xml"
	ModTextFileSetContent("data/entities/animals/hisii_minecart_tnt.xml", tostring(xml))

	local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
	"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse.xml"
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"data/entities/projectiles/meteor_green.xml"
	xml:first_of("Base"):first_of("DamageModelComponent").attr.hp = "1.0"
	xml:add_child(nxml.parse([[
    <SpriteComponent
      _tags="character"
      image_file="mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_emissive.xml"
      offset_x="0"
      offset_y="0"
      alpha="1"
      emissive="1"
      additive="1">
	</SpriteComponent>
  ]]))
	ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))

	local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
	"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_weak.xml"
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"data/entities/projectiles/fireball_buckshot.xml"
	ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))

	--Bat Illusion Fix
	local content = ModTextFileGetContent("data/entities/animals/psychotic/bat.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "data/enemies_gfx/worse/bat.xml"
	ModTextFileSetContent("data/entities/animals/psychotic/bat.xml", tostring(xml))

	--Illusion Shotgunner Hisii Fix
	local content = ModTextFileGetContent("data/entities/animals/psychotic/shotgunner.xml")
	local xml = nxml.parse(content)
	xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
	"mods/Apotheosis/files/entities/projectiles/psychotic/meteor_green.xml"
	ModTextFileSetContent("data/entities/animals/psychotic/shotgunner.xml", tostring(xml))
end

-- Noita Toether compatibility, allows items like the new tablets, Fungus Stone & Hungry Orb to be added to the item bank
--This is done... weirdly
--[[
if ModIsEnabled("noita-together") then
  ModLuaFileAppend( "mods/noita-together/files/scripts/item_list.lua", "mods/Apotheosis/files/scripts/mod_compatibility/nt_itemlist_populator.lua" )
end
]]
--

-- Graham's Dialogue Mod, have fun! -S
if ModIsEnabled("grahamsdialogue") then
  ModLuaFileAppend("mods/grahamsdialogue/files/common.lua", "mods/Apotheosis/files/scripts/mod_compatibility/graham_dialogue_populator.lua")
  ModTextFileSetContent( "mods/grahamsdialogue/files/font_data/font_pixel_flesh.xml", ModTextFileGetContent("mods/Apotheosis/files/fonts/font_pixel_flesh.xml") )
  ModTextFileSetContent( "mods/grahamsdialogue/files/font_data/font_pixel_flesh.lua", ModTextFileGetContent("mods/Apotheosis/files/fonts/font_pixel_flesh.lua") )
end




-- Custom Perk support injection
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/Apotheosis/files/scripts/perks/custom_perks.lua")

-- Add portals to spatial awareness
do
	ModTextFileSetContent("data/scripts/perks/map.lua",ModTextFileGetContent("data/scripts/perks/map.lua"):gsub("if %( pw ~= 0 %) then", [[
			do local x, y = GlobalsGetValue("apotheosis_markerportal_red_x", "INVALID"), GlobalsGetValue("apotheosis_markerportal_red_y", "INVALID") if x ~= "INVALID" 		then GameCreateSpriteForXFrames( "mods/Apotheosis/files/particles/spatial_map_portal_r.png", mi_x + ((x / 512) * 6) + 3, mi_y + ((y / 512) * 6) - 56, true, 0, 0, 1, true ) end end
			do local x, y = GlobalsGetValue("apotheosis_markerportal_blue_x", "INVALID"), GlobalsGetValue("apotheosis_markerportal_blue_y", "INVALID") if x ~= "INVALID" 	then GameCreateSpriteForXFrames( "mods/Apotheosis/files/particles/spatial_map_portal_b.png", mi_x + ((x / 512) * 6) + 3, mi_y + ((y / 512) * 6) - 56, true, 0, 0, 1, true ) end end
			do local x, y = GlobalsGetValue("apotheosis_markerportal_green_x", "INVALID"), GlobalsGetValue("apotheosis_markerportal_green_y", "INVALID") if x ~= "INVALID" 	then GameCreateSpriteForXFrames( "mods/Apotheosis/files/particles/spatial_map_portal_g.png", mi_x + ((x / 512) * 6) + 3, mi_y + ((y / 512) * 6) - 56, true, 0, 0, 1, true ) end end
			if ( pw ~= 0 ) then]])
	)
	ModTextFileSetContent("data/scripts/perks/map.lua",ModTextFileGetContent("data/scripts/perks/map.lua"):gsub("is_moving == false", "true") )
end

-- Custom Status support injection
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/Apotheosis/files/scripts/status_effects/status_effects.lua")


-- Custom Audio Support
ModRegisterAudioEventMappings("mods/Apotheosis/files/audio/GUIDs.txt")



-- Misc

--Twitch Integration
--01/01/2023 Conga: I will only add creature shifting as an event as it's functionality is exclusive to Apotheosis.
ModLuaFileAppend( "data/scripts/streaming_integration/event_list.lua", "mods/Apotheosis/files/scripts/streaming_integration/event_list_populator_apoth.lua" )


--Musicstone tag addition
dofile_once("mods/Apotheosis/files/scripts/magic/music_magic_tag_nxml.lua")

if HasFlagPersistent("action_apotheosis_aqua_mine") or HasFlagPersistent("action_apotheosis_bomb_giga") then
	AddFlagPersistent("apotheosis_card_unlocked_welcome_hint")
end

--MOTD & Welcome Hint
if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
	local flag_status = HasFlagPersistent("apotheosis_card_unlocked_welcome_hint")
	if motdSetting == true or is_holiday_active("april_fools") then
		dofile_once("mods/Apotheosis/files/scripts/misc/motd_list.lua")
	elseif flag_status == false then
		--dofile_once( "mods/Apotheosis/files/scripts/misc/welcome_hint.lua" )
	end
end

--Allows hisii to jump into minecarts
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
if ModIsEnabled("Ride Minecart") == false then
	local content = ModTextFileGetContent("data/entities/props/physics_minecart.xml")
	local xml = nxml.parse(content)
	xml.attr.name = "minecart_hisii_hopin"
	ModTextFileSetContent("data/entities/props/physics_minecart.xml", tostring(xml))
	ModTextFileSetContent("data/entities/props/physics/minecart.xml", tostring(xml))
end

--local content = ModTextFileGetContent("data/entities/props/physics/minecart.xml")
--local xml = nxml.parse(content)
--xml.attr.name = "minecart_hisii_hopin"
--ModTextFileSetContent("data/entities/props/physics/minecart.xml", tostring(xml))


--Same thing but for hisii
local content = ModTextFileGetContent("data/entities/animals/shotgunner.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/shotgunner.xml", tostring(xml))

--Same thing but for hisii with TNT
local content = ModTextFileGetContent("data/entities/animals/miner_weak.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin_tnt.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/miner_weak.xml", tostring(xml))



-- Stendari magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/firemage.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005"
ModTextFileSetContent("data/entities/animals/firemage.xml", tostring(xml))

-- Gazer magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/gazer.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water,water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005,0.0005"
ModTextFileSetContent("data/entities/animals/gazer.xml", tostring(xml))

-- Burning Skull magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/fireskull.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005"
ModTextFileSetContent("data/entities/animals/fireskull.xml", tostring(xml))

-- Spit Monster magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/spitmonster.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water,water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005,0.0005"
ModTextFileSetContent("data/entities/animals/spitmonster.xml", tostring(xml))

--Allows for essence of fungus to be turned into a stone
local content = ModTextFileGetContent("data/entities/buildings/essence_eater.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
		execute_every_n_frame="-1"
		script_death="mods/Apotheosis/files/scripts/essence/away_modded.lua"
		remove_after_executed="0"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/essence_eater.xml", tostring(xml))

--Allows for moon shenanigans involving essences at the Sky Moon
local content = ModTextFileGetContent("data/entities/buildings/moon_altar.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
    _enabled="1"
    execute_every_n_frame="70"
    script_source_file="mods/Apotheosis/files/scripts/magic/moon_altar_modded.lua"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/moon_altar.xml", tostring(xml))

--Allows for moon shenanigans involving essences at the Dark Moon
local content = ModTextFileGetContent("data/entities/buildings/dark_moon_altar.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
    _enabled="1"
    execute_every_n_frame="70"
    script_source_file="mods/Apotheosis/files/scripts/magic/dark_moon_altar_modded.lua"
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/dark_moon_altar.xml", tostring(xml))











--Resets Blob Boss kill reward to prevent cheesing multiple "reward events" per kill
ModLuaFileAppend("data/scripts/newgame_plus.lua", "mods/Apotheosis/files/scripts/newgame_plus_appends.lua")
--GameRemoveFlagRun( "apotheosis_blob_boss_slain" )

--Adds custom enlightened alchemist types
--Could instead have a script that has a 2 in 6 chance to occur, and if it does make the alchemist one of the new variants, and append all this as a script on the englightened alch entity that runs after the vanilla init occurs
local content = ModTextFileGetContent("mods/Apotheosis/files/scripts/mod_compatibility/vanilla_enlightened_alchemist_init_append.lua")
ModTextFileSetContent("data/scripts/animals/enlightened_alchemist_init.lua", tostring(content))
--ModLuaFileAppend( "data/scripts/animals/enlightened_alchemist_init.lua", "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_enlightened_alchemist_init_append.lua" )

-- Adds musical_stone tag to the worm projectile, not to make musical ghosts appear but rather to make it double for a "spells to worms" effect
local content = ModTextFileGetContent("data/entities/projectiles/deck/worm_shot.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
ModTextFileSetContent("data/entities/projectiles/deck/worm_shot.xml", tostring(xml))

-- Adds various powders to dissolve powders perk
local content = ModTextFileGetContent("data/entities/misc/perks/dissolve_powders.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("CellEaterComponent").attr
attrs.materials = attrs.materials .. ",apotheosis_insect_husk,apotheosis_sand_pink,templebrick_static_broken_apotheosisoft,sand_blue"
ModTextFileSetContent("data/entities/misc/perks/dissolve_powders.xml", tostring(xml))

-- Adds various liquids to freeze charge modifier
local content = ModTextFileGetContent("data/entities/particles/freeze_charge.xml")
local xml = nxml.parse(content)
local attrs = xml:all_of("MagicConvertMaterialComponent")
attrs[2].attr.from_material_array = attrs[2].attr.from_material_array .. ",apotheosis_water_fading_fast,water_fading"
attrs[2].attr.to_material_array = attrs[2].attr.to_material_array .. ",ice_static,ice_static"
ModTextFileSetContent("data/entities/particles/freeze_charge.xml", tostring(xml))

-- Adds various liquids to circle of stillness
local content = ModTextFileGetContent("data/entities/projectiles/deck/freeze_field.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<MagicConvertMaterialComponent
      kill_when_finished="0"
      from_material="water_fading"
      steps_per_frame="5"
      to_material="ice_static"
      is_circle="1"
      radius="72" >
    </MagicConvertMaterialComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/freeze_field.xml", tostring(xml))

-- Adds various liquids to freeze field perk
local content = ModTextFileGetContent("data/entities/misc/perks/freeze_field.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<MagicConvertMaterialComponent
      kill_when_finished="0"
      from_material="apotheosis_water_fading_fast"
      steps_per_frame="5"
      to_material="ice_static"
      is_circle="1"
      radius="72" >
    </MagicConvertMaterialComponent>
]]))
ModTextFileSetContent("data/entities/misc/perks/freeze_field.xml", tostring(xml))





--Boss health multiplier insertion
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/boss_health_multiplier_plug.lua")

--Boss vulnerability immunity insertion
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/boss_vulnerability_immune_plug.lua")

--Modifies vanilla entity data
--Try not to tinker with base noita too much, the main goal to this mod is to be an expansion pack, not a rebalance.
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/vanilla_appends.lua")
dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/seasonal_tweaks.lua")









--Master of Masters master spawner insertion, allows him to spawn Master of Mallards & Master of Immortality too.. He doesn't appreciate Master of Trolling too much to invite him in
--Note, this has been moved to a file override, could probably use string.gsub to fix that
--Note 17/07/2023, string.gsub has been used






-- Seasonal Events
if seasonalSetting == true then
	-- Halloween Event
	if is_holiday_active("halloween") then
		ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua")                                           --Coal Mine, first area, goodluck on your run
		ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua")                                           --Coalmine but to the west side near damp cave
		ModLuaFileAppend("data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua")                                           --Coal Pits, area 2
		ModLuaFileAppend("data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua") --Presumably everything below the entrance to the pyramid
		--ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua") --Meant to add jackolaterns to the sandcaves, but no lamps naturally spawn down there, effort to work it in.

		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/poring.xml")
		content, count = content:gsub([[script_death="mods/Apotheosis/files/scripts/animals/poring_death_explosion.lua"]], [[script_death="mods/Apotheosis/files/scripts/animals/poring_halloween_death_explosion.lua"]])
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_halloween.xml"
		xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file =
		"mods/Apotheosis/files/ragdolls/poring_halloween/filenames.txt"
		ModTextFileSetContent("data/entities/animals/poring.xml", tostring(xml))

		local content = ModTextFileGetContent("data/entities/animals/coal_mines/poring.xml")
		content, count = content:gsub([[script_death="mods/Apotheosis/files/scripts/animals/poring_death_explosion.lua"]], [[script_death="mods/Apotheosis/files/scripts/animals/poring_halloween_death_explosion.lua"]])
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_halloween_weak.xml"
		xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file =
		"mods/Apotheosis/files/ragdolls/poring_halloween_weak/filenames.txt"
		ModTextFileSetContent("data/entities/animals/coal_mines/poring.xml", tostring(xml))

		local content = ModTextFileGetContent("data/entities/animals/psychotic/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_halloween.xml"
		xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file =
		"mods/Apotheosis/files/ragdolls/poring_halloween/filenames.txt"
		ModTextFileSetContent("data/entities/animals/psychotic/poring.xml", tostring(xml))
	end



	-- Smissmass Event
	if is_holiday_active("smissmass") then
		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_tnt.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/hisii_minecart_tnt_santa.xml"
		xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file =
		"data/entities/projectiles/present.xml"
		xml:add_child(nxml.parse([[
      <LuaComponent
          script_source_file="mods/Apotheosis/files/scripts/animals/esoteric_being_shifted_smoke.lua"
          execute_every_n_frame="1"
          remove_after_executed="1"
          >
      </LuaComponent>
      ]]))
		ModTextFileSetContent("data/entities/animals/hisii_minecart_tnt.xml", tostring(xml))

		if ModIsEnabled("worse_enemies") then
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))
		else
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))
		end

		if ModIsEnabled("worse_enemies") then
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_weak_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))
		else
			local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
			local xml = nxml.parse(content)
			xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
			"mods/Apotheosis/files/enemies_gfx/hisii_minecart_weak_smissmass.xml"
			ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))
		end

		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_santa.xml"
		ModTextFileSetContent("data/entities/animals/poring.xml", tostring(xml))

		local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
		local content = ModTextFileGetContent("data/entities/animals/coal_mines/poring.xml")
		local xml = nxml.parse(content)
		xml:first_of("Base"):first_of("SpriteComponent").attr.image_file =
		"mods/Apotheosis/files/enemies_gfx/poring_santa_weak.xml"
		ModTextFileSetContent("data/entities/animals/coal_mines/poring.xml", tostring(xml))
	end


	-- Birthday Event
	-- Update to be centered on 21/07/2022, this is when the first enemy was created and development officially began. Should be a fair trade off between not being the official release date but also not clashing with Halloween
	--Remember Update global_populator & global_populator_small too, wand tinkering crystal spawns are inside.
	if is_holiday_active("birthday") then
		ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua") --Hills slightly below ground
		ModLuaFileAppend("data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua") --Coal Mine, first area, goodluck on your run
		ModLuaFileAppend("data/scripts/biomes/coalmine_alt.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua")                                            --Coalmine but to the west side near damp cave
		ModLuaFileAppend("data/scripts/biomes/excavationsite.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua")                                            --Coal Pits, area 2
		ModLuaFileAppend("data/scripts/biomes/snowcave.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")                                       --Hiisi Base
		ModLuaFileAppend("data/scripts/biomes/snowcastle.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")
		ModLuaFileAppend("data/scripts/biomes/desert.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua")
		ModLuaFileAppend("data/scripts/biomes/rainforest.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")
		ModLuaFileAppend("data/scripts/biomes/vault.lua",
			"mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua")
	end


	-- April Fools Event
	if is_holiday_active("april_fools") then
		--Replace all hisii hobos with clowns.
		local content = ModTextFileGetContent("data/entities/animals/seasonal/hisii_hobo.xml")
		ModTextFileSetContent("data/entities/animals/hisii_hobo.xml", content)

		--Replace small fairies with lethal versions.
		local content = ModTextFileGetContent("data/entities/animals/seasonal/fairy_cheap.xml")
		ModTextFileSetContent("data/entities/animals/fairy_cheap.xml", content)

		--Replace big fairies with non-lethal versions.
		local content = ModTextFileGetContent("data/entities/animals/seasonal/fairy_big.xml")
		ModTextFileSetContent("data/entities/animals/fairy_big.xml", content)

		do -- Rename overgrown caverns to wandmart
			local path = "data/biome/fungiforest.xml"
			local content = ModTextFileGetContent(path)
			content = content:gsub("$biome_fun", "$biome_fungiforest_aprilfools")
			ModTextFileSetContent(path, content)
		end

		--100% chance for the Temple of the Art to be spawn everything
		ModLuaFileAppend("data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua")
	end
end













--Dark Areas
ModLuaFileAppend("data/scripts/biomes/wizardcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")      --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.

ModLuaFileAppend("data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")           --Temple of the Arts.. who died here?
ModLuaFileAppend("data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")         --Presumably everything below the entrance to the pyramid
ModLuaFileAppend("data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")       --BUNGUS!! cave, west side of area 2 for example

ModLuaFileAppend("data/scripts/biomes/fungiforest.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")     --Overgrowth
ModLuaFileAppend("data/scripts/biomes/wandcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")        --Magical temple.. huh
ModLuaFileAppend("data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")        --Desert sand cave, I don't think it includes desert chasm
ModLuaFileAppend("data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")           --The Vault

ModLuaFileAppend("data/scripts/biomes/winter.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")          --Winter appears to be the snow chasm... terrifying.
ModLuaFileAppend("data/scripts/biomes/rainforest_dark.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua") --Lukki Lair.. creepy
ModLuaFileAppend("data/scripts/biomes/vault_frozen.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")    --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
ModLuaFileAppend("data/scripts/biomes/robobase.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")        --Power Plant
ModLuaFileAppend("data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua")         --Heaven & Hell, but for this specific lua file append I'm only adding to hell

ModLuaFileAppend( "mods/Apotheosis/files/scripts/biomes/newbiome/evil_temple.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Temple of Sacrilegious Remains


--Secret

do -- Player Editor
	local path = "data/entities/player_base.xml"
	local xml = nxml.parse(ModTextFileGetContent(path))
	--Adds Biome tracker script to the player character, it will update their current biome difficulty and save the highest one they've ever achieved, maxing out at 7 in Heaven/Hell
	--This is currently only used for twitch integration so is disabled if TI is turned off, can be changed if needed elsewhere
	--  xml:add_child(nxml.parse([[
	--    <LuaComponent
	--      script_source_file="mods/Apotheosis/files/scripts/magic/biome_difficulty_tracker.lua"
	--      execute_every_n_frame="600"
	--      execute_times="-1"
	--      remove_after_executed="0"
	--      >
	--    </LuaComponent>
	--  ]]))

	--Makes player take contact damage from cursed liquid, poisonous gas, and other materials added by Apotheosis
	--Cursed Liquid, Cursed Liquid (Static), Poisonous Gas, Radioactive Gas (Fading)
	local attrs = xml:first_of("DamageModelComponent").attr
	attrs.materials_that_damage = attrs.materials_that_damage .. ",apotheosis_cursed_liquid_red,apotheosis_cursed_liquid_red_static,poison_gas,apotheosis_radioactive_gas_fading"
	attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.003,0.003,0.0008,0.001"

	if HasFlagPersistent("apotheosis_card_unlocked_secret_knowledge_of_kings") and capeSetting then
		--Adds Golden Cape if check is successful
		xml:add_child(nxml.parse([[
      <LuaComponent
        script_source_file="data/apotheosis_gfx/player_cape_colour_append.lua"
        execute_every_n_frame="2"
        execute_times="1"
        remove_after_executed="1"
        >
      </LuaComponent>
    ]]))
	end

	--Adds Parallel World checker to the player
	--Adds vampirism HP scaling
	--Previously every 30 seconds, now every 10 seconds after vampirism buff
	xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/magic/player_parallel_check.lua"
      execute_every_n_frame="600"
      execute_times="-1"
      remove_after_executed="0"
      >
    </LuaComponent>

  ]]))

	--Since Heretic now has a new way to be summoned tied to a new area we don't want people in old runs to be locked out of him -S
	xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/magic/new_run_check.lua"
      execute_every_n_frame="60"
      remove_after_executed="1"
      >
    </LuaComponent>
  ]]))

  --Causes the player to gain the wounded status upon taking damage.
	xml:add_child(nxml.parse([[
	<LuaComponent
	_enabled="0"
	_tags="hardcore_healing"
	script_damage_received="mods/Apotheosis/files/scripts/setup/hardcore_damage.lua"
	execute_every_n_frame="-1"
	>
	</LuaComponent>
  ]]))

  --Causes the player to gain the wounded status upon taking damage.
	xml:add_child(nxml.parse([[
	<LuaComponent
	_enabled="0"
	_tags="hardcore_healing"
	script_damage_about_to_be_received="mods/Apotheosis/files/scripts/setup/hardcore_healthcap.lua"
	execute_every_n_frame="-1"
	>
	</LuaComponent>
  ]]))

  --Spellbook support
	xml:add_child(nxml.parse([[
	<VariableStorageComponent
		name="spellbook_spell"
		value_string=""
	></VariableStorageComponent>
  ]]))

	--Adds Biome Check to the player
	xml:add_child(nxml.parse([[
    <Entity>
      <Base file="mods/Apotheosis/files/scripts/magic/biome_effects.xml" >
      </Base>
    </Entity>
  ]]))

	--Adds minimum cast delay gun extra to the player
	xml:add_child(nxml.parse([[
	<ShotEffectComponent
		extra_modifier="apotheosis_min_cast_delay"
		>
	</ShotEffectComponent>
  ]]))

	if is_holiday_active("smissmass") then
		local spritecomps = xml:all_of("SpriteComponent")
		for k=1,#spritecomps do
			if spritecomps[k].attr.image_file == "data/enemies_gfx/player_hat2.xml" then
				spritecomps[k].attr.image_file = HasFlagPersistent( "secret_hat" ) and "mods/Apotheosis/files/enemies_gfx/seasonal/player_hat_santa_crown.xml" or "mods/Apotheosis/files/enemies_gfx/seasonal/player_hat_santa.xml"
				spritecomps[k].attr.offset_x = 5.5
				spritecomps[k].attr.offset_y = 17
				break
			end
		end
	end

	--Debug
	--xml:add_child(nxml.parse([[
	--  <SpriteComponent
	--  _tags="character"
	--  alpha="1"
	--  image_file="mods/Apotheosis/files/player_gfx/perk_wings.xml"
	--  next_rect_animation=""
	--  offset_x="6"
	--  offset_y="14"
	--  rect_animation="walk"
	--  z_index="0.61"
	--></SpriteComponent>
	--]]))
	ModTextFileSetContent(path, tostring(xml))

	--print(tostring(xml))
end



--Guarantees Dense Smoke modifier to appear in the coalpits for your first run when playing with Apotheosis
if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
	if (HasFlagPersistent("apotheosis_card_unlocked_coalpits_dense_smoke") ~= true) then
		local filepc = "data/biome/_pixel_scenes.xml"
		if ModIsEnabled("purgatory") then
			filepc = "mods/purgatory/files/biome/_pixel_scenes.xml"
			local content = ModTextFileGetContent(filepc)
			local xml = nxml.parse(content)
			xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="1003" pos_y="111" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
			ModTextFileSetContent(filepc, tostring(xml))
		elseif ModIsEnabled("noitavania") then
			filepc = "mods/noitavania/data/biome/_pixel_scenes.xml"
			local content = ModTextFileGetContent(filepc)
			local xml = nxml.parse(content)
			xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="192" pos_y="1635" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
			ModTextFileSetContent(filepc, tostring(xml))
		else
			local content = ModTextFileGetContent(filepc)
			local xml = nxml.parse(content)
			xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="192" pos_y="1635" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
			ModTextFileSetContent(filepc, tostring(xml))
		end


		ModLuaFileAppend("data/scripts/biomes/excavationsite.lua",
			"mods/Apotheosis/files/scripts/biomes/excavationsite_populator_densesmoke.lua")
	end
end

-- Sets biome map to the new one
--[[
if experimental_biomemap then
  ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers_experimental.xml") --Sets the biome map
  dofile_once( "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_appends_experimental.lua" ) --appends experimental data
  Note: It would be fun to replace the entire world map one day, but that's biting off way more than I can chew, a small rat eating a whole cow level huge,
  A single person with 0 mods for a game trying to make an Rlcraft modpack huge
  Maybe after Apotheosis is done and we have a bunch of biome assets, enemy assets, spell, perk, item, etc assets, we could make a new world
  But until that day comes, We're sticking to the plan!
else
  ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers.xml") --Sets the biome map
  side note: maybe in that new world enemies could drop wands directly instead of finding them on pedestals
end
]]
--


--Custom biome modifiers
--ModTextFileSetContent("data/scripts/biome_modifiers.lua", ModTextFileGetContent("mods/Apotheosis/files/scripts/biome_modifiers/biome_modifiers.lua"))

--More Musical Magic implementation, coded by Y🍵
if ModTextFileGetContent("data/moremusicalmagic/musicmagic.lua") == nil then
	local data = ModTextFileGetContent("data/moremusicalmagic/compatibility/musicmagic.lua")
	ModTextFileSetContent("data/moremusicalmagic/musicmagic.lua", data)
	ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_default.lua")
end
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_apotheosis.lua")

--Spellbook
ModLuaFileAppend("mods/Apotheosis/files/scripts/magic/spellbook/spellbook_magic.lua", "mods/Apotheosis/files/scripts/magic/spellbook/spellbook_outcomes.lua")


--Set Custom Seed (And Check for Secret Seeds)
dofile_once("mods/Apotheosis/files/scripts/setup/secret_seeds.lua")

--Set the biome map
--This is handled underneath the custom seed check as the earliest biomemap append gets priority it seems
ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers.xml")

--Appending extra modifiers
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/Apotheosis/files/scripts/spells/gun_extra_populator.lua")

--Polymorph pool addition preperation
--Will be controlled via mod settings until it's pushed to main
--If you want to enable it, you can toggle "Expanded Polymorph Pool" in the mod settings

if ModIsEnabled("Global_Poly") then
	ModLuaFileAppend("mods/global_poly/files/scripts/poly_pool.lua", "mods/Apotheosis/files/scripts/mod_compatibility/poly_control_compat.lua")
	local old_on_world_init = OnWorldInitialized
	function OnWorldInitialized()
		dofile_once("mods/Apotheosis/files/scripts/magic/creature_shift_file_image_refresh.lua")

		if old_on_world_init then old_on_world_init() end
	end
else
	local old_on_world_init = OnWorldInitialized
	function OnWorldInitialized()
		dofile_once("mods/Apotheosis/files/scripts/mod_compatibility/polymorph_pool.lua")
		dofile_once("mods/Apotheosis/files/scripts/magic/creature_shift_file_image_refresh.lua")

		if old_on_world_init then old_on_world_init() end
	end
end

--Makes the Creature Shift Icon available to be editted during run-time
function OnModInit()
	ModImageMakeEditable( "data/ui_gfx/animal_icons/creature_shift/creature_shift_ui.png", 16, 16 )

	local path, csi_enemies = "data/ui_gfx/animal_icons/_list.txt", {}
	for enemy in ModTextFileGetContent(path):gmatch("[^\r\n]+") do
		csi_enemies[#csi_enemies+1] = enemy
	end
	for k=1,#csi_enemies do
		ModImageMakeEditable( table.concat({"data/ui_gfx/animal_icons/",csi_enemies[k],".png"}), 16, 16 )
		ModImageMakeEditable( table.concat({"data/ui_gfx/animal_icons/creature_shift/",csi_enemies[k],".png"}), 16, 16 )
		--Debug Data
		--print(table.concat({"making image writable: ",table.concat({"data/ui_gfx/animal_icons/",csi_enemies[k],".png"})}))
	end
end

--Randomly cause a fungal shift/creature shift at any time, at random.
--And print Happy April Fools at the start of the run
--Happy april fools <3
function AprilFoolsPlayerSpawn(plyr_id)
	if is_holiday_active("april_fools") then
		GamePrint("$sign_apotheosis_aprilfools_intro")
	end
end

-- Creature shift fix upon reloading world
-- Keep this at the bottom of the file, and only let one of this function exist, silly
function OnPlayerSpawned(player_entity)
	--Conga 04/12/2023
	--Warns the player to get off the god damn main branch, I'm tired of getting crash reports just for it to end up being this, man.
	--I know someone's going to stumble across this tired exhausted message one day, and I just want to say, I wanted to have faith in people, and believe that they would have read the multiple warnings on the mod page to play on the beta branch.
	--I was HOPING people would see the pinned thread called "Game Crashes" and take interest in it if they're experiencing problems, but that's asking too much I suppose.
	--I feel like I'm running a daycare sometimes, God Dammit.
	--urgh, alright, tired rant over
	--Thankyou for playing
	--
	--09/04/2024 Beta was pushed to main :')
	--
	--[[
	if GameIsBetaBuild() == false then
		EntityLoad("mods/Apotheosis/files/entities/props/sign_motd/sign_motd_painpeko.xml",260,-85)
	end
	]]--

	local x, y = EntityGetTransform(player_entity) --This was just "player" by default but I feel like something broke.. I hope not
	EntityLoad("mods/Apotheosis/files/entities/special/entity_shift_refresh_fixer.xml", x, y)

	--Previously a game print to warn against Ride Minecarts
	--[[if ModIsEnabled("Ride Minecart") == true then
    GamePrint("Error, could not initialise hopping into minecarts because of [Ride Minecarts], Apotheosis should function as normal otherwise though.")
  end]]--

	--Post Ascension scenery
	--[[
	if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02") and HasFlagPersistent("apotheosis_card_unlocked_sea_to_potion") == false then

		--Gather world entity data
		local worldEntity = GameGetWorldStateEntity()
		local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")

		--Set weather up to be nice
		ComponentSetValue2(comp,"intro_weather",true)
		ComponentSetValue2(comp,"time",0.55)
		ComponentSetValue2(comp,"time_dt",0.5)
		ComponentSetValue2(comp,"fog",0)
		ComponentSetValue2(comp,"rain",0)

		EntityLoad("mods/Apotheosis/files/entities/particles/upwards_trail.xml", 239, -229)
		EntityLoad("mods/Apotheosis/files/entities/particles/upwards_trail.xml", 764, -860)

		AddFlagPersistent("apotheosis_card_unlocked_sea_to_potion")
	end
	]]--

	--Reset Red Sand fx
	GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)
	GlobalsSetValue("conga_red_sand_effect_amount",0)

	--Warns the player if Mo Creeps is enabled, to shut it off
	if ModIsEnabled("Mo_Creeps") then
		GamePrintImportant("WARNING: MO CREEPS IS ENABLED", "Apotheosis & More Creeps should not be enabled at the same time, Mo Creeps content is already inside apotheosis.")
	end

	--[[
	--Warns the player if Nightmare is enabled, that the hardcore seed exists
	if ModIsEnabled("Nightmare") and HasFlagPersistent("apotheosis_card_unlocked_nightmarewarning") == false then
		GamePrintImportant("WARNING: MO CREEPS IS ENABLED", "Apotheosis & More Creeps should not be enabled at the same time, Mo Creeps content is already inside apotheosis.")
		AddFlagPersistent("apotheosis_card_unlocked_nightmarewarning")
	end
	]]--

	--Debug Testing for intro scene
	--RemoveFlagPersistent( "apotheosis_intro_cutscene" )

	--Handles the intro cutscene if the player hasn't encountered it yet
	if ModIsEnabled("Mo_Creeps") == false and HasFlagPersistent("apotheosis_intro_cutscene") == false then
		EntityLoad("mods/Apotheosis/files/entities/intro/controller_scenes.xml", x, y)
		--This is added when the cutscene ends to prevent a softlock
		--AddFlagPersistent( "apotheosis_intro_cutscene" )
	end

	if custom_seed then
		GamePrint("$sign_apotheosis_custom_seed")

		local seed = string.lower(ModSettingGet( "Apotheosis.custom_seed" ))
		if seed == "hardcore" or seed == "nightcore" then
			GameAddFlagRun("apotheosis_hardmode")
		end
	end

	--Handles AprilFools related code
	AprilFoolsPlayerSpawn(player_entity)

	--Calculate RNG
	SetRandomSeed(111, 222)
	if Random(1, 2000) == 1 then
		GameAddFlagRun(table.concat({ "apothe", "osis_", "div", "ine_red_fi", "sh" }))
	end
end

--Custom Materials
ModMaterialsFileAdd("mods/Apotheosis/files/scripts/materials/secret_materials.xml")
ModMaterialsFileAdd("mods/Apotheosis/files/scripts/materials/custom_materials.xml")


ModLuaFileAppend("data/scripts/items/potion.lua", "mods/Apotheosis/files/scripts/potions/potion_appends.lua")
ModLuaFileAppend("data/scripts/items/powder_stash.lua", "mods/Apotheosis/files/scripts/potions/powder_stash_appends.lua")
ModLuaFileAppend("data/scripts/items/potion_aggressive.lua", "mods/Apotheosis/files/scripts/potions/potion_aggressive_appends.lua")

local splash = ""
local mod_name = "Apotheosis"
function OnMagicNumbersAndWorldSeedInitialized()
	--You can just edit material file data after appending it and it works, uhh, cool, thanks Nolla; Thanks Wondible
	do --Setup Magic Catalyst data
		dofile("mods/Apotheosis/files/scripts/materials/secret_materials_generate.lua")
		GenerateMagicCatalyst()
	end

	-- Adds custom Pixel Scenes in
	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		dofile_once("mods/Apotheosis/files/scripts/pixelscenes/scene_list.lua")
	end

	SetRandomSeed(minute, 7783258) --Used to be 1111 instead of minute, seeding rng by the real life minute rolls different splash text between mod restarts
	local splashes = {
		"Now with 50% more fairies",
		"l ll ll l_",
		(function () local y, m, d, h, m, s = GameGetDateAndTimeLocal() local greet = "" if h>=5 and h<12 then greet = "morning" elseif h>=12 and h<18 then greet = "afternoon" elseif h>=18 and h<22 then greet = "evening" else greet = "night" end return table.concat{"Good ", greet} end)(),
		"Pet the cat!",
		"Drink water!",
		"Take stretches!",
		":3",
		"Every pixel is simulated",
		"Mina stole the precious thing",
		"Ashcorporation, brought to you by Ken",
		"Not blurry!",
		"Not bubbly!",
		"Photorealistic!",
		"32-bit!",
		"Supports 8D graphics",
		"Send us a postcard with your highscore!",
		"Stay out of hell",
		"Quit nagging me!",
		"MOTY!",
		"Now in 2D",
		"May contain peanuts",
		"Destroy every pixel",
		"Plz reply to my tweet",
		"Everyone gets a puppy!",
		"100% pure",
		"No artifical preservatives, colours, or flavours",
		"Doesn't contain microplastics!",
		"May contain alcohol",
		"Drinking may cause lifelong harm to your homunculus",
		"Best in it's class!",
		"Limited edition!",
		"More than 60,000 downloads!",
		"May contain spiders",
		"Exploding eggs!",
		"Ask your doctor!",
		"1432",
		"That hiisi is a spy!",
		"All you had to do was follow the train CJ",
		"Has an ending!",
		"Monoliths!",
		"Has a habbit for sentient rocks",
		"Déjà vu!",
		"Déjà vu!",
		"Not associated with shadowy wizard gangs",
		"The rumors are true",
		"3 years in development", --We won't be developing this forever, so it'd be improper to leave this as something which automatically updates over time. May as well see how high this number can go before it stops incrementing
		"Casual gaming",
		"Hardcore gaming!",
		"Pneumonoultramicroscopicsilicovolcanoconiosis!",
		"I miss my cat",
		"Swan dive into the sun!",
		"Now with 100% more sweat!",
		"Now with furious blacksmiths!",
		"Now with 100% more maggots and dogs!",
		"Played by snakes with tophats!",
		"Ah! Chippie!",
		"Rabbits, guns and supermarts are bad mix",
		"Starry edition!",
		"Bringing home the bacon!",
		"It's a mod",
		"As seen on TV!",
		"One of a kind!",
		Random()>0.999 and "Every copi is personalised!" or "Every copy is personalised!", -- :p
		"Famous within it's circles!",
		"May contain traces of chocolate",
		"Keyboard compatible!",
		"Keybaord uncompatiable",
		"l33t",
		"Not affected by scunthorpe!",
		"Not associated with that other Apotheosis",
		"Upgrades all your cards!",
		"Overenchanting!",
		"More Creeps and Weirdos: Extended",
		"More Creeps and Weirdos, we miss you.",
		"I'll never tell you my oshi",
		"The noobs adventure",
		"Recommended by 9 out of 10 dentists!",
		"dQw4w9WgXcQ",
		"oavMtUWDBTM",
		"Not associated with Calamity!",
		"L is real",
		"Spell racecar backwards!",
		"Based on a true story!",
		"Player 2 is connected",
		"Player Count: 2",
		"Featuring rainbow cats!",
		"Turn your head and cough",
		"The moon is made of cheese!",
		"Now featuring DOOMKILLER!!",
		"This Terraria update looks wild",
		"Don't mind me here.",
		"There's no time! The eye puzzle solution is...",
		"What do the numbers mean???",
		"Chainsaw stocks are plummeting!",
		"I've come to talk about your extended warrenty",
		"Download more ram!",
		"Try Kolmi's perfect math class!",
		"The trees are moving!",
		"The hills have eyes!",
		"The best day of your life so far!",
		"You just lost the game!",
		"Clever girl",
		"Use by 21 July 2082",
		"Fresh Meat!",
		"Now with fishing!",
		"Now supports wyrms!",
		"Absolutely no sentient books!",
		"We built this mod on Rock n' Roll!",
		"Have a vegemite sandwich!",
		"MINA IS YOU",
		"Order now for 50% off!",
		"Free wins or your money back!",
		"The red fish is real",
		"Built on an ancient indian burial ground",
		"Extra Large!",
		"The cake is a lie!",
		"I'm a potato!",
		"Ohh yeahh!!!!",
		"Alway rember happy day",
		"Approved by Notla Games",
		"That's a lot of damage! How about a little more?",
		"Nanomachines son!",
		"Don't dig straight down!",
		"U.N. Owen was Her?",
		"Testing Testing 1 2 3",
		"Bazinga!",
		"I AM YOUR DEAFENING",
		"Not as fair as fairmod!",
		"Buy one get one free!",
		"Walk like an egyptian!",
		"10 doesn't mean 11!!!",
		"Call an exorcist!",
		"Awaken my masters!",
		"Less addictive than nethack!",
		"Something wicked this way comes...",
		"Remember to slip, slop, slap, seek and slide!",
		"Back in my day we couldn't drop spells freely",
		"I have intense bomb-igniting thoughts!!",
		"D4 + G4, D4 + G4, G4 + C5, D5 + G4, F4 + A#4",
		"Somewhere over the rainbow",
		"Love what you have while you still can"
	}
	SetRandomSeed(minute * second, 7783258) --Used to be 1111 instead of minute, seeding rng by the real life minute rolls different splash text between mod restarts
	splash = splashes[Random(1, #splashes)]

	--6.66% chance for the associated user's reference splash to appear if they're playing
	if userseed_check("393592761468528034044338707123") then --SnekGregory
		if Random(1,15) == 1 then
			splash = "Played by snakes with tophats!"
		end
	elseif userseed_check("00130639114681086286") then --DunkOrSlam
		if Random(1,15) == 1 then
			splash = "Now with 100% more sweat!"
		end
	end

	--1 in 1000 chance for it to swap around the o and the e
	if Random(1,1000) == 1 then mod_name = "Apothoesis" end
end

function OnModPreInit()

	--RESET ALL PROGRESS
	if ModSettingGet("Apotheosis.progress_handling_do_reset") == true then
		for l=1,20 do
			print("reset setting found, beginning purge")
		end
		dofile("mods/Apotheosis/lib/Apotheosis/apotheosis_flag_utils.lua")
		for flag=1,#apotheosis_flag_list do
			print("removing " .. apotheosis_flag_list[flag])
			RemoveFlagPersistent(apotheosis_flag_list[flag])
		end
		ModSettingSet("Apotheosis.progress_handling_do_reset", false)
	end

	--Local Userseed backup
	local user_seed = ModSettingGet("fairmod.user_seed") or 0
	if user_seed ~= 0 then
		print(table.concat({"userseed is ",user_seed}))
		AddFlagPersistent(table.concat({"userseed_",userseed}))
		ModSettingSetNextValue("Apotheosis.user_seed", user_seed, false)
	end

end





-- NEW COPI TECH
-- EVIL NOLLA MAGIC WARDING SPELLS
-- RITUALS TO KEEP NOLLA BULLSHIT AWAY
-- MAD FUCKIGN SPELLS PROTECTION FROM EVIL
-- DIVINE PROTECTION ABJURATION GLYPHS BELOW
-- HALT CRASHING SHIT 1 FRAME DELAY HACKERY
-- FRANKENSTEIN RADIO CONTROLS BELOW
--[[
]]--
function OnWorldPreUpdate()
	local orbs = EntityGetWithTag("orb_knowledge_sorry4tag") or {}
	local orbcount = GameGetOrbCountThisRun()
	--local orbcount = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") ) --Three-Eyed Orb? Kolmi-orb?
	local radius = 6*orbcount^0.5
	for i=1, #orbs do
		dofile_once("mods/Apotheosis/files/scripts/projectiles/orb_knowledge_setup.lua")(orbs[i], orbcount, radius)
		EntityRemoveTag(orbs[i], "orb_knowledge_sorry4tag")
	end
end

ModLuaFileAppend("data/scripts/items/orb_pickup.lua", "mods/Apotheosis/files/scripts/magic/orb_pickup.lua")


-- MENU SHIT!!!!!
-- THIS WILL SHOW IN THE PAUSE MENU!!
-- TODO mod compatible method for fitting multiple items 
function OnPausePreUpdate()
	Gui = Gui or GuiCreate()
	--[[
	-- Ultra haxx so we can detect menus being open. Force an ID collision.
	for i=1, 10 do
		GuiColorSetForNextWidget(Gui, 0.35, 0.35, 0.35, 0.5)
		GuiButton(Gui, 2, 12.5, 20*i-10, "TEST", 1, "data/fonts/font_pixel.xml")
		GuiColorSetForNextWidget(Gui, 0.35, 0.35, 0.35, 0.5)
		local t={GuiGetPreviousWidgetInfo(Gui)} for i=1, #t do t[i]=tostring(t[i]) end
		GuiText(Gui, 12.5, 20*i, table.concat(t, " "), 1, "data/fonts/font_pixel.xml")
	end]]

	GuiIdPushString(Gui, "apoth_pause")
	GuiColorSetForNextWidget(Gui, 0.35, 0.35, 0.35, 0.5)
	GuiText(Gui, 12.5, ({GuiGetScreenDimensions(Gui)})[2]/2-38, table.concat{mod_name," - ", apoth_version, " - ", splash}, 1, "data/fonts/font_pixel.xml")
	GuiIdPop(Gui)
end