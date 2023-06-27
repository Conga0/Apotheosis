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
local motd_setting_desc = "Will a MOTD be displayed at the start of each run? \nMay contain bonus hints for various secrets."
local seasonal_events_name = "Seasonal Events"
local seasonal_events_desc = "Are seasonal events enabled? \nFor example, Halloween, More Creep's Birthday, etc."
local boss_health_multiplayer_name = "Boss Health Multiplier"
local boss_health_multiplayer_formatting = " $0% HP"
local boss_health_multiplayer_desc = "Multiply all Bosses health by this much. \nFor those who seek extra durable opponents. \nDoes not affect Kolmisilma \nMinibosses will also have their health boosted by a partial amount. \n \nFor Modders: \nIf your mod isn't listed in the compatibility section of the mod page, \nthis likely won't boost it, you'll need to add a lua component to your bosses. \nDo not hesitate to contact me for instructions or help if needed. \nIt would be easiest for me to respond to you on discord, Conga Lyne#2452"
local particle_reduction_name = "Minimal Particles"
local particle_reduction_desc = "Reduce the number of particles spawned by certain spells. \nThis should help reduce lag if your computer's reaching it's limit."
local spoopy_graphics_name = "Alternate Graphics"
local spoopy_graphics_desc = "This setting toggles the alternate graphics of some creeps made by Spoopy. \nThis setting is turned off by default but can be enabled here."
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
local secret_golden_cape_name = "Golden Cape"
local secret_golden_cape_desc = "Is the Golden Cape cosmetic enabled? \nSome people may want to disable this if using custom character mods."

local exp_poly_name = "Expanded Polymorph Pool"
local exp_poly_desc = "Are Apotheosis Creatures added to the chaotic polymorph pool? \n \nThis is under a mod setting temporarily \nuntil this feature is added to the base game (non-beta branch)"


  --Russian Translations
if currentLang == "русский" then

  congacat_cat_immortal_name = "Бессмертие кошек"
  congacat_cat_immortal_desc = "Являются ли кошки бессмертными?"
  fairy_immortality_name = "Бессмертие фей"
  fairy_immortality_desc = "Являются ли Кейдзю бессмертными?"
  motd_setting_name = "Сообщение дня"
  motd_setting_desc = "Будет ли сообщение дня отображаться в начале каждого забега? \nМожет содержать бонусные подсказки с различными секретами."
  seasonal_events_name = "Сезонные праздники"
  seasonal_events_desc = "Включены ли сезонные праздники? \nНапример, Хэллоуин, день рождения мода Apotheosis и т.д."
  boss_health_multiplayer_name = "Множитель здоровья босса"
  boss_health_multiplayer_formatting = " $0% ОЗ"
  boss_health_multiplayer_desc = "Умножает здоровье всех боссов на это количество. \nДля тех, кто ищет особо стойких противников. \nНе влияет на Колмисильмяна \nМини-боссы также будут иметь частичное увеличение здоровья. \nЭто можно изменить в середине игры, но не для всех боссов, \n не забудьте перезапустить игру после обновления множителя.\n \nДля создателей модов: \nЕсли ваш мод не указан в разделе совместимости на странице \n модов, это скорее всего не поможет, вам придётся добавить \n lua-компонент кода к вашим боссам. \nНе стесняйтесь обращаться ко мне за инструкциями или \n помощью, если это необходимо. \nМне будет проще всего ответить вам в \n Discord, Conga Lyne#2452. [ТОЛЬКО НА АНГЛИЙСКОМ]"
  particle_reduction_name = "Минимум частиц"
  particle_reduction_desc = "Уменьшить количество частиц, создаваемых некоторыми заклинаниями. \nЭто поможет уменьшить задержку, если ваш компьютер достигает предела."
  spoopy_graphics_name = "Альтернативная графика"
  spoopy_graphics_desc = "Эта настройка включает альтернативную графику некоторых существ, созданных Spoopy. \nЭта настройка выключена по умолчанию, но может быть включена здесь."

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
    id = "particle_reduction",
    ui_name = particle_reduction_name,
    ui_description = particle_reduction_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  --[[
  {
    id = "spoopy_graphics",
    ui_name = spoopy_graphics_name,
    ui_description = spoopy_graphics_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
  },
  ]]--
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
  {
    id = "exp_poly",
    ui_name = exp_poly_name,
    ui_description = exp_poly_desc,
    value_default = false,
    ---@diagnostic disable-next-line: undefined-global
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
}

--statue settings unlocks
local statue_count = 0

--1.0.0
if HasFlagPersistent( "apotheosis_card_unlocked_divinebeing" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_musical_boss" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_blob_boss" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_divine_liquid" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_donated_beggar" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_rage_aura" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_cat_secret" ) then
  statue_count = statue_count + 1
end

--1.1.0
if HasFlagPersistent( "apotheosis_essence_fungus" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_moon_fungus_unlock" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_misc_pandora_chest_rain" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_boss_fire_lukki" ) then
  statue_count = statue_count + 1
end
if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) then
  statue_count = statue_count + 1
end


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
      }
    }
  })
end

if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) then
  table.insert(mod_settings,
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