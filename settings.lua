dofile("data/scripts/lib/mod_settings.lua")

---@diagnostic disable-next-line: lowercase-global
function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local currentLang = GameTextGetTranslatedOrNot("$current_language")

local congacat_cat_immortal_name = "Cat immortality"
local congacat_cat_immortal_desc = "Are cats immortal?"
local fairy_immortality_name = "Fairy immortality"
local fairy_immortality_desc = "Are Keiju immortal?"
local motd_setting_name = "Message of the Day"
local motd_setting_desc = "Will a MOTD be displayed at the start of each run?"
local seasonal_events_name = "Seasonal Events"
local seasonal_events_desc = "Are seasonal events enabled? \nFor example, Halloween, Apotheosis's Birthday, etc."
local boss_health_multiplayer_name = "Boss Health Multiplier"
local boss_health_multiplayer_formatting = " $0% HP"
local boss_health_multiplayer_desc = "Multiply all Bosses health by this much.\nFor those who seek extra durable opponents.\nMinibosses will also have their health boosted by a partial amount."
local custom_seed_name = "Set Custom Seed"
local custom_seed_desc = "Set a custom seed for the run. \nFor example: 0948274926, or hardcore" --Sneak in some secret seeds here "PuppyDogs"? --Hardmode? Towerclimb?
local organised_icons_name = "Organise Icons"
local organised_icons_desc = "Will Spells & Perks be organised with the vanilla perk list? \n \nFor example, if this is enabled, an immunity related perk will appear next to other \nimmunity perks in the progress log rather than at the bottom of the perk list. \nThe same applies to spells and creature icons."

local seasonal_forced_name = "Forced Seasonal Events"
local seasonal_forced_desc = "A list of Seasonal Events which can be forced"
local seasonal_forced_april_fools_name = "Forced April Fools"
local seasonal_forced_april_fools_desc = "Is the April Fools holiday forcefully enabled?"
local seasonal_forced_birthday_name = "Forced Birthday"
local seasonal_forced_birthday_desc = "Is the Apotheosis Birthday holiday forcefully enabled?"
local seasonal_forced_halloween_name = "Forced Halloween"
local seasonal_forced_halloween_desc = "Is Halloween forcefully enabled?"
local seasonal_forced_smissmass_name = "Forced Smissmass"
local seasonal_forced_smissmass_desc = "Is the Smissmass holiday forcefully enabled?"
local seasonal_forced_cirno_name = "Forced 9Ball Day"
local seasonal_forced_cirno_desc = "Is the 9Ball holiday forcefully enabled?"
local secret_golden_cape_name = "Golden Cape"
local secret_golden_cape_desc = "Is the Golden Cape cosmetic enabled? \nSome people may want to disable this if using custom character mods."

local exp_poly_name = "Expanded Polymorph Pool"
local exp_poly_desc = "Are Apotheosis Creatures added to the chaotic polymorph pool? \n \nThis is under a mod setting temporarily \nuntil this feature is added to the base game (non-beta branch)"

--Conga: I suppose at the end of the day I'm OK with having this be an option, but want to make sure the mod is designed around having this being enabled
local spellrebalances_name = "Spell Reworks"
local spellrebalances_desc = "Reworks various spells to have reduced mana costs to make them more practical.\nAlso reworks piercing, chainsaw & music note spells to be more inline with vanilla's spell balance.\nApotheosis is designed around this being enabled."

--Keybinds
local keybind_name = "Key Binds"
local keybind_desc = "Edit your Apotheosis keybinds"
local keybind_tutorial = "Hit the prompt below to input a new alt-fire binding.\nThe default setting is right mouse button."
local keybind_newbinding = "SET NEW BINDING"
local keybind_current = "Current alt-fire binding: "

  --Russian Translations
