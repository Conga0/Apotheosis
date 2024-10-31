--Appending/changing vanilla boss/creature data
dofile("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local year, month, day, hour = GameGetDateAndTimeLocal()

--Pitboss can shoot blackholes if she fails a line of sight check too many times in a row, prevents tablet cheese
do
  local path = "data/entities/animals/boss_pit/boss_pit.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
      <LuaComponent
      script_source_file="data/entities/animals/boss_pit/boss_pit_apotheosis_blackhole_check.lua"
      execute_times="-1"
      execute_every_n_frame="300"
      remove_after_executed="0"
      >
      </LuaComponent>
  ]]))
  xml:add_child(nxml.parse([[
      <VariableStorageComponent
          name="apotheosis_blackhole_count"
          value_int="0"
          >
      </VariableStorageComponent>
  ]]))
  xml:add_child(nxml.parse([[
      <LuaComponent
      script_damage_received="data/entities/animals/boss_pit/boss_pit_apotheosis_proj_failsafe.lua"
      script_death="data/entities/animals/boss_pit/boss_pit_apotheosis_proj_failsafe.lua"
      execute_times="-1"
      execute_every_n_frame="-1"
      remove_after_executed="0"
      >
      </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

--Prevents High Alchemist from creating an unnecessarily high amount of shields by giving him a 3 second cooldown between creating a new shield from taking damage
do
  local path = "data/entities/animals/boss_alchemist/boss_alchemist.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <VariableStorageComponent
      name="shield_cd_data"
      value_int="-10000"
      >
    </VariableStorageComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

--Prevents PW High Alchemist from creating an unnecessarily high amount of shields by giving him a 3 second cooldown between creating a new shield from taking damage
do
  local path = "data/entities/animals/parallel/alchemist/parallel_alchemist.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
	<VariableStorageComponent
		name="shield_cd_data"
		value_int="-10000"
		>
	</VariableStorageComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

--Adds tag to wandstone so perk creation altar can detect it.. technically you can throw it into the sun because of this but, eh, nobody would ever do that.. right? I just wanna save on tags whenever possible
--Let Wand Stone enable tinkering regardless of if you have it held or not
do
  local content = ModTextFileGetContent("data/entities/items/pickup/wandstone.xml")
  local xml = nxml.parse(content)
  xml.attr.tags = xml.attr.tags .. ",poopstone"
  local attrs = xml:first_of("GameEffectComponent").attr
  attrs._tags = attrs._tags .. ",enabled_in_inventory"
  ModTextFileSetContent("data/entities/items/pickup/wandstone.xml", tostring(xml))
end

--Lets sun seed provide ASE while passively inside the player's inventory
do
  local path = "data/entities/items/pickup/sun/sunseed.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  local attrs = xml:first_of("GameEffectComponent").attr
  attrs._tags = attrs._tags .. ",enabled_in_inventory"
  ModTextFileSetContent(path, tostring(xml))
end

--Lets sun stone provide ASE while passively inside the player's inventory
do
  local path = "data/entities/items/pickup/sun/sunstone.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  local attrs = xml:first_of("GameEffectComponent").attr
  attrs._tags = attrs._tags .. ",enabled_in_inventory"
  ModTextFileSetContent(path, tostring(xml))
end

--Adds tag to beamstone so perk creation altar can detect it.. technically you can throw it into the sun because of this but, eh, nobody would ever do that.. right? I just wanna save on tags whenever possible
do
  local content = ModTextFileGetContent("data/entities/items/pickup/beamstone.xml")
  local xml = nxml.parse(content)
  xml.attr.tags = xml.attr.tags .. ",poopstone"
  ModTextFileSetContent("data/entities/items/pickup/beamstone.xml", tostring(xml))
end

--Adds Vulnerability immunity check to Master of Vulnerability's attack
local content = ModTextFileGetContent("data/entities/misc/effect_weaken.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
		script_source_file="mods/Apotheosis/files/scripts/status_effects/weaken_immunity_check.lua"
		execute_every_n_frame="2"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/misc/effect_weaken.xml", tostring(xml))

--Makes it so bosses can't be afflicted with negative Master effects... mostly so Heretic can stop hitting himself...
--Why is the neutralize effect not called effect_neutralize instead of neutralized...
do
  local effects = {"effect_hearty","effect_twitchy","neutralized"}
  for k=1, #effects
  do local v = effects[k];
    local content = ModTextFileGetContent("data/entities/misc/" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:add_child(nxml.parse([[
	<LuaComponent
	    script_source_file="mods/Apotheosis/files/scripts/status_effects/boss_check.lua"
	    execute_every_n_frame="1"
	    remove_after_executed="1"
	    >
	</LuaComponent>
    ]]))
    ModTextFileSetContent("data/entities/misc/" .. v .. ".xml", tostring(xml))
  end
end

do -- Fix Spatial Awareness friendcave position(s)
    local path = "data/scripts/perks/map.lua"
    local content = ModTextFileGetContent(path)
    content = content:gsub("local fspots = { { 249, 153 }, { 261, 201 }, { 153, 141 }, { 87, 135 }, { 81, 219 }, { 153, 237 } }", "local fspots = { { 309, 153 }, { 260, 201 }, { 153, 141 }, { 87, 135 }, { 81, 219 }, { 153, 237 } }")
    ModTextFileSetContent(path, content)
end

--Fix Weakening Curses not showing remaining time
do
  local curses = {"electricity","explosion","melee","projectile"}
  for k=1, #curses
  do local v = curses[k];
    local content = ModTextFileGetContent("data/entities/misc/curse_wither_" .. v .. ".xml")
    local xml = nxml.parse(content)
    xml:first_of("UIIconComponent").attr.display_in_hud = "1"
    xml:first_of("UIIconComponent").attr.is_perk = "0"
    ModTextFileSetContent("data/entities/misc/curse_wither_" .. v .. ".xml", tostring(xml))
  end
end

do --Vanilla Pixel Scene adjustments
  local path = "data/biome/_pixel_scenes.xml"
  local content = ModTextFileGetContent(path)

  -- Remove some pixelscenes as they're being turned into biomes to recur infinitely with world width (essence eaters use pixelscenes that don't line up with the new world width)
  content = content:gsub("data/biome_impl/overworld/essence_altar_visual.png", "")
  content = content:gsub("data/biome_impl/overworld/essence_altar_desert_visual.png", "")
  content = content:gsub("data/biome_impl/overworld/essence_altar.png", "")
  content = content:gsub("data/biome_impl/overworld/essence_altar_desert.png", "")
  content = content:gsub("data/entities/buildings/essence_eater.xml", "")
  
  -- Fix Music Machines to spawn in PWs properly
  content = content:gsub("data/entities/props/music_machines/music_machine_00.xml", "")
  content = content:gsub("data/entities/props/music_machines/music_machine_01.xml", "")
  content = content:gsub("data/entities/props/music_machines/music_machine_02.xml", "")
  content = content:gsub("data/entities/props/music_machines/music_machine_03.xml", "")

  --Move Hidden Glyph Jungle down slightly so it isn't revealed in open terrain
  content = content:gsub("x=\"2806\" y=\"6614\"", "x=\"2806\" y=\"6714\"")
  ModTextFileSetContent(path, content)
end

do -- Increase Giga Death Cross's Damage
  local path = "data/entities/projectiles/deck/death_cross_big_laser.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("0.38", "1.20")
  content = content:gsub("1.15", "1.35")
  ModTextFileSetContent(path, content)
end

--Can't gsub anything with a string? [[]] doesn't work?
--do -- Fix Darkcave not spawning in properly, because it just doesn't if I don't do this...? weird
--  local path = "data/scripts/biomes/watercave.lua"
--  local content = ModTextFileGetContent(path)
--  content = content:gsub([[function random_layout( x, y )]], [[function init( x, y )]])
--  content = content:gsub([[LoadPixelScene( "data/biome_impl/watercave_layout_"..r..".png", "", x, y, "", true )]], [[LoadPixelScene( "data/biome_impl/watercave_layout_"..r..".png", "", x, y + 3, "", true )]])
--  ModTextFileSetContent(path, content)
--end

--Bubble Spark Bounce no longer does self-damage
local content = ModTextFileGetContent("data/entities/projectiles/deck/bounce_spark_friendly_fire.xml")
local xml = nxml.parse(content)
xml:first_of("Base"):first_of("ProjectileComponent").attr.friendly_fire = "0"
ModTextFileSetContent("data/entities/projectiles/deck/bounce_spark_friendly_fire.xml", tostring(xml))

local content = ModTextFileGetContent("data/entities/projectiles/deck/bounce_spark_friendly_fire_silent.xml")
local xml = nxml.parse(content)
xml:first_of("ProjectileComponent").attr.friendly_fire = "0"
ModTextFileSetContent("data/entities/projectiles/deck/bounce_spark_friendly_fire_silent.xml", tostring(xml))


--Maybe only do this for an optional "hardmode? Unsure"
--Goal is for the mod to be accessible to anyone but it gets so freakin boring 1 shotting everything

dofile_once("mods/apotheosis/lib/apotheosis/apotheosis_utils.lua")

--Moved over to hardmode seed

do --Boosts Health of various creatures
  local multiplier = 2.0
  local enemy_list = {
    "acidshooter",
    "barfer",
    "crystal_physics",
    "enlightened_alchemist",
    --"failed_alchemist",
    "maggot",
    "necromancer",
    "phantom_a",
    "phantom_b",
    "skullfly",
    "skullrat",
    "tentacler",
    "tentacler_small",
    "thundermage",
    "wizard_dark",
    "wizard_neutral",
    "wizard_poly",
    "wizard_returner",
    "wizard_tele",
    "worm",
    "worm_skull",
    --Modded Enemies below
    "devourer_ghost",
    "devourer_magic",
    "hideous_mass",
    "hideous_mass_red",
    "tentacler_big",
    "phantom_c_apotheosis",
    "triangle_gem",
    "wizard_firemage_greater",
    "watermage",
  }

  MultiplyHP("data/entities/animals/crypt/",enemy_list,multiplier,true)
end



do --Boosts Health of various creatures (THE_END)
  local multiplier = 10.0
  local enemy_list = {
    "bloodcrystal_physics",
    "gazer",
    "skycrystal_physics",
    "skygazer",
    "spearbot",
    "spitmonster",
    "worm_end",
    "worm_skull",
    --Modded Enemies below
    "barfer",
    "blindgazer",
    "fairy_big_discord",
    "forsaken_eye",
    "gazer_cold_apotheosis",
    "gazer_greater",
    "gazer_greater_cold",
    "gazer_greater_sky",
    "gazer_parasitic",
    "ghost_bow",
    "musical_being",
    "sentry",
    "slime_leaker_weak",
    "slime_teleporter",
    "slimeshooter_boss_limbs",
    "star_child",
    "wizard_firemage_greater",
    "wraith_returner_apotheosis",
    "poring_holy",
    "poring_devil",
  }

  MultiplyHP("data/entities/animals/the_end/",enemy_list,multiplier,true)
end

do
  --Sextuple health of Evil Temple Masters
  multiplier = 6.0
  enemy_list = {
    "wizard_corrupt_ambrosia",
    "wizard_corrupt_hearty",
    "wizard_corrupt_manaeater",
    "wizard_corrupt_neutral",
    "wizard_corrupt_swapper",
    "wizard_corrupt_teleport",
    "wizard_corrupt_twitchy",
    "wizard_corrupt_weaken",
    "wizard_corrupt_poly",
    --"wizard_corrupt_wands",
  }

  MultiplyHP("data/entities/animals/",enemy_list,multiplier,true)
end


do -- Add some new magical liquids to the Ancient Laboratory
  local path = "data/biome/liquidcave.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("FFF86868,FF7FCEEA,FFA3569F,FFC23055,FF0BFFE5", "FFF86868,FF7FCEEA,FFA3569F,FFC23055,FF0BFFE5,FF59FDD9,FFF6CBAE,FFF6F7FD")
  ModTextFileSetContent(path, content)
end


--do -- Rework Vulnerability Curses.. hmm..
--  local path = "data/scripts/projectiles/curse_wither_start.lua"
--  local path_2 = "data/scripts/projectiles/curse_wither_end.lua"
--  local content = ModTextFileGetContent(path)
--  content = content:gsub([[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
--	
--	if ( comp ~= nil ) then]], [[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
--	
--    if ( comp ~= nil )and ComponentObjectGetValue2( comp, "damage_multipliers", name ) > 0 then]])
--  content = content:gsub("mult = mult + 0.25", "mult = mult * 2")
--  ModTextFileSetContent(path, content)
--
--  local content = ModTextFileGetContent(path_2)
--  content = content:gsub([[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
--	
--	if ( comp ~= nil ) then]], [[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
--	
--    if ( comp ~= nil ) and ComponentObjectGetValue2( comp, "damage_multipliers", name ) > 0 then]])
--  content = content:gsub("mult = mult - 0.25", "mult = mult * 0.5")
--  ModTextFileSetContent(path2, content)
--end



do -- Add projectile tag to pit boss wands so they can be cleaned up too
  local path = "data/entities/animals/boss_pit/wand.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[name="$projectile_default"]], [[name="$projectile_default" tags="projectile"]])
  ModTextFileSetContent(path, content)
end

do -- Add secret path check to portal entity
  local path = "data/entities/buildings/teleport_liquid_powered.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  attrpath = xml:first_of("LuaComponent").attr
  attrpath.script_portal_teleport_used = "mods/apotheosis/files/scripts/buildings/teleporter_secret_check_fail.lua"
  ModTextFileSetContent(path, tostring(xml))
end

do
  --Prevents Worm launcher from eating through indestructible terrain
  local path = "data/entities/projectiles/deck/worm_shot.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  attrpath = xml:first_of("CellEaterComponent").attr
  attrpath.ignored_material_tag = "[indestructible]"
  ModTextFileSetContent(path, tostring(xml))
end

do
  --Prevents Giga Disc Projectile from eating through indestructible terrain
  local path = "data/entities/projectiles/deck/disc_bullet_big.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  attrpath = xml:first_of("CellEaterComponent").attr
  attrpath.ignored_material_tag = "[indestructible]"
  ModTextFileSetContent(path, tostring(xml))
end

do
  --Prevents Omega Disc Projectile from eating through indestructible terrain
  local path = "data/entities/projectiles/deck/disc_bullet_bigger.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  attrpath = xml:first_of("CellEaterComponent").attr
  attrpath.ignored_material_tag = "[indestructible]"
  ModTextFileSetContent(path, tostring(xml))
end

do -- Add lua script to vulnerability effect which applies "vulnerable" tag to afflicted creature (allows for lua scripts to detect for vulnerability)
  local path = "data/entities/misc/effect_weaken.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
    script_source_file="mods/apotheosis/files/scripts/status_effects/vulnerability_tag_start.lua"
    execute_every_n_frame="4"
    remove_after_executed="1"
    >
    </LuaComponent>
  ]]))
  xml:add_child(nxml.parse([[
    <LuaComponent
    script_source_file="mods/apotheosis/files/scripts/status_effects/vulnerability_tag_end.lua"
    execute_every_n_frame="-1"
    execute_on_removed="1"
    >
    </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do -- Add lua script to Waterstone, allowing you to charm watermages
  local path = "data/entities/items/pickup/waterstone.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
    _enabled="0"
		_tags="enabled_in_hand"
    script_source_file="mods/apotheosis/files/scripts/items/waterstone_charm.lua"
    execute_every_n_frame="30"
    remove_after_executed="0"
    >
    </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do -- Fix Swapper Projectiles stretching weirdly (only horizontal instead of all directions)
  local path = "data/entities/projectiles/deck/swapper.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[update_transform_rotation="0"]], [[update_transform_rotation="1"]])
  ModTextFileSetContent(path, content)
end

do -- Limit enemies to dropping 300k gold at any given time, prevents lag in NG+ runs
  local path = "data/scripts/items/drop_money.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("local x, y = EntityGetTransform( entity )", "if money > 250000 then money = 250000 end local x, y = EntityGetTransform( entity )")
  ModTextFileSetContent(path, content)
end

if ModSettingGet( "Apotheosis.spellrebalances" ) then -- Nerf Kantele, Ocarina, Plasma & Omega Disc Projectile to only hit once very 15 frames instead of once every 1 frame
  local pathprefix = "data/entities/projectiles/deck/"
  local notes = {
    "kantele/kantele_a.xml",
    "kantele/kantele_d.xml",
    "kantele/kantele_dis.xml",
    "kantele/kantele_e.xml",
    "kantele/kantele_g.xml",
    "ocarina/ocarina_a.xml",
    "ocarina/ocarina_a2.xml",
    "ocarina/ocarina_b.xml",
    "ocarina/ocarina_c.xml",
    "ocarina/ocarina_d.xml",
    "ocarina/ocarina_e.xml",
    "ocarina/ocarina_f.xml",
    "ocarina/ocarina_gsharp.xml",
    "orb_laseremitter.xml",
    "orb_laseremitter_four.xml",
    "orb_laseremitter_cutter.xml",
    "disc_bullet_bigger.xml",
    "duck.xml",
    "glowing_bolt.xml",
  }

  for k=1,#notes do
    local path = table.concat({pathprefix,notes[k]})
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    attrpath = xml:first_of("ProjectileComponent").attr
    attrpath.damage_every_x_frames = "15"
    ModTextFileSetContent(path, tostring(xml))
  end
end

if ModSettingGet( "Apotheosis.spellrebalances" ) then -- Nerf Ball Lightning to hit once every 10 frames instead of once every 1 frame
  local path = "data/entities/projectiles/deck/ball_lightning.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  attrpath = xml:first_of("ProjectileComponent").attr
  attrpath.damage_every_x_frames = "10"
  ModTextFileSetContent(path, tostring(xml))
end

if ModSettingGet( "Apotheosis.spellrebalances" ) then -- Nerf Fish to hit once every 10 frames instead of once every 1 frame
  local path = "data/entities/projectiles/deck/fish.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  attrpath = xml:first_of("ProjectileComponent").attr
  attrpath.damage_every_x_frames = "10"
  ModTextFileSetContent(path, tostring(xml))
end

do -- Change sunseed sprite filepath for Perk Creation Anvil
  local path = "data/entities/items/pickup/sun/sunseed.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("data/items_gfx/goldnugget_01.png", "mods/apotheosis/files/items_gfx/goldnugget_01_alt.png")
  ModTextFileSetContent(path, content)
end

do --Softcap heart spawns at 1,000 hp
  ModLuaFileAppend( "data/scripts/biome_scripts.lua", "mods/Apotheosis/files/scripts/biome_scripts_appends.lua" )

  local path = "data/scripts/biome_scripts.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("if %(r > heart_spawn_percent%) then", "if (r > heart_spawn_percent) and player_health_check() then")
  ModTextFileSetContent(path, content)
end

do --Visiting Parallel worlds is the same as incrementing the NG+ counter for the director
  ModLuaFileAppend( "data/scripts/director_helpers.lua", "mods/Apotheosis/files/scripts/mod_compatibility/director_helpers_appends.lua" )
end

do --Spawn entity for perk manipulation at holy mountains
  ModLuaFileAppend( "data/scripts/biomes/temple_altar.lua", "mods/Apotheosis/files/scripts/biomes/temple_altar_populator.lua" )
  ModLuaFileAppend( "data/scripts/biomes/boss_arena.lua", "mods/Apotheosis/files/scripts/biomes/temple_altar_populator.lua" )
end

do -- Buffs ants to have a faster moving & longer range acid spit
  local path = "data/entities/animals/ant.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("data/entities/projectiles/acidburst.xml", "mods/apotheosis/files/entities/projectiles/ant_acidburst.xml")
  ModTextFileSetContent(path, content)
end

do -- gsub new wizards into Master of Master's spawn table
  local path = "data/entities/animals/boss_wizard/spawn_wizard.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[local opts = { "wizard_tele"]], [[local opts = { "wizard_ambrosia", "wizard_duck", "wizard_jackofalltrades", "wizard_manaeater", "wizard_transmutation", "wizard_tele"]])
  ModTextFileSetContent(path, content)
end

do -- Fixes Hourglass portal leading to the wrong x,y coordinates in the new world map
  local path = "data/entities/buildings/teleport_hourglass.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("5420", "4908")
  ModTextFileSetContent(path, content)
end

--I can not get this to work and I'm not sure how.. I mean it works, but gsubbing blob and it also gsubbing miniblob is a pain, but there's no good place to reinsert either because multi-line gsubbing doesn't want to work and it's just arrrgghhh
--Moved to a file overwrite until a better solution is found
--
--Could gsub with [[3 lines of reference here]] instead
--ie:
--[[giantshooter
--miniblob
--blob]]
--
--
--[[
do -- Organise Creature Progress List

  local list_order = {
    {
      id_matchup  = "blob",
      id          = "blob_big",
    },
    {
      id_matchup  = "blob_big",
      id          = "blob_huge",
    },
    {
      id_matchup  = "blob_huge",
      id          = "blob_titan",
    },
  }

  local path = "data/ui_gfx/animal_icons/_list.txt"
  local content = ModTextFileGetContent(path)

  content = content:gsub("miniblob", "")

  for k=1,#list_order
  do local v = list_order[k]
    content = content:gsub(v.id_matchup, v.id_matchup .. "\n" .. v.id)
  end

  content = content:gsub([[giantshooter_weak
giantshooter]]--[[, "giantshooter_weak" .. "\n" .. "giantshooter" .. "\n" .. "miniblob")

  ModTextFileSetContent(path, content)
end
]]--

--Might be a good learning exercise to convert the list_override.txt file into a table?
--mmmmmmmmmmm

--[[
do  --File override approach for organising animal icons
  if ModSettingGet( "Apotheosis.organised_icons" ) == true then
    local content = ModTextFileGetContent("mods/apotheosis/files/ui_gfx/animal_icons/list_override.txt")
    ModTextFileSetContent("data/ui_gfx/animal_icons/_list.txt",content)
  end
end
]]--

do -- gsub new Creeps into Summon Egg's spawn table
  local path = "data/scripts/items/egg_hatch.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[fire = { {"firebug", 3}, {"bigfirebug"} },]], [[fire = { {"firebug", 3}, {"bigfirebug"}, {"whisp", 10} },]])
  content = content:gsub([[chilly = { {"tentacler_small"}, {"tentacler"} },]], [[chilly = { {"tentacler_small"}, {"tentacler"}, {"tentacler_big"} },]])
  content = content:gsub([[red = { {"bat", 3}, {"tentacler_small"}, {"tentacler"} },]], [[red = { {"bat", 3}, {"fairy_big", 2}, {"tentacler_small"}, {"tentacler"} },]])
  content = content:gsub("\"data/entities/animals/\" %.%. entity_to_spawn %.%. \"%.xml\"", "GlobalsGetValue( table.concat({\"apotheosis_cs_\",entity_to_spawn,\"_filepath\"}), table.concat({\"data/entities/animals/\",entity_to_spawn,\".xml\"}) )")
  ModTextFileSetContent(path, content)
end

--do
--  local path = "data/scripts/item_spawnlists.lua"
--  local content = ModTextFileGetContent(path)
--  content = content:gsub([[egg_monster.xml]], [[apotheosis/egg_fairy.xml]])
--  content = content:gsub([[egg_slime.xml]], [[apotheosis/egg_mud.xml]])
--  content = content:gsub([[egg_purple.xml]], [[apotheosis/egg_robot.xml]])
--  ModTextFileSetContent(path, content)
--end

do  -- Robots take damage from Veloium
  local path = "data/entities/base_enemy_robot.xml"
  local xml = nxml.parse(ModTextFileGetContent(path))

  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.materials_that_damage = attrs.materials_that_damage .. ",apotheosis_magic_liquid_velocium"
  attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0003"

  ModTextFileSetContent(path, tostring(xml))
end

do  -- Fix monks not taking damage from concentrated mana or Veloium
  local path = "data/entities/animals/monk.xml"
  local xml = nxml.parse(ModTextFileGetContent(path))

  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.materials_that_damage = "acid,lava,poison,blood_cold,blood_cold_vapour,radioactive_gas,radioactive_gas_static,rock_static_radioactive,rock_static_poison,ice_radioactive_static,ice_radioactive_glass,ice_acid_static,ice_acid_glass,rock_static_cursed,poo_gas,apotheosis_magic_liquid_velocium,magic_liquid_mana_regeneration"
  attrs.materials_how_much_damage = "0.004,0.004,0.001,0.0008,0.0007,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.005,0.00001,0.0003,0.001"

  ModTextFileSetContent(path, tostring(xml))
end

-- SEARCH TAG SPELLREWORK
--[[
do -- Piercing only hit 5 times per modifier

end
]]--

if ModSettingGet( "Apotheosis.spellrebalances" ) then
  local path = "data/entities/misc/piercing_shot.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
    _enabled="1"
    script_source_file="mods/apotheosis/files/scripts/projectiles/piercing_shot_rebalance_additive.lua"
    execute_every_n_frame="1"
    remove_after_executed="1"
    >
    </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

--Anvil of Destiny Compatibility
if ModIsEnabled("anvil_of_destiny") then
  ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/apotheosis/files/scripts/mod_compatibility/anvil_of_destiny_appends.lua")
end


do --Add Random Homing to Pyramid Boss loot pool
  local path = "data/entities/animals/boss_limbs/boss_limbs_death.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"DRAW_RANDOM_X3\", \"DRAW_3_RANDOM\"", "\"DRAW_RANDOM_X3\", \"DRAW_3_RANDOM\", \"APOTHEOSIS_RANDOM_HOMING\", \"APOTHEOSIS_RANDOM_BURST\"")
  ModTextFileSetContent(path, content)
end

do --Add Chi to High Alchemist loot pool
  local path = "data/entities/animals/boss_alchemist/death.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"PHI\", \"TAU\", \"SIGMA\"","\"PHI\", \"TAU\", \"SIGMA\", \"APOTHEOSIS_CHI\"")
  ModTextFileSetContent(path, content)
end

do -- Autogenerate filepath VSCs for various items
  local paths = {
    "data/entities/items/books/book_00.xml",
    "data/entities/items/books/book_01.xml",
    "data/entities/items/books/book_02.xml",
    "data/entities/items/books/book_03.xml",
    "data/entities/items/books/book_04.xml",
    "data/entities/items/books/book_05.xml",
    "data/entities/items/books/book_06.xml",
    "data/entities/items/books/book_07.xml",
    "data/entities/items/books/book_08.xml",
    "data/entities/items/books/book_09.xml",
    "data/entities/items/books/book_10.xml",
    "data/entities/items/books/base_book.xml",
    "data/entities/items/books/book_tree.xml",
  }

  for k=1,#paths
  do local v = paths[k]
    local content = ModTextFileGetContent(v)
    local xml = nxml.parse(content)
    xml:add_child(nxml.parse([[
      <LuaComponent
      _enabled="1"
      script_source_file="mods/apotheosis/files/scripts/items/obj_path.lua"
      execute_every_n_frame="1"
      remove_after_executed="1"
      >
      </LuaComponent>
    ]]))
    ModTextFileSetContent(v, tostring(xml))
  end
end

do --Update vanilla Player Ghost to be able to catch & throw back tablets
  local path = "data/entities/animals/apparition/playerghost.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)

	xml:add_children(nxml.parse_many([[
    <LuaComponent
		_enabled="1"
		_tags="disabled_by_liquid"
		script_source_file="mods/apotheosis/files/scripts/animals/playerghost/tablet_catch.lua"
		execute_every_n_frame="3"
		execute_times="-1"
		>
	</LuaComponent>
	
	<VariableStorageComponent
		name="tablet_path"
		value_string=""
		value_int="0"
	>
	</VariableStorageComponent>

	<AIAttackComponent
		_enabled="0"
		_tags="enabled_by_liquid"
		min_distance="20"
		max_distance="200"
		frames_between="220"
		frames_between_global="60"
		attack_ranged_offset_x="0"
		attack_ranged_offset_y="0"
		animation_name="attack_tablet"
		attack_ranged_entity_file=""
		attack_ranged_action_frame="4"
		>
	</AIAttackComponent>

	<LuaComponent
		_enabled="0"
		_tags="enabled_by_liquid"
		script_shot="mods/apotheosis/files/scripts/animals/playerghost/tablet_throw.lua"
		execute_every_n_frame="-1"
		execute_times="-1"
		>
	</LuaComponent>

	<HotspotComponent
		_tags="hand_l"
		sprite_hotspot_name="hand"
		transform_with_scale="1" >
	</HotspotComponent>

	<Entity name="hand_l">	
		
		<InheritTransformComponent
			parent_hotspot_tag="hand_l"
			only_position="1" >
		</InheritTransformComponent>

		<SpriteComponent
			_enabled="0"
			_tags="enabled_by_liquid"
			image_file="data/items_gfx/in_hand/emerald_tablet_in_hand.png" 
			emissive="0"
			additive="0"
			offset_x="4" 
			offset_y="4" >
		</SpriteComponent>

	</Entity>

	<LuaComponent
		_enabled="0"
		_tags="enabled_by_liquid"
		script_death="mods/apotheosis/files/scripts/animals/playerghost/tablet_death.lua"
		execute_every_n_frame="-1"
		execute_times="1"
		>
	</LuaComponent>

	]]))

  --xml:first_of("SpriteComponent").attr.image_file = "mods/apotheosis/files/enemies_gfx/playerghost/playerghost.xml"
  ModTextFileSetContent(path, tostring(xml))

  ModTextFileSetContent("data/enemies_gfx/playerghost.xml",ModTextFileGetContent("mods/apotheosis/files/enemies_gfx/playerghost/playerghost.xml"))
end


do --Fix Unstable Crystal not being affected by Larpa
  local path = "data/entities/projectiles/deck/mine.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)

  xml:add_child(nxml.parse([[
    <VariableStorageComponent
		name="projectile_file"
		value_string="data/entities/projectiles/deck/mine.xml"
		>
	</VariableStorageComponent>
  ]]))

  ModTextFileSetContent(path, tostring(xml))
end

do --Tower creature appends
  local path = "data/scripts/biomes/tower.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[local enemy_list = { "acidshooter", "alchemist", "ant",]], [[local enemy_list = { "acidshooter", "alchemist", "ant", "boss_toxic_worm", "boss_toxic_worm_minion", "bubble_liquid", "bubbles/ambrosia/bubble_liquid", "blindgazer", "blob_big", "blob_huge", "forsaken_eye", "fungus_smoking_creep", "gazer_cold_apotheosis", "gazer_greater", "gazer_greater_cold", "gazer_greater_sky", "gazer_robot", "ghost_bow", "giant_centipede", "vault/goo_slug", "ccc_bat_psychic", "fungiforest/ceiling_fungus", "devourer_ghost", "devourer_magic", "drone_mini", "drone_status_ailment", "esoteric_being", "fairy_big", "fairy_big_discord", "fairy_esoteric", "crypt/hideous_mass", "vault/hisii_engineer", "hisii_giga_bomb", "hisii_minecart", "hisii_minecart_tnt", "hisii_rocketshotgun", "locust_swarm", "lukki_fungus", "lukki_swarmling", "mimic_explosive_box", "poisonmushroom", "poring", "poring_holy", "poring_lukki", "poring_magic", "rat_birthday", "sentry", "star_child", "sunken_creature", "slime_leaker", "slime_leaker_weak", "slime_teleporter", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_big", "tesla_turret", "triangle_gem", "watermage", "whisp", "whisp_big", "wizard_ambrosia", "wizard_copeseethmald", "wizard_duck", "wizard_explosive", "wizard_manaeater", "wizard_transmutation", "wizard_corrupt_teleport", "wizard_firemage_greater", "wizard_z_poly_miniboss", "wraith_returner_apotheosis", "wraith_weirdo_shield", ]])
  ModTextFileSetContent(path, content)
end

do --Reduces enemy spawnrates by increasing chance of a null spawn
  local biomes = {
    "coalmine",         --Coal Mine, first area, goodluck on your run
    "crypt",            --Temple of the Arts.. who died here?
    "pyramid_hallway",  --Pyramid entrance, presumably
    "excavationsite",   --Coal Pits, area 2
    "snowcave",         --Snowy Depths
    "sandcave",         --Desert sand cave, I don't think it includes desert chasm
    "winter",           --Winter appears to be the snow chasm... terrifying. Also line 69!
    "rainforest",       --Jungle
    --"rainforest_dark",  --Lukki Lair.. creepy
    "liquidcave",       --Abandoned Alchemy Lab
    --"the_end",          --Heaven, or Hell, your choice. Either are The Work.
    "vault",            --The Vault
    --"robot_egg",        --I'm sure you can guess
    --"robobase",         --Power Plant
    --"hills",            --Hills, aka forest.
  }
  local appendpath = "mods/apotheosis/files/scripts/biomes/global_biome_reduceenemies_x4.lua"

  for k=1,#biomes
  do local v = biomes[k]
    local biomepath = table.concat({"data/scripts/biomes/", v, ".lua"})
    ModLuaFileAppend(biomepath, appendpath)
  end
end

--[[
do --Reduces enemy spawnrates by increasing chance of a null spawn (modded)
  local biomes = {
    --"ant_hell", --Ant Nest
    --"desert_pit", --Sink Hole
    --"esoteric_den", --Esoteric Den
    --"evil_temple", --Temple of Sacriligious Remains
    --"lava_excavation", --Core Mines
    --"sunken_cave", --Sunken Cavern
  }
  local appendpath = "mods/apotheosis/files/scripts/biomes/global_biome_reduceenemies_x2.lua"

  for k=1,#biomes
  do local v = biomes[k]
    local biomepath = table.concat({"mods/apotheosis/files/scripts/biomes/newbiome/", v, ".lua"})
    ModLuaFileAppend(biomepath, appendpath)
  end
end
]]--

do --Reduces enemy spawnrates by increasing chance of a null spawn (2x)
  local biomes = {
    "desert",           --Desert above ground & below, careful not to die to any Stendari
    "coalmine_alt",     --Coalmine but to the west side near damp cave
    "wandcave",         --Magical Temple
    --"clouds",           --Cloudscapes
    "vault_frozen",     --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
    --"pyramid",          --Presumably everything below the entrance to the pyramid
    --"fungiforest",      --Overgrowth
    "fungicave",        --BUNGUS!! cave, west side of area 2 for example
    "snowcastle",       --Hisii Base... Interesting name.. I won't judge.. too much, I've used some really weird inengine names myself in the past
    --"wizardcave",       --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
  }
  local appendpath = "mods/apotheosis/files/scripts/biomes/global_biome_reduceenemies_x2.lua"

  for k=1,#biomes
  do local v = biomes[k]
    local biomepath = table.concat({"data/scripts/biomes/", v, ".lua"})
    ModLuaFileAppend(biomepath, appendpath)
  end
end

do --Genomes
  dofile_once("mods/apotheosis/files/scripts/mod_compatibility/genomes.lua")
end

--Hiisi Anvil appends
ModLuaFileAppend( "data/scripts/buildings/forge_item_convert.lua", "mods/apotheosis/files/scripts/buildings/anvil_appends.lua")

--[[
do -- Allow Friend & Horror Monsters to use portals
  local path = "data/entities/animals/ultimate_killer.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("small_friend", "small_friend,teleportable")
  ModTextFileSetContent(path, content)

  local path = "data/entities/animals/friend.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("big_friend", "big_friend,teleportable")
  ModTextFileSetContent(path, content)
end
]]--


do -- Allow Karl the Mighty, First of its Name, Mover of Suns and Friend to All to be teleported by Portalium
  local path = "data/entities/buildings/racing_cart.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("racing_cart,moon_energy", "racing_cart,moon_energy,teleportable_NOT")
  ModTextFileSetContent(path, content)
end

--[[
-- Conga: Feels wrong
do -- Add Portalium to the HM liquid pool
  local path = "data/scripts/biomes/temple_altar_top_shared.lua"
  local path_append = "mods/apotheosis/files/scripts/biomes/temple_wall_appends.lua"

  ModLuaFileAppend( path, path_append )
end
]]--


--Allows for Pandora Chest rain to occur if you bring a Pandora's Chest to the mountain altar
--ModLuaFileAppend( "data/scripts/magic/altar_tablet_magic.lua", "mods/Apotheosis/files/scripts/magic/mountain_altar_appends.lua" )

do -- Mountain Altar Appends
  local path = "data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
    _enabled="1"
    script_source_file="mods/Apotheosis/files/scripts/magic/mountain_altar_appends.lua"
    execute_every_n_frame="240"
    remove_after_executed="0"
    >
    </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do --Update Masters of Homing to be made out of attuning meat
  local path = "data/entities/animals/wizard_homing.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_material = "apotheosis_meat_homing"
  ModTextFileSetContent(path, tostring(xml))
end

do -- Correct Mountain Altar to use the appropriate orb numbers taking new orb rooms into consideration, 45 for all orbs and 46+ for Red Gem
  local path = "data/entities/animals/boss_centipede/ending/sampo_start_ending_sequence.lua"
  local content = ModTextFileGetContent(path)
  --content = content:gsub("( orb_count >= 33 )", "( orb_count >= 45 )")
  content = content:gsub("( orb_count > 33 )", "( orb_count > 45 )")
  --content = content:gsub("if( orb_count < 33", "if( orb_count < 45")
  
  --Add Challenge mode win flags
  --Conga: This doesn't work, no clue why
  --Copi: Just needed a bit of percentage :^)
  content, count = content:gsub([[local essence_1 = GameHasFlagRun%( "essence_fire" %)]], [[local essence_1 = GameHasFlagRun( "essence_fire" )
  
  if GameHasFlagRun("apotheosis_towerclimb") then
    AddFlagPersistent("apotheosis_card_unlocked_challenge_towerclimb_win")
  elseif GameHasFlagRun("apotheosis_hardmode") then
    AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_hardcore")
  elseif GameHasFlagRun("apotheosis_missingmagic") then
    AddFlagPersistent("apotheosis_card_unlocked_challenge_missingmagic_win")
  end
    
  ]])

  --These are all so the Heretical Eye can comment on them when they occur
  content, count = content:gsub([[AddFlagPersistent%( "progress_ending2" %)]], [[AddFlagPersistent( "progress_ending2" )
  GameAddFlagRun( "apotheosis_vanilla_ending2" )]])

  content, count = content:gsub([[AddFlagPersistent%( "progress_ending0" %)]], [[AddFlagPersistent( "progress_ending0" )
  GameAddFlagRun( "apotheosis_vanilla_ending0" )]])

  content, count = content:gsub([[AddFlagPersistent%( "progress_ending1_gold" %)]], [[AddFlagPersistent( "progress_ending1_gold" )
  GameAddFlagRun( "apotheosis_vanilla_ending1_gold" )]])

  content, count = content:gsub([[AddFlagPersistent%( "progress_ending1_toxic" %)]], [[AddFlagPersistent( "progress_ending1_toxic" )
  GameAddFlagRun( "apotheosis_vanilla_ending1_toxic" )]])

  --Debug data
  --print("printing sampo_start_ending_senquence.lua\n\n" .. content)
  ModTextFileSetContent(path, content)
end

do -- Modify Kolmi to gain a water hexing attack at 9 orbs, Kolmi's Minions gain the ability to disable shields at 15 orbs
  local path = "data/entities/animals/boss_centipede/boss_centipede_update.lua"
  local content = ModTextFileGetContent(path)
  content, count = content:gsub([[-- polymorph shots]], [[-- hex shots
  if orbcount >= 9 then phases[#phases+1] = { phase_hex, 0 } end
  
  -- polymorph shots]])

  content, count = content:gsub([[function phase_polymorph%(%)]], [[function phase_hex()
    open_eye()
    boss_wait(30)
  
    hexshot()
    GameEntityPlaySound( GetUpdatedEntityID(), "shoot_homingshot" )
    boss_wait(5)
    hexshot()
    GameEntityPlaySound( GetUpdatedEntityID(), "shoot_homingshot" )
    boss_wait(5)
    hexshot()
    GameEntityPlaySound( GetUpdatedEntityID(), "shoot_homingshot" )
    boss_wait(5)
    hexshot()
    GameEntityPlaySound( GetUpdatedEntityID(), "shoot_homingshot" )
    boss_wait(5)
    boss_wait(20)
  
    close_eye()
    next_phase()
  end
  
  function phase_polymorph()]])
  
  content, count = content:gsub([[function polymorphshot%(%)]], [[function hexshot()
    local this         = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform( this )
  
    shoot_projectile( this, "data/entities/animals/boss_centipede/projectiles/orb_water_circle.xml", pos_x, pos_y - 10, 0, math.random(-50,50) )
    shoot_projectile( this, "data/entities/animals/boss_centipede/projectiles/orb_water_hex.xml", pos_x - 5, pos_y, -30, math.random(-50,50) )
    shoot_projectile( this, "data/entities/animals/boss_centipede/projectiles/orb_water_hex.xml", pos_x - 5, pos_y, -30, math.random(-50,50) )
  end
  
  function polymorphshot()]])
  
  content, count = content:gsub([[EntityLoad%( "data/entities/animals/boss_centipede/boss_centipede_minion.xml", x, y %)]], [[local minionpath = "data/entities/animals/boss_centipede/boss_centipede_minion.xml"
	if orbcount >= 15 then
		minionpath = "data/entities/animals/boss_centipede/minion_sapping/boss_centipede_minion.xml"
	end
	EntityLoad( minionpath, x, y )]])

  content = content:gsub("EntityGetFirstComponent%( entity, \"DamageModelComponent\" %)", "EntityGetFirstComponent( entity, \"DamageModelComponent\" ) boss_hp = boss_hp * (ModSettingGet( \"Apotheosis.boss_health_multiplayer\" ) / 100) local blood_mult = ComponentGetValue2(comp, \"blood_multiplier\") ComponentSetValue( comp, \"blood_multiplier\", tostring(blood_mult / (ModSettingGet( \"Apotheosis.boss_health_multiplayer\" ) / 100)) )")

  --Debug data
  --print("printing boss_centipede_update.lua\n\n" .. content)
  ModTextFileSetContent(path, content)
end

do --Lets Kolmisilma clear slime when using his clear materials ability
  local path = "data/entities/animals/boss_centipede/clear_materials.xml"
  local content = ModTextFileGetContent(path)
  content, count = content:gsub([[lava,radioactive_liquid,acid,poison]], [[lava,radioactive_liquid,acid,poison,slime,water]])
  content, count = content:gsub([[air,air,air,air]], [[air,air,air,air,air,air]])

  ModTextFileSetContent(path, content)
end

do  --Insert enemies into the progress log where they belong, originally handled through an overwrite but now should be more mod-compatiable to future proof it incase any other inspiring enemy modders appear
  dofile_once("mods/apotheosis/files/scripts/mod_compatibility/enemy_list_inserts.lua")
end

do -- Make humanoids take damage from poisonous gas
  local path = "data/entities/base_humanoid.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("acid,lava,poison", "acid,lava,poison,poison_gas")
  content = content:gsub("0.004,0.004,0.001", "0.004,0.004,0.001,0.0008")

  ModTextFileSetContent(path, content)
end

do -- Insert rare potion spawns into potion.lua
  local path = "data/scripts/items/potion.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()]], [[if Random(1,100) == 1 then
		local opts = {
			"apotheosis_magic_liquid_nukes",
			"apotheosis_magic_liquid_escapium",
			"apotheosis_milk",
			"mimic_liquid",
		}

		potion_material = opts[Random(1,#opts)]
	end
	
	local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal]])

  ModTextFileSetContent(path, content)
end

ModLuaFileAppend( "data/scripts/item_spawnlists.lua", "mods/Apotheosis/files/scripts/items/item_list_appends.lua" )

do -- Add Alchemic runestone to the runestone pool (item pedestals)
  local path = "data/scripts/item_spawnlists.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"disc\", \"metal\"", "\"disc\", \"metal\", \"alchemy\"")

  ModTextFileSetContent(path, content)
