--Appending/changing vanilla boss/creature data
dofile("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

--Pitboss can shoot blackholes if she fails a line of sight check too many times in a row, prevents tablet cheese
local content = ModTextFileGetContent("data/entities/animals/boss_pit/boss_pit.xml")
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
ModTextFileSetContent("data/entities/animals/boss_pit/boss_pit.xml", tostring(xml))

--Adds tag to wandstone so perk creation altar can detect it.. technically you can throw it into the sun because of this but, eh, nobody would ever do that.. right? I just wanna save on tags whenever possible
--Let Wand Stone enable tinkering regardless of if you have it held or not
local content = ModTextFileGetContent("data/entities/items/pickup/wandstone.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",poopstone"
local attrs = xml:first_of("GameEffectComponent").attr
attrs._tags = attrs._tags .. ",enabled_in_inventory"
ModTextFileSetContent("data/entities/items/pickup/wandstone.xml", tostring(xml))

--Adds tag to beamstone so perk creation altar can detect it.. technically you can throw it into the sun because of this but, eh, nobody would ever do that.. right? I just wanna save on tags whenever possible
local content = ModTextFileGetContent("data/entities/items/pickup/beamstone.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",poopstone"
ModTextFileSetContent("data/entities/items/pickup/beamstone.xml", tostring(xml))

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

do -- Remove some pixelscenes as they're being turned into biomes to recur infinitely with world width (essence eaters use pixelscenes that don't line up with the new world width)
  local path = "data/biome/_pixel_scenes.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("data/biome_impl/overworld/essence_altar_visual.png", "")
  content = content:gsub("data/biome_impl/overworld/essence_altar_desert_visual.png", "")
  content = content:gsub("data/biome_impl/overworld/essence_altar.png", "")
  content = content:gsub("data/biome_impl/overworld/essence_altar_desert.png", "")
  content = content:gsub("data/entities/buildings/essence_eater.xml", "")
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
    "triangle_gem",
    "wizard_firemage_greater",
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
    "blindgazer",
    "fairy_big_discord",
    "forsaken_eye",
    "gazer_cold_apotheosis",
    "gazer_greater",
    "gazer_greater_cold",
    "gazer_greater_sky",
    "ghost_bow",
    "musical_being",
    "sentry",
    "slime_leaker_weak",
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
    --"wizard_wands",
  }

  MultiplyHP("data/entities/animals/",enemy_list,multiplier,true)
end


do -- Add some new magical liquids to the Ancient Laboratory
  local path = "data/biome/liquidcave.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("FFF86868,FF7FCEEA,FFA3569F,FFC23055,FF0BFFE5", "FFF86868,FF7FCEEA,FFA3569F,FFC23055,FF0BFFE5,FF59FDD9,FFF6CBAE,FFF6F7FD")
  ModTextFileSetContent(path, content)
end


do -- Rework Vulnerability Curses.. hmm..
  local path = "data/scripts/projectiles/curse_wither_start.lua"
  local path_2 = "data/scripts/projectiles/curse_wither_end.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
	
	if ( comp ~= nil ) then]], [[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
	
    if ( comp ~= nil )and ComponentObjectGetValue2( comp, "damage_multipliers", name ) > 0 then]])
  content = content:gsub("mult = mult + 0.25", "mult = mult * 2")
  ModTextFileSetContent(path, content)

  local content = ModTextFileGetContent(path_2)
  content = content:gsub([[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
	
	if ( comp ~= nil ) then]], [[	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
	
    if ( comp ~= nil ) and ComponentObjectGetValue2( comp, "damage_multipliers", name ) > 0 then]])
  content = content:gsub("mult = mult - 0.25", "mult = mult * 0.5")
  ModTextFileSetContent(path2, content)
end


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

do -- Fixes Leviathan Portal to Coral Chest
  local path = "data/entities/buildings/teleport_teleroom_6.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("7480", "7060")
  content = content:gsub("-12288", "-12209")
  ModTextFileSetContent(path, content)
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

do -- Add a 1% chance for potions to be replaced with a potion from the rare pool
  local path = "data/entities/items/pickup/potion.xml"
  local content = ModTextFileGetContent(path)
  local xml = nxml.parse(content)
  xml:add_child(nxml.parse([[
    <LuaComponent 
    execute_on_added="1"
    remove_after_executed="1"
    call_init_function="1"
    script_source_file="mods/apotheosis/files/scripts/potions/potion_rare_spawninjector.lua" 
  ></LuaComponent>
  ]]))
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

