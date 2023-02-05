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


--Maybe only do this for an optional "hardmode? Unsure"
--Goal is for the mod to be accessible to anyone but it gets so freakin boring 1 shotting everything
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

  for k=1,#enemy_list
  do v = enemy_list[k]
    local path = "data/entities/animals/crypt/" .. v .. ".xml"
    print("Filepath is " .. path)
    local content = ModTextFileGetContent(path)
    if content ~= nil then
      local xml = nxml.parse(content)
      local max_hp = xml:first_of("Base"):first_of("DamageModelComponent").attr.hp
      max_hp = max_hp * multiplier
      xml:first_of("Base"):first_of("DamageModelComponent").attr.max_hp = tostring(max_hp)
      xml:first_of("Base"):first_of("DamageModelComponent").attr.hp = tostring(max_hp)
      ModTextFileSetContent(path, tostring(xml))
    end
  end
end