end

do -- Add Alchemic runestone to the runestone pool (chests)
  local path = "data/scripts/items/chest_random.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"disc\", \"metal\"", "\"disc\", \"metal\", \"alchemy\"")

  ModTextFileSetContent(path, content)
end

do -- Add death check to MoM for the run
  local path = "data/entities/animals/boss_wizard/death.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("material_str = \"\"", "material_str = \"\" GameAddFlagRun(\"apotheosis_mom_dead\")")

  ModTextFileSetContent(path, content)
end

--[[
--Conga: Doesn't work because the orbs are children of MoM and the EntityGetInRadiusWithTag function only targets non-children
--Whoever made this function is from Bethesda
do -- Give MoM orbs the "mortal" tag
  local path = "data/entities/animals/boss_wizard/wizard_orb_blood.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("hittable,touchmagic_immunity,polymorphable_NOT", "hittable,touchmagic_immunity,polymorphable_NOT,mortal,hittable")

  ModTextFileSetContent(path, content)
end

do -- Give MoM orbs the "mortal" tag
  local path = "data/entities/animals/boss_wizard/wizard_orb_death.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("hittable,touchmagic_immunity,polymorphable_NOT", "hittable,touchmagic_immunity,polymorphable_NOT,mortal,hittable")

  ModTextFileSetContent(path, content)
end
]]--

