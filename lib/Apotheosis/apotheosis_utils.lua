local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local set_content = ModTextFileSetContent
local get_content = ModTextFileGetContent

function MultiplyHP(filepath,enemy_list,multiplier,base)
  for k=1,#enemy_list
  do v = enemy_list[k]
    local path = filepath .. v .. ".xml"
    local content = get_content(path)
    if content ~= nil then
      local xml = nxml.parse(content)
      local max_hp
      attrpath = xml:first_of("Base"):first_of("DamageModelComponent").attr
      max_hp = attrpath.hp
      max_hp = max_hp * multiplier
      attrpath.max_hp = tostring(max_hp)
      attrpath.hp = tostring(max_hp)
      attrpath.blood_multiplier = tostring(1 / multiplier)
      set_content(path, tostring(xml))
    end
  end
end

--Technically buggy, but way faster to implement & maintain
function MultiplyHPOnBiome(biome_name, hp_scale, attack_speed)
	local biome_name = table.concat({"data/biome/",biome_name,".xml"})
  local attack_speed = 1 / attack_speed
  BiomeSetValue(biome_name, "game_enemy_hp_scale", hp_scale)
  BiomeSetValue(biome_name, "game_enemy_attack_speed", attack_speed)
end


function MultiplyHPSelective(filepath,multiplier,base)
  filepath = "data/entities/animals/" .. filepath .. ".xml"
  local content = get_content(filepath)
  if content ~= nil then
    local xml = nxml.parse(content)
    local max_hp
    attrpath = ""
    if base then
      attrpath = xml:first_of("Base"):first_of("DamageModelComponent").attr
    else
      attrpath = xml:first_of("DamageModelComponent").attr
    end
    hp = attrpath.hp
    hp = hp * multiplier
    max_hp = attrpath.max_hp or false
    if max_hp then
      max_hp = max_hp * multiplier
      attrpath.max_hp = tostring(max_hp)
    else
      attrpath.max_hp = tostring(hp)
    end
    attrpath.hp = tostring(hp)
    attrpath.blood_multiplier = tostring(1 / multiplier)
    set_content(filepath, tostring(xml))
  end
end


function MultiplyHPSelectiveBuilding(filepath,multiplier,base)
  filepath = "data/entities/buildings/" .. filepath .. ".xml"
  local content = get_content(filepath)
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
    set_content(filepath, tostring(xml))
  end
end

--Split a string separated by a specific character into a table
function SplitStringOnCharIntoTable(string, char)
  local list = {}
  for w in (string .. char):gmatch("([^" .. char .. "]*)" .. char) do
      table.insert(list, w)
  end
  return list
end

--Assemble a table of values into a single string split by a specific character
function TableToCharSeparatedString(list, char)
    local string = ""
    for i, v in ipairs(list) do
        string = string .. v
        if i ~= #list then
            string = string .. char
        end
    end
    return string
end

function lerp(a, b, weight)
	return a * weight + b * (1 - weight)
end

function lerpVec(x1, y1, x2, y2, weight)
	local x = lerp(x1, x2, weight)
	local y = lerp(y1, y2, weight)
	return x,y
end

function refreshSprites(entity_id)
  local spritecomps = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent")
  for k=1,#spritecomps
  do local v = spritecomps[k]
    EntityRefreshSprite(entity_id,v)
  end
end

function ToggleUI(player_id,enabled)
  EntitySetComponentIsEnabled(player_id,EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent"),enabled)
  EntitySetComponentIsEnabled(player_id,EntityGetFirstComponentIncludingDisabled(player_id,"InventoryGuiComponent"),enabled)
  EntitySetComponentIsEnabled(player_id,EntityGetFirstComponentIncludingDisabled(player_id,"CharacterDataComponent"),enabled)

  local children = EntityGetAllChildren( player_id ) 
  for k=1,#children
  do child = children[k]
      if EntityGetName( child ) == "inventory_quick" then 
          local inventory_items = EntityGetAllChildren(child) 
          if(inventory_items ~= nil) then 
              for z=1,#inventory_items
              do item = inventory_items[z]
                  if EntityHasTag( item, "wand" ) then 
                    EntitySetComponentIsEnabled(item,EntityGetFirstComponentIncludingDisabled(item,"AbilityComponent"),enabled)
                  end 
              end 
          end 
          break 
      end 
  end
end


function set_controls_enabled(enabled) --Disable's player's controls
  local player = EntityGetWithTag("player_unit")[1]
  if player then
      local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
      ComponentSetValue2(controls_component, "enabled", enabled)
      for prop, val in pairs(ComponentGetMembers(controls_component) or {}) do
          if prop:sub(1, 11) == "mButtonDown" then
              ComponentSetValue2(controls_component, prop, false)
          end
      end
  end
end

function PlayerCamControls(enabled)   --Disables camera locking onto player
  local player = EntityGetWithTag("player_unit")[1]
  local comp = EntityGetFirstComponentIncludingDisabled(player,"PlatformShooterPlayerComponent")
  ComponentSetValue2(comp,"center_camera_on_this_entity",enabled)
end