do -- Limit enemies to dropping 100k gold at any given time, prevents lag in NG+ runs
  local path = "data/scripts/items/drop_money.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub("local x, y = EntityGetTransform( entity )", "if money > 100000 then money = 100000 end local x, y = EntityGetTransform( entity )")
  ModTextFileSetContent(path, content)
end

do -- Nerf Kantele & Ocarina notes to only hit once very 15 frames instead of once every 1 frame
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
  }

  for k=1,#notes do
    local path = pathprefix .. notes[k]
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    attrpath = xml:first_of("ProjectileComponent").attr
    attrpath.damage_every_x_frames = "15"
    ModTextFileSetContent(path, tostring(xml))
  end
end

do -- Nerf Plasma beams to hit every 10 frames instead of every 1 frame
  local pathprefix = "data/entities/projectiles/deck/"
  local notes = {
    "orb_laseremitter.xml",
    "orb_laseremitter_four.xml",
    "orb_laseremitter_cutter.xml",
  }

  for k=1,#notes do
    local path = pathprefix .. notes[k]
    local content = ModTextFileGetContent(path)
    local xml = nxml.parse(content)
    attrpath = xml:first_of("ProjectileComponent").attr
    attrpath.damage_every_x_frames = "15"
    ModTextFileSetContent(path, tostring(xml))
  end
end

do -- Change sunseed sprite filepath for Perk Creation Anvil
  local path = "data/entities/items/pickup/sun/sunseed.xml"
  local content = ModTextFileGetContent(path)
  content = content:gsub("data/items_gfx/goldnugget_01.png", "mods/apotheosis/files/items_gfx/goldnugget_01_alt.png")
  ModTextFileSetContent(path, content)
end

do --Softcap heart spawns at 1,000 hp
  ModLuaFileAppend( "data/scripts/biome_scripts.lua", "mods/Apotheosis/files/scripts/biome_scripts_appends.lua" )
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


do  --File override approach for organising animal icons
  if ModSettingGet( "Apotheosis.organised_icons" ) == true then
    local content = ModTextFileGetContent("mods/apotheosis/files/ui_gfx/animal_icons/list_override.txt")
    ModTextFileSetContent("data/ui_gfx/animal_icons/_list.txt",content)
  end
end

do -- gsub new Creeps into Summon Egg's spawn table
  local path = "data/scripts/items/egg_hatch.lua"
  local content = ModTextFileGetContent(path)
  content = content:gsub([[fire = { {"firebug", 3}, {"bigfirebug"} },]], [[fire = { {"firebug", 3}, {"bigfirebug"}, {"whisp", 10} },]])
  content = content:gsub([[chilly = { {"tentacler_small"}, {"tentacler"} },]], [[chilly = { {"tentacler_small"}, {"tentacler"}, {"tentacler_big"} },]])
  content = content:gsub([[red = { {"bat", 3}, {"tentacler_small"}, {"tentacler"} },]], [[red = { {"bat", 3}, {"fairy_big", 2}, {"tentacler_small"}, {"tentacler"} },]])
  ModTextFileSetContent(path, content)
end

do  -- Robots take damage from Veloium
  local path = "data/entities/base_enemy_robot.xml"
  local xml = nxml.parse(ModTextFileGetContent(path))

  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.materials_that_damage = attrs.materials_that_damage .. ",apotheosis_magic_liquid_velocium"
  attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0003"

  ModTextFileSetContent(path, tostring(xml))
end


do -- Piercing only hit 5 times per modifier
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
  content = content:gsub([[	local opts = { "NOLLA", "DAMAGE_RANDOM", "RANDOM_SPELL", "RANDOM_PROJECTILE", "RANDOM_MODIFIER", "RANDOM_STATIC_PROJECTILE", "DRAW_RANDOM", "DRAW_RANDOM_X3", "DRAW_3_RANDOM" }]], [[	local opts = { "NOLLA", "DAMAGE_RANDOM", "RANDOM_SPELL", "RANDOM_PROJECTILE", "RANDOM_MODIFIER", "RANDOM_STATIC_PROJECTILE", "DRAW_RANDOM", "DRAW_RANDOM_X3", "DRAW_3_RANDOM", "APOTHEOSIS_RANDOM_HOMING" }]])
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