do -- Lets you drink directly from pouches
  local path = "data/entities/items/pickup/powder_stash.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("drinkable=\"0\"", "drinkable=\"1\"")

  ModTextFileSetContent(path, content)
end

do -- Fixes CEOs to spawn in the correct entity when creature shifted
  local path = "data/scripts/animals/leader_damage.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("EntityLoad%( \"data/entities/animals/scavenger_grenade.xml\", x, y %)", "local filepath = GlobalsGetValue( \"apotheosis_cs_scavenger_grenade_filepath\", \"data/entities/animals/scavenger_grenade.xml\" ) EntityLoad( filepath, x, y )")

  ModTextFileSetContent(path, content)
end

do -- Fixes Blobs to spawn in the correct entity when creature shifted
  local path = "data/scripts/animals/blob_damage.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("local e %= EntityLoad%( \"data/entities/animals/miniblob.xml\", pos_x, pos_y %)", "local filepath = GlobalsGetValue( \"apotheosis_cs_miniblob_filepath\", \"data/entities/animals/miniblob.xml\" ) local e = EntityLoad( filepath, pos_x, pos_y )")
  
  ModTextFileSetContent(path, content)
end

--Conga: HM Portals sound weird when used with this, eye glass doesn't work, don't have the time to debug it
do --Fix Some teleportation related structures not being powered by portallium
  local path = "data/entities/buildings/teleport_hourglass.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)

  xml:add_child(nxml.parse([[
    <MaterialAreaCheckerComponent
		_tags="disabled_by_liquid"
		area_aabb.min_x="-16" 
		area_aabb.max_x="16" 
		area_aabb.min_y="110"   
		area_aabb.max_y="115"
		update_every_x_frame="1"
		material="apotheosis_magic_liquid_rideshare"
		material2=""
		look_for_failure="0"
		kill_after_message="0">
	</MaterialAreaCheckerComponent>
  ]]))

  ModTextFileSetContent(path, tostring(xml))
