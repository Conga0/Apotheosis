--TYPES:
---@class (exact) Weighted
---@field probability number

---@class (exact) Seed
---@field [1] number
---@field [2] number

---@type nxml
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local set_content = ModTextFileSetContent
local get_content = ModTextFileGetContent
year, month, day, hour, minute, second = GameGetDateAndTimeLocal()

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

function isButtonDown(key_name)
  local binding = ModSettingGet(table.concat({"Apotheosis.bind_",key_name}))
  local mode = "key_code"
  for code in string.gmatch(binding, "[^,]+") do
      if code == "mouse_code" or code == "key_code" or code == "joystick_code" then
          mode = code
      else
          code = tonumber(code)
          if mode == "key_code" then
              if InputIsKeyDown(code) then
                return true
              end
          elseif mode == "mouse_code" then
              if InputIsMouseButtonDown(code) then
                return true
              end
          elseif mode == "joystick_code" then
              if InputIsJoystickButtonDown(0, code) then
                return true
              end
          end
      end
  end
end

function buttonTranslatedName(key_name)
  local binding = ModSettingGet(table.concat({"Apotheosis.bind_",key_name}))
  local mode = "key_code"
  for code in string.gmatch(binding, "[^,]+") do
      if code == "mouse_code" or code == "key_code" or code == "joystick_code" then
          mode = code
      else
          code = tonumber(code)
          if mode == "key_code" then
              if InputIsKeyDown(code) then
                return true
              end
          elseif mode == "mouse_code" then
              if InputIsMouseButtonDown(code) then
                return true
              end
          elseif mode == "joystick_code" then
              if InputIsJoystickButtonDown(0, code) then
                return true
              end
          end
      end
  end
end

userseed_library = {
  dunkorslam = "00130639114681086286",
  snekgregory = "393592761468528034044338707123"
}

--Fairmod is the gift that keeps on giving
function userseed_check(seed)
  local userseed = ModSettingGet("fairmod.user_seed") or 0
  if userseed ~= 0 then
    if userseed:find(seed) then
      return true
    end
  end
  return false
end

function is_leap_year(year)
  return (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)
end

function days_in_month(month, year)
  if month == 2 then
      return is_leap_year(year) and 29 or 28
  elseif month == 4 or month == 6 or month == 9 or month == 11 then
      return 30
  else
      return 31
  end
end

function time_since(target_day, target_month, target_year, current_day, current_month, current_year)
  local diff_months = (current_year - target_year) * 12 + (current_month - target_month)

  if current_day < target_day then
      diff_months = diff_months - 1
  end

  local remaining_days = 0
  if current_day >= target_day then
      remaining_days = current_day - target_day
  else
      remaining_days = days_in_month(target_month, target_year) - target_day + current_day
  end

  return remaining_days, diff_months
end

--Bit-flag functions
function add_bit_flag(current, flag)
    return bit.bor(current, flag)
end

function remove_bit_flag(current, flag)
    return bit.band(current, bit.bnot(flag))
end

function has_bit_flag(current, flag)
    return bit.band(current, flag) ~= 0
end


