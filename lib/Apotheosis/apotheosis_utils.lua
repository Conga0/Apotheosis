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