end

do -- Add new materials into Chaotic Transmutation
  local path = "data/scripts/projectiles/transmutation.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"diamond\", \"brass\", \"silver\"", "\"diamond\", \"brass\", \"silver\", \"apotheosis_blood_worm_centipede\", \"apotheosis_insect_husk\", \"apotheosis_redstone\"")
  content = content:gsub("\"magic_liquid_charm\", \"magic_liquid_invisibility\"", "\"magic_liquid_charm\", \"magic_liquid_invisibility\", \"apotheosis_magic_liquid_attunium\", \"apotheosis_magic_liquid_velocium\", \"apotheosis_milk\"")

  ModTextFileSetContent(path, content)
end

do --Adds a special script to big bats so their bat projectiles accurately reflect creature shifts
  local content = ModTextFileGetContent("data/entities/animals/bigbat.xml")
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      execute_every_n_frame="-1"
      script_shot="mods/apotheosis/files/scripts/animals/bat_big_shoot.lua"
      remove_after_executed="0"
    />
  ]]))
  ModTextFileSetContent("data/entities/animals/bigbat.xml", tostring(xml))
end

do --Rework ants to behave like Apotheosis Ants for consistency
  local content = ModTextFileGetContent("data/entities/animals/ant.xml")
  local xml = nxml.parse(content)
  attrpath = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrpath.hp = "0.8"
  attrpath.max_hp = "0.8"

  xml:add_child(nxml.parse([[
	<LuaComponent
		script_damage_about_to_be_received="mods/apotheosis/files/scripts/animals/dmg_limit_1.lua"
		script_death="data/entities/animals/secret/ant_death.lua"
		>
	</LuaComponent>
  ]]))
  ModTextFileSetContent("data/entities/animals/ant.xml", tostring(xml))