---@generic T : Weighted
---@param t T[]
---@return T
---Function for picking a random table entry on `probability` as weight
function RandomFromTable(t)
    local total_weight = 0
    for _, entry in ipairs(t) do
        total_weight = total_weight + entry.probability
    end

    local rnd = Randomf(0, total_weight)
    for _, entry in ipairs(t) do
        if rnd <= entry.probability then
            return entry
        else rnd = rnd - entry.probability end
    end
    return t[#t] --Randomf has a miniscule chance to overflow
end

---@generic T : Weighted
---@param t T[]
---@param seed Seed
---@return T
---Function for picking a procedurally random table entry on `probability` as weight based on `seed`.
---Uses `math.random` to avoid being influenced by World Seed.
---Note: `probability` should not have more than 2 decimal places.
function ProceduralRandomFromTable(t, seed)
    local total_weight = 0
    for _, entry in ipairs(t) do
        total_weight = total_weight + entry.probability
    end

    math.randomseed(seed[1], seed[2])
    local rnd = math.random(0, total_weight * 100) --this only takes 2 decimal places but feel free to increase if needed
    rnd = rnd * .01
    for _, entry in ipairs(t) do
        if rnd <= entry.probability then
            return entry
        else rnd = rnd - entry.probability end
    end
    return t[#t]
end

---@param o table
---@return string
function DumpTable(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. DumpTable(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local holiday_list = {
  {
    name = "april_fools",
    date_function = function()
      if (month == 4) and (day == 1) then
        return true
      else
        return false
      end
    end
  },
  {
    name = "birthday",
    date_function = function()
      if (month == 7) and ((day >= 20) and (day <= 22)) then
        return true
      else
        return false
      end
    end
  },
  {
    name = "halloween",
    date_function = function()
      if (month == 10) and (day >= 15) then
        return true
      else
        return false
      end
    end
  },
  {
    name = "smissmass",
    date_function = function()
      if (month == 12) and (day >= 15) then
        return true
      else
        return false
      end
    end
  },
  {
    name = "cirno",
    date_function = function()
      if (month == 9) and (day == 9) then
        return true
      else
        return false
      end
    end
  }
}

function is_holiday_active(holiday_name)
  local is_being_forced = ModSettingGet(table.concat({"Apotheosis.seasonal_events_forced_",holiday_name}))
  for k=1,#holiday_list do
    if holiday_list[k].name == holiday_name then
      return is_being_forced or ModSettingGet("Apotheosis.seasonal_events") and holiday_list[k].date_function()
    end
  end
end

function draw_line(pos_x,pos_y,targ_x,targ_y,particle_name)
    local child = EntityLoad("mods/Apotheosis/files/entities/animators/electrosphere_fx.xml", targ_x, targ_y)
    local comp = EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent")
    ComponentSetValue2(comp, "mExPosition", pos_x, pos_y)
    if particle_name ~= "plasma_fading" then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent"),"emitted_material_name",particle_name)
    end
end


--[[
--Functions to read a csv file arbitrarily
--This was intended to be used in the settings file to make it easier to organise, but I had forgotten files cannot be loaded
function load_csv(csv_filepath)
  local translations = ModTextFileGetContent(csv_filepath)
  local translations_row = SplitStringOnCharIntoTable(translations, "\r")
  local translations_final = {}
  for k=1,#translations_row do
    local translation_column = SplitStringOnCharIntoTable(translations_row[k], ",")
    table.insert(translations_final,SplitStringOnCharIntoTable(translations_row[k], ","))
  end
  return translations_final, translation_length
end

local translation_data = load_csv("mods/Apotheosis/translations_settings.csv")

function translate(key,lang)
  local lang_pos = 0
  for k=1,#translation_data[1] do
    if translation_data[1][k] == lang then
      lang_pos = k
      break
    end
  end

  for k=1,#translation_data do
    if translation_data[k][1] == "\n" .. key then
      return translation_data[k][lang_pos] or translation_data[k][2]
    end
  end

end

print(translate("settings_apotheosis_cat_immortality_name","en"))
]]--

function isDayTime(pos_x,pos_y)
  local worldEntity = GameGetWorldStateEntity()
  local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
  local time = ComponentGetValue2(comp,"time")
  local skylight = GameGetSkyVisibility( pos_x, pos_y )

  if (time < 0.55 or time > 0.70) and (pos_y < 500 or skylight > 0.5) then
    return true
  else
    return false
  end
end

function getPlayer()
    local tags = {"player_unit", "polymorphed_player", "polymorphed_cessation"}
	for tag=1,#tags do
		local player = EntityGetWithTag(tags[tag])
		if #player > 0 then
			return player[1]
		end
	end
    return nil
end

function getDistanceFromTarget(entity_id,victim_id)
  if victim_id == 0 or victim_id == nil then return 0 end
  local x,y = EntityGetTransform(entity_id)
  local v_x,v_y = EntityGetTransform(victim_id)
  local distance = math.abs(v_y - y) + math.abs(v_x - x)
  return distance or 0
end

function getItemTypeFromTable(item_table)

  local spells = {}
  local wands = {}
  local items = {}

  for k=1,#item_table do
    local item = item_table[k]
    local ability_comp = EntityGetFirstComponentIncludingDisabled(item,"AbilityComponent") or 0
    
    if EntityHasTag(item,"card_action") then
      table.insert(spells,item)
    elseif ability_comp > 0 and ComponentGetValue2(ability_comp,"use_gun_script") == true then
      table.insert(wands,item)
    else
      table.insert(items,item)
    end
  end

  return items,wands,spells
end