if currentLang == "русский" then

  congacat_cat_immortal_name = "Бессмертие кошек"
  congacat_cat_immortal_desc = "Являются ли кошки бессмертными?"
  fairy_immortality_name = "Бессмертие фей"
  fairy_immortality_desc = "Являются ли Кейдзю бессмертными?"
  motd_setting_name = "Сообщение дня"
  motd_setting_desc = "Будет ли сообщение дня отображаться в начале каждого забега?"
  seasonal_events_name = "Сезонные праздники"
  seasonal_events_desc = "Включены ли сезонные праздники? \nНапример, Хэллоуин, день рождения мода Apotheosis и т.д."
  boss_health_multiplayer_name = "Множитель здоровья босса"
  boss_health_multiplayer_formatting = " $0% ОЗ"
  boss_health_multiplayer_desc = "Умножает здоровье всех боссов на это количество. \nДля тех, кто ищет особо стойких противников. \nНе влияет на Колмисильмяна \nМини-боссы также будут иметь частичное увеличение здоровья. \nЭто можно изменить в середине игры, но не для всех боссов, \n не забудьте перезапустить игру после обновления множителя.\n \nДля создателей модов: \nЕсли ваш мод не указан в разделе совместимости на странице \n модов, это скорее всего не поможет, вам придётся добавить \n lua-компонент кода к вашим боссам. \nНе стесняйтесь обращаться ко мне за инструкциями или \n помощью, если это необходимо. \nМне будет проще всего ответить вам в \n Discord, Conga Lyne#2452. [ТОЛЬКО НА АНГЛИЙСКОМ]"

  seasonal_forced_name = "Запустить сезонные праздники"
  seasonal_forced_desc = "Список сезонных праздников, которые можно принудительно запустить"
  seasonal_forced_april_fools_name = "Запустить день смеха"
  seasonal_forced_april_fools_desc = "Включен ли принудительно праздник дурака?"
  seasonal_forced_birthday_name = "Запустить день рождения"
  seasonal_forced_birthday_desc = "Включен ли принудительно праздник дня рождения мода Apotheosis?"
  seasonal_forced_halloween_name = "Запустить Хэллоуин"
  seasonal_forced_halloween_desc = "Включен ли принудительно Хэллоуин?"
  seasonal_forced_smissmass_name = "Запустить Шмождество"
  seasonal_forced_smissmass_desc = "Включен ли принудительно праздник Шмождества?"
  secret_golden_cape_name = "Золотая накидка"
  secret_golden_cape_desc = "Включен ли аксессуар в виде золотой накидки? \nНекоторые могут захотеть выключить его, если используют пользовательские моды на персонажа."

end