end

do --Fix Tower Portal not working in Parallel worlds
  local path = "data/scripts/biomes/tower_end.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("mystery_teleport_back", "mystery_teleport_back_apotheosis")

  ModTextFileSetContent(path, content)
end

if ModIsEnabled("cheatgui") then  --Add Apotheosis items to CheatGUI
  ModLuaFileAppend("data/hax/special_spawnables.lua","mods/apotheosis/files/scripts/mod_compatibility/cheat_gui_list.lua")
end

do  --Fix Guiding Powder to work with new map layout
  ModLuaFileAppend("data/scripts/lib/utilities.lua","mods/apotheosis/files/scripts/mod_compatibility/utilities_lua_appends.lua")
end

do --Increase Parallel World Boss hp depending on PW count
  local path = "data/entities/animals/parallel/alchemist/parallel_alchemist.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/boss_health_multiplier_parallels.lua"
      execute_every_n_frame="5"
      execute_times="1"
      remove_after_executed="1"
      >
	  </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do --Hopefully, fixes an extremely rare bug where the sampo disappears under certain circumstances
  local path = "data/entities/animals/boss_centipede/reference_point.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/buildings/kolmi_missing_check.lua"
      execute_every_n_frame="120"
      execute_times="-1"
      remove_after_executed="0"
      >
	  </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do --Add Steve & Skoude creature shifting compatibility
  local path = "data/scripts/animals/necromancer_shop_spawn.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("EntityLoad%(\"data/entities/animals/necromancer_shop.xml\", pos_x, pos_y%)", "EntityLoad(GlobalsGetValue( \"apotheosis_cs_necromancer_shop_filepath\", \"data/entities/animals/necromancer_shop.xml\" ), pos_x, pos_y)")
  content = content:gsub("EntityLoad%(\"data/entities/animals/necromancer_super.xml\", pos_x, pos_y%)", "EntityLoad(GlobalsGetValue( \"apotheosis_cs_necromancer_super_filepath\", \"data/entities/animals/necromancer_super.xml\" ), pos_x, pos_y)")

  ModTextFileSetContent(path, content)
