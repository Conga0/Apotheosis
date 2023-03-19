local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

function MultiplyHP(filepath,enemy_list,multiplier,base)
  for k=1,#enemy_list
  do v = enemy_list[k]
    local path = filepath .. v .. ".xml"
    local content = ModTextFileGetContent(path)
    if content ~= nil then
      local xml = nxml.parse(content)
      local max_hp
      attrpath = xml:first_of("Base"):first_of("DamageModelComponent").attr
      max_hp = attrpath.hp
      max_hp = max_hp * multiplier
      attrpath.max_hp = tostring(max_hp)
      attrpath.hp = tostring(max_hp)
      attrpath.blood_multiplier = tostring(1 / multiplier)
      ModTextFileSetContent(path, tostring(xml))
    end
  end
end

--Technically buggy, but way faster to implement & maintain
function MultiplyHPOnBiome(biome_name, hp_scale, attack_speed)
	local biome_name = "data/biome/" .. biome_name .. ".xml"
  local attack_speed = 1 / attack_speed
  BiomeSetValue(biome_name, "game_enemy_hp_scale", hp_scale)
  BiomeSetValue(biome_name, "game_enemy_attack_speed", attack_speed)
end


function MultiplyHPSelective(filepath,multiplier,base)
  filepath = "data/entities/animals/" .. filepath .. ".xml"
  local content = ModTextFileGetContent(filepath)
  if content ~= nil then
    local xml = nxml.parse(content)
    local max_hp
    attrpath = ""
    if base then
      attrpath = xml:first_of("Base"):first_of("DamageModelComponent").attr
    else
      attrpath = xml:first_of("DamageModelComponent").attr
    end
    max_hp = attrpath.hp
    max_hp = max_hp * multiplier
    attrpath.max_hp = tostring(max_hp)
    attrpath.hp = tostring(max_hp)
    attrpath.blood_multiplier = tostring(1 / multiplier)
    ModTextFileSetContent(filepath, tostring(xml))
  end
end