--Japanese Translations
if currentLang == "日本語" then
  congacat_cat_immortal_name = "ネコの当たり判定無効化"
  congacat_cat_immortal_desc = "オンにすると、ネコが無敵になります。"
  fairy_immortality_name = "妖精の当たり判定無効化"
  fairy_immortality_desc = "オンにすると、妖精が無敵になります。"
  motd_setting_name = "今日のひとこと"
  motd_setting_desc = "オンにすると、ゲーム開始時にヒントが表示されるようになります。"
  seasonal_events_name = "季節イベント"
  seasonal_events_desc = "季節イベントを有効にしますか？\nハロウィンやMODのリリース記念日など、追加イベントがたくさん！"
  boss_health_multiplayer_name = "ボスのHP増加"
  boss_health_multiplayer_formatting = " $0% HP"
  boss_health_multiplayer_desc = "ボスのHPに倍率補正をかける上級者向けの設定です。\nコルミシルマには効果がありません。\nまた、ピットボスなどの中ボスにも一定程度効果が適用されます。\nプレイ中に設定を変更することも可能ですが、変更時はゲームを再起動してください。\nなお、ワークショップの対応MOD欄に記載されていないMODのボスには効果が適用されません。\nMOD製作者の方へ:適用させるためには専用のスクリプトが必要です。\n詳しくはDiscordでConga Lyne#2452にDMしてください。"
  particle_reduction_name = "パーティクル数減少"
  particle_reduction_desc = "一部のスペルから発生するパーティクルの数を減らします。\nPCが耐えられない場合はここを変更してください。"
  spoopy_graphics_name = "グラフィック差し替え"
  spoopy_graphics_desc = "オンにすると、一部のモブのグラフィックを差し替えます。\nデフォルトではオフになっています。"
  custom_seed_name = "カスタムシードの設定"
  custom_seed_desc = "指定したシード値でゲームを開始します。また、「hardcore」と入力すると、特殊なモードに入ることができます。"  --Conga: "hardcore" is the name of an actual secret seed in the mod so should probably be left as hardcore, but everything else can be translated
  organised_icons_name = "進捗画面での表示順変更"
  organised_icons_desc = "オンにすると、進捗画面での追加スペル・パークの表示順が変更されます。"
  
  seasonal_forced_name = "季節イベント"
  seasonal_forced_desc = "指定した季節イベントを発生させることができる設定です。"
  seasonal_forced_april_fools_name = "エイプリルフール"
  seasonal_forced_april_fools_desc = "エイプリルフールのイベント"
  seasonal_forced_birthday_name = "Apotheosis Modデー"
  seasonal_forced_birthday_desc = "本MODの記念日イベント"
  seasonal_forced_halloween_name = "ハロウィン"
  seasonal_forced_halloween_desc = "ハロウィンのイベント"
  seasonal_forced_smissmass_name = "Smissmass"
  seasonal_forced_smissmass_desc = "Smissmassイベント"
  seasonal_forced_cirno_name = "9Ball Day"
  seasonal_forced_cirno_desc = "9Ball Dayのイベント"
  secret_golden_cape_name = "ゴールデンNoita"
  secret_golden_cape_desc = "Noitaくんをゴールデンにする設定です。\nスキンMODを導入している場合は非推奨。"
  
  spellrebalances_name = "バランス調整"
  spellrebalances_desc = "オンにすると一部のスペルのマナ消費が低下し、より使いやすくなります。\nまた、貫通呪文、チェーンソー、音符など一部の強力なスペルは弱体化されます。\nこのMODのゲームバランスは、この設定がオンであることを前提に調整されています。"
end

--Key binding data
local listening = false
local there_has_been_input = false
local key_inputs ={}
local mouse_inputs = {}
local joystick_inputs = {}
local old_binding = ModSettingGet("Apotheosis.bind_altfire")
dofile_once("mods/apotheosis/lib/apotheosis/apotheosis_keycodes.lua")