end

do --Slip Book of Kings in the Meditation Cube, only in the main world
  local path = "data/scripts/biomes/excavationsite_cube_chamber.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("spawn_teleporter%(x, y%)", "spawn_teleporter(x, y) local pw = GetParallelWorldPosition(x,y) if pw == 0 then EntityLoad(\"mods/apotheosis/files/entities/items/books/book_kings.xml\", x - 50, y + 50) end")

  ModTextFileSetContent(path, content)
end

do --Make glimmer spells work with plasma emitters
  local path = "data/scripts/projectiles/colour_spell.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("comps %= EntityGetComponent%( entity_id, \"ParticleEmitterComponent\" %)", "local plas_part = particle if particle == nil then plas_part = \"apotheosis_spark_invisible\" end comps = EntityGetComponent( entity_id, \"LaserEmitterComponent\" ) or {} for k=1,#comps do local v = comps[k] ComponentObjectSetValue2( v, \"laser\", \"beam_particle_type\", CellFactory_GetType(plas_part)) end comps = EntityGetComponent( entity_id, \"ParticleEmitterComponent\" )")

  ModTextFileSetContent(path, content)
end

--[[
--18/03/2024 Conga: Removed this functionality, original concern is it was too difficult to obtain self-damaging damage in Apotheosis but this proved unnecessary in hindsight
if ModSettingGet( "Apotheosis.spellrebalances" ) then --Make antiheal do innate self-damage
  local path = "data/entities/projectiles/deck/healhurt.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("knockback_force%=\"1.8\"", "knockback_force=\"1.8\" friendly_fire=\"1\" collide_with_shooter_frames=\"4\"")

  ModTextFileSetContent(path, content)
end
]]--

if ModSettingGet( "Apotheosis.spellrebalances" ) then --Make chainbolt better at hitting single targets
  local path = "data/scripts/projectiles/chain_bolt.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("%( target_id ~= prev_entity_id %) and %( target_id ~= prev_prev_entity_id %)", "(( target_id ~= prev_entity_id ) and ( target_id ~= prev_prev_entity_id ) or #targets == 1)")

  ModTextFileSetContent(path, content)
end

do --Reduce the duration of the blindness status effect by 25%
  local path = "data/entities/misc/effect_blindness.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"1200\"", "\"900\"")

  ModTextFileSetContent(path, content)
end

do --Necrobots & Super Necrobots can give the player a temporary one-up effect
  local path = "data/entities/animals/necrobot.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/necrobot_charmed.lua"
      execute_every_n_frame="180"
      execute_times="-1"
      remove_after_executed="0"
      >
	  </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do --Necrobots & Super Necrobots can give the player a temporary one-up effect
  local path = "data/entities/animals/necrobot_super.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/Apotheosis/files/scripts/animals/necrobot_charmed.lua"
      execute_every_n_frame="180"
      execute_times="-1"
      remove_after_executed="0"
      >
	  </LuaComponent>
  ]]))
  ModTextFileSetContent(path, tostring(xml))