local mod_id = "Apotheosis"
---@diagnostic disable-next-line: lowercase-global
mod_settings_version = 1
---@diagnostic disable-next-line: lowercase-global
mod_settings = 
{
  {
    image_filename = "mods/Apotheosis/files/ui_gfx/interface_gfx/apotheosis_settings.png",
    ---@diagnostic disable-next-line: undefined-global
    ui_fn = mod_setting_image,
  },
  {
    id = "congacat_cat_immortal",
    ui_name = congacat_cat_immortal_name,
    ui_description = congacat_cat_immortal_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "fairy_immortality",
    ui_name = fairy_immortality_name,
    ui_description = fairy_immortality_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "motd_setting",
    ui_name = motd_setting_name,
    ui_description = motd_setting_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "seasonal_events",
    ui_name = seasonal_events_name,
    ui_description = seasonal_events_desc,
    value_default = true,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "boss_health_multiplayer",
    ui_name = boss_health_multiplayer_name,
    ui_description = boss_health_multiplayer_desc,
    value_default = 100,
    value_min = 100,
    value_max = 1000,
    value_display_multiplier = 1,
    value_display_formatting = boss_health_multiplayer_formatting,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  {
    id = "organised_icons",
    ui_name = organised_icons_name,
    ui_description = organised_icons_desc,
    value_default = true,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "custom_seed",
    ui_name = custom_seed_name,
    ui_description = custom_seed_desc,
    value_default = "",
    text_max_length = 30,
    allowed_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789/.- ",
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  --[[
  {
    id = "exp_poly",
    ui_name = exp_poly_name,
    ui_description = exp_poly_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  ]]--
  -- Conga: Maybe this could be handled via config file in the mods folder?
  -- Would allow for people who really want the reworks disabled or need them to turn them off while maintaining unity everywhere else
  {
    id = "spellrebalances",
    ui_name = spellrebalances_name,
    ui_description = spellrebalances_desc,
    value_default = true,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
  },
  --Conga 16/11/2023: While I was enthusiastic to jump into finishing off the keybind code, I struggle to understand how it worked fundamentally; and do not see myself having the hours required to reverse engineer it's functionality unfortunately. I feel bad for controller users..
  --Might be possible to see how other mods handle it though? I know Noita Emotes has some stuff going on
  {
    category_id = "keybinds",
    ui_name = keybind_name,
    ui_description = keybind_desc,
    foldable = true,
    _folded = true,
    settings = {
      {
        id = "bind_altfire",
        ui_name = "",
        value_default = "key_code,mouse_code,2,joystick_code",
        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
          if listening then
            input_listen(key_inputs,mouse_inputs,joystick_inputs)
          end
    
          local _id = 0
          local function id()
              _id = _id + 1
              return _id
          end
    
          local keybind_string = ""
          local keybind_setting = ModSettingGet("Apotheosis.bind_altfire")
          local mode = "key_code"
          for code in string.gmatch(keybind_setting, "[^,]+") do
              if code == "mouse_code" or code == "key_code" or code == "joystick_code" then
                  mode = code
              else
                  if keybind_string ~= "" then
                      keybind_string = keybind_string .. " + "
                  end
                  code = tonumber(code)
                  if mode == "key_code" then
                      for key, value in pairs(key_codes) do
                          if value == code then
                              keybind_string = keybind_string .. key
                          end
                      end
                  elseif mode == "mouse_code" then
                      for key, value in pairs(mouse_codes) do
                          if value == code then
                              keybind_string = keybind_string .. key
                          end
                      end
                  elseif mode == "joystick_code" then
                      for key, value in pairs(joystick_codes) do
                          if value == code then
                              keybind_string = keybind_string .. key
                          end
                      end
                  end
              end
          end
    
          GuiColorSetForNextWidget(gui, 1, 1, 1, 0.5)
          GuiText(gui, 0, 0, keybind_tutorial)
          if listening then
              GuiColorSetForNextWidget(gui, 1, 0, 0, 1)
              GuiOptionsAdd(gui, GUI_OPTION.NonInteractive)
          end
          if GuiButton(gui, id(), 5, 5, keybind_newbinding) then
              key_inputs = {}
              mouse_inputs = {}
              joystick_inputs = {}
              listening = true
              there_has_been_input = false
              old_binding = ModSettingGet("Apotheosis.bind_altfire")
          end
          GuiText(gui, 0, 5, keybind_current .. keybind_string)
          GuiText(gui, 0, -5, " ")
        end
      },
    }
  },
}

--statue settings unlocks
local statue_count = 0
local flags_statues = {
	--1.0.0
	"apotheosis_card_unlocked_divinebeing", --Never forget o7
	"apotheosis_card_unlocked_boss_toxic_worm",
	"apotheosis_card_unlocked_musical_boss",
	"apotheosis_card_unlocked_blob_boss",
	"apotheosis_card_unlocked_divine_liquid",
	"apotheosis_card_unlocked_donated_beggar",
	"apotheosis_card_unlocked_rage_aura",
	"apotheosis_card_unlocked_cat_secret",
	--1.1.0
	"apotheosis_card_unlocked_essence_fungus",
	"apotheosis_card_unlocked_moon_fungus_unlock",
	"apotheosis_card_unlocked_pandora_chest_rain",
	"apotheosis_card_unlocked_boss_fire_lukki",
	"apotheosis_card_unlocked_secret_knowledge_of_kings",
  --Apotheosis
  "apotheosis_card_unlocked_boss_monolith",
  "apotheosis_card_unlocked_boss_flesh_monster",
  "apotheosis_card_unlocked_challenge_towerclimb_win",
  "apotheosis_card_unlocked_challenge_missingmagic_win",
  "apotheosis_card_unlocked_challenge_hardcore_win",
  "apotheosis_card_unlocked_musical_magic_played",
  --Endings
  "apotheosis_card_unlocked_ending_apotheosis_01",
  "apotheosis_card_unlocked_ending_apotheosis_02",
  "apotheosis_card_unlocked_ending_apotheosis_03",
  
}

for i=1, #flags_statues do
    if HasFlagPersistent(flags_statues[i]) then
        statue_count = statue_count + 1
    end
end


--Forced Seasonal Event Settings, only unlocked after beating the game
--if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_01") or HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02") or HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
--Conga: Haven't gone through with this change as it'd screw over people who left them forcefully enabled before the change was enacted, could force reset all of them to be turned off but, not sure.

--Forced Seasonal Event Settings, only unlocked after attaining at least 8 statues

if statue_count >= 8 then
table.insert(mod_settings,
  {
    category_id = "seasonal_events_forced",
    ui_name = seasonal_forced_name,
    ui_description = seasonal_forced_desc,
    foldable = true,
    _folded = true,
    settings = {
      {
        id = "seasonal_events_forced_april_fools",
        ui_name = seasonal_forced_april_fools_name,
        ui_description = seasonal_forced_april_fools_desc,
        value_default = false,
        ---@diagnostic disable-next-line: undefined-global
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_birthday",
        ui_name = seasonal_forced_birthday_name,
        ui_description = seasonal_forced_birthday_desc,
        value_default = false,
        ---@diagnostic disable-next-line: undefined-global
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_halloween",
        ui_name = seasonal_forced_halloween_name,
        ui_description = seasonal_forced_halloween_desc,
        value_default = false,
        ---@diagnostic disable-next-line: undefined-global
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_smissmass",
        ui_name = seasonal_forced_smissmass_name,
        ui_description = seasonal_forced_smissmass_desc,
        value_default = false,
        ---@diagnostic disable-next-line: undefined-global
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_cirno",
        ui_name = seasonal_forced_cirno_name,
        ui_description = seasonal_forced_cirno_desc,
        value_default = false,
        ---@diagnostic disable-next-line: undefined-global
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      }
    }
  })
end

if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) then
  table.insert(mod_settings,10,
  {
    id = "secret_golden_cape",
    ui_name = secret_golden_cape_name,
    ui_description = secret_golden_cape_desc,
    value_default = true,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  })
end

--[[
  --Conga: This is by all means functional, until the sounds are played; at which point they're immediately told to be paused until the game is unpaused.
  --I'm assuming this is something that must be changed in Fmod studio, but I see zero documentation on what audio tag the game is asking for
do -- Cat Button
  table.insert(mod_settings,
    {
      id = "cat_button",
      ui_name = "",
      ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
          if not in_main_menu then
                GuiLayoutBeginHorizontal(gui, 0, 0, false, 6, 6)
                GuiOptionsAddForNextWidget(gui, 28)
                GuiOptionsAddForNextWidget(gui, 4)
                GuiOptionsAddForNextWidget(gui, 6)
                local lmb, rmb = GuiImageButton(gui, im_id, 0, 0, "", "data/ui_gfx/animal_icons/cat_mocreeps_spoopy_skittle.png")
                GuiTooltip(gui, "Cat", "")
                if lmb then
                    dofile_once("mods/apotheosis/files/scripts/magic/cat_random_sound.lua")
                    CatMeow( GameGetCameraPos())
                end
                if rmb then
                    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_sneeze_01", GameGetCameraPos() )
                end
              GuiLayoutEnd(gui)
              GuiIdPop(gui)
          else    -- In main menu warning
              GuiImage(gui, im_id, 0, 0, "data/ui_gfx/inventory/icon_warning.png", 1, 1, 1)
          end
      end
    }
  )
end
]]--



--[[ This looks.. weird?
--Conga 26/05/2023: Might look better as a foldable, will need to try
--Inserted to guarantee it always loads at the bottom of the settings list
table.insert(mod_settings,
{
  id = "credits",
  ui_name = "\n \n \nCredits: \nConga Lyne - Mod Creator, anything not specifically listed here was made by me \n \nSorako Hinoguchi - Voicing Cats \n \nSpoopy (The One The Only Spoopy Boi#7859) - Creating fluffy cat sprites \nCreating Size 3 Blob Sprites, Creating Size 4 Blob static Sprite, Creating Size 5 Blob Idle Animation \n \nSquirrelly#6472 - Created the mana drain effect lua script, your mana wouldn't be stolen without their help \n \nBlueberry#1414 - Translating the mod to Russian\n \nExtol#0629 - Helping getting translation keys working, needed for custom perks to show up correctly \nAlso helped make split shot significantly less game breaking \n \nZathers - creator of nxml.lua, a file required for pixel scenes to work with mod compatability for me. \n \nHorscht#6086 - Helping a ton with getting code working, including the toxic worm nest structure to spawn in the world, \nand all others as a result. \n \nRib#1963 - Help with stain UV map generation, I probably wouldn't be able to have UV maps for enemies without his help \n \nKeithSammut - Provided base scripts needed for ceiling enemies \n \nCopi (Human#6606) - Helping think up some enemy ideas for unused sprites I had lying around. \n \nAnd you, for giving Apotheosis a try \nI hope you enjoyed playing it as much as I enjoyed making it <3",
  not_setting = true,
})
]]--


function ModSettingsUpdate( init_scope )
    ---@diagnostic disable-next-line: undefined-global
	local old_version = mod_settings_get_version( mod_id )
    ---@diagnostic disable-next-line: undefined-global
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
    ---@diagnostic disable-next-line: undefined-global
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
    ---@diagnostic disable-next-line: undefined-global
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end

-- I SILENCED THOSE ANNOYING GLOBAL WARNINGS!!!!!!!!!!!!!!! -COPI









function input_listen(key_inputs,mouse_inputs,joystick_inputs)
  local there_is_input = false
  for _, code in pairs(key_codes) do
      if InputIsKeyDown(code) then
          there_is_input = true
          there_has_been_input = true
          if has_value(key_inputs, code) == false then
              table.insert(key_inputs, code)
          end
      end
  end
  for _, code in pairs(mouse_codes) do
      if InputIsMouseButtonDown(code) then
          there_is_input = true
          there_has_been_input = true
          if has_value(mouse_inputs, code) == false then
              table.insert(mouse_inputs, code)
          end
      end
  end
  for _, code in pairs(joystick_codes) do
      if InputIsJoystickButtonDown(0, code) then
          there_is_input = true
          there_has_been_input = true
          if has_value(joystick_inputs, code) == false then
              table.insert(joystick_inputs, code)
          end
      end
  end

  --Decided variable forces only a single keybind for input and blocks combo inputs, can be remove to disable this limiter
  local decided = false
  local binding = "key_code,"
  for _, code in pairs(key_inputs) do
    if decided == true then break end
    binding = table.concat({binding,tostring(code),","})
    decided = true
  end
  binding = binding .. "mouse_code,"
  for _, code in pairs(mouse_inputs) do
    if decided == true then break end
    binding = table.concat({binding,tostring(code),","})
    decided = true
  end
  binding = binding .. "joystick_code,"
  for _, code in pairs(joystick_inputs) do
    if decided == true then break end
    binding = table.concat({binding,tostring(code),","})
    decided = true
  end
  binding = binding:sub(1, -2)
  ModSettingSet("Apotheosis.bind_altfire", binding)

  if there_has_been_input and not there_is_input then
      listening = false
      there_has_been_input = false
      key_inputs = {}
      mouse_inputs = {}
      joystick_inputs = {}
      if ModSettingGet("Apotheosis.bind_altfire") == "key_code,mouse_code,joystick_code" then
          ModSettingSet("Apotheosis.bind_altfire", old_binding)
      end
  end
end

function has_value (table, value)
  for _, v in ipairs(table) do
      if v == value then
          return true
      end
  end
  return false
end