end

do --Rare chance to make hiisi base spooked during herobrine hours
  if (hour >= 23 or hour <= 4) and (math.random(1,200) == 1) then
    local path = "data/scripts/biomes/snowcastle.lua"
    local content = ModTextFileGetContent(path)
    content = content:gsub("return true", "return false")

    ModTextFileSetContent(path, content)
  end
end

do --Make vases work properly with Creature Shifts
  local path = "data/scripts/props/physics_vase_damage.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"data/entities/animals/longleg%.xml\"", "GlobalsGetValue( \"apotheosis_cs_longleg_filepath\", \"data/entities/animals/longleg.xml\" )")

  ModTextFileSetContent(path, content)
end

do --Make vases work properly with Creature Shifts
  local path = "data/scripts/animals/mimic_damage.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"data/entities/animals/longleg%.xml\"", "GlobalsGetValue( \"apotheosis_cs_longleg_filepath\", \"data/entities/animals/longleg.xml\" )")

  ModTextFileSetContent(path, content)
end

do --Make vanilla hamis nests work properly with Creature Shifts
  local path = "data/scripts/buildings/spidernest.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("\"data/entities/animals/longleg%.xml\"", "GlobalsGetValue( \"apotheosis_cs_longleg_filepath\", \"data/entities/animals/longleg.xml\" )")

  ModTextFileSetContent(path, content)
end

do --Modify fungal shift
  local path = "data/scripts/magic/fungal_shift.lua"
  local content = ModTextFileGetContent(path)
  --Adding water
  local water_table_old = "\"water\", \"water_static\", \"water_salt\", \"water_ice\""
  local water_table_new = "\"water\", \"water_static\", \"water_salt\", \"water_ice\", \"water_fading\", \"apotheosis_water_fading_fast\""
  content = content:gsub(water_table_old, water_table_new)
  --Inserting check for fungal shift immunity
  local insert_function_search = "function fungal_shift%( entity, x, y, debug_no_limits %)"
  local insert_function_replace = [[
    function fungal_shift( entity, x, y, debug_no_limits )
  	if GameHasFlagRun("apotheosis_flag_no_tripping") then
		  local frame = GameGetFrameNum()
		  local last_frame = tonumber( GlobalsGetValue( "apotheosis_shift_block_last_frame", "-1000000" ) )
		  if frame > last_frame + 60*60*3 then --3 minute long cooldown between messages
			  GamePrintImportant( "$log_apotheosis_shift_blocked_name", "$log_apotheosis_shift_blocked_desc" )
			  GlobalsSetValue( "apotheosis_shift_block_last_frame", tostring(frame))
		  end
		  return
	  end
  ]]
  content = content:gsub(insert_function_search, insert_function_replace)
  --Cursed liquid thing
  content = content:gsub("from%.materials = %{ CellFactory_GetName%(held_material%) %}", "from.materials = apotheosis_fungal_shift_check_for_cursed_liquid(held_material)")
  local append_to_end = [[
    function apotheosis_fungal_shift_check_for_cursed_liquid(material)
      local material_cellname = CellFactory_GetName(material)
      local result = { material_cellname }
      if material_cellname == "apotheosis_cursed_liquid_red_static" or material_cellname == "apotheosis_cursed_liquid_red" then 
        result = { "apotheosis_cursed_liquid_red_static", "apotheosis_cursed_liquid_red" }
      end
      return result
    end
    table.insert(materials_from, { probability = 0.2, materials = { "apotheosis_cursed_liquid_red_static", "apotheosis_cursed_liquid_red" }, name_material = "apotheosis_cursed_liquid_red" })
  ]]
  content = content .. append_to_end

  ModTextFileSetContent(path, content)
end

--Post Ascension reward
--[[
if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02") and HasFlagPersistent("apotheosis_card_unlocked_sea_to_potion") == false then
  local path = "data/scripts/biomes/mountain/mountain_floating_island.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("spawn_sampo_spot%(x, y%)", "spawn_sampo_spot(x, y) \nCreateItemActionEntity( \"APOTHEOSIS_POTION_TO_SEA\", x, y ) \nEntityLoad(\"mods/apotheosis/files/entities/particles/upwards_trail.xml\", x, y)")

  ModTextFileSetContent(path, content)
end
]]--

--CreateItemActionEntity( \"APOTHEOSIS_POTION_TO_SEA\", x, y )
--EntityLoad(\"data/entities/items/pickup/potion_water.xml\", x, y)

--Debug data
--local path = "data/scripts/item_spawnlists.lua"
--local content = ModTextFileGetContent(path)
--print(content)

--[[
if ModIsEnabled("Apotheosis") then
  local path = "mods/apotheosis/files/scripts/biomes/newbiome/orbroom_15.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("EntityLoad%( \"mods/apotheosis/files/entities/items/orbs/custom/orb_15.xml\", x, y %)", "if not HasFlagPersistent(\"nee_ear_boss\") then EntityLoad( \"mods/apotheosis/files/entities/items/orbs/custom/orb_15.xml\", x, y ) else EntityLoad( \"data/entities/buildings/ear_boss_spot.xml\", x, y ) end")
  content = content:gsub("EntityLoad%( \"mods/apotheosis/files/entities/items/books/orbrooms/book_15.xml\", x %- 30, y %- 30 %)", "if not HasFlagPersistent(\"nee_ear_boss\") then EntityLoad( \"mods/apotheosis/files/entities/items/books/orbrooms/book_15.xml\", x - 30, y - 30 ) end")

  ModTextFileSetContent(path, content)
end
]]--

--if not HasFlagPersistent("nee_ear_boss") then EntityLoad( "mods/apotheosis/files/entities/items/orbs/custom/orb_15.xml", x, y ) else EntityLoad( "data/entities/buildings/ear_boss_spot.xml", x, y ) end
--if not HasFlagPersistent("nee_ear_boss") then EntityLoad( "mods/apotheosis/files/entities/items/books/orbrooms/book_15.xml", x - 30, y - 30 ) end

do -- Unique Heretical Eye interaction with the sun baby so it can get corrupted by him
  local path = "data/scripts/buildings/sun/spot_4.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[local w]], [[local t_h = EntityGetInRadiusWithTag( x, y, radius, "apotheosis_heretic" ) 

local h = (#t_h > 0)
local w]])
  content = content:gsub([[local ohno = false]], [[if h then 
		if ( string.find( essences_list, "heretic" ) == nil ) then
			local convert = EntityGetFirstComponentIncludingDisabled(entity_id, "MagicConvertMaterialComponent")
			ComponentSetValue2( convert, "to_material", CellFactory_GetType("apotheosis_blood_infectious") )
			ComponentSetValue2( comp2, "image_file", "mods/apotheosis/files/props_gfx/sun_small_heretic.png" )
			EntityAddComponent2(entity_id, "LuaComponent", {
				execute_on_added = false,
				script_source_file = "mods/apotheosis/files/scripts/buildings/sunbaby_heretic_effect.lua",
				execute_every_n_frame = 120,
			})
			essences_list = essences_list .. "heretic,"
			EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
			GameScreenshake( 30, x, y )
		end
	end
	
	local ohno = false
	
	if ( string.find( essences_list, "heretic" ) ~= nil ) then
		ohno = true
	end]])
  ModTextFileSetContent(path, content)
end

--Didn't look good...
--[[
local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")	
for k=1,#comps
do v = comps[k]
	local script_source = ComponentGetValue2(v,"script_source_file")
	if script_source == "data/scripts/buildings/sun/sunbaby_air_effect.lua" then
		ComponentSetValue2(v,"script_source_file","mods/apotheosis/files/scripts/buildings/sunbaby_air_heretic_effect.lua")
	end
end
]]--
