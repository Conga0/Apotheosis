dofile("data/scripts/lib/mod_settings.lua")

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
local boss_health_multiplayer_desc = "Multiply all Bosses health by this much. \nFor those who seek extra durable opponents. \nDoes not affect Kolmisilma \nMinibosses will also have their health boosted by a partial amount. \nThis can be changed mid-run but will not update once a boss has already spawned.\n \nFor Modders: \nIf your mod isn't listed in the compatibility section of the mod page, \nthis likely won't boost it, you'll need to add a lua component to your bosses. \nDo not hesitate to contact me for instructions or help if needed. \nIt would be easiest for me to respond to you on discord, Conga Lyne#2452"
local particle_reduction_name = "Minimal Particles"
local particle_reduction_desc = "Reduce the number of particles spawned by certain spells. \nThis should help reduce lag if your computer's reaching it's limit."
local spoopy_graphics_name = "Alternate Graphics"
local spoopy_graphics_desc = "This setting toggles the alternate graphics of some creeps made by Spoopy. \nThis setting is turned off by default but can be enabled here."
local mod_compat_mode_conjurer_name = "Conjurer extra Compatibility Mode"
local mod_compat_mode_conjurer_desc = "Some people may have issues with this mod not loading into Conjurer properly. \nIf this happens, try enabling this option and loading conjurer again. \n \nThis option is on by default but can be turned off if you wish to \nhave the pixel scenes & bosses appear in conjurer worlds. \n \nIf Conjurer still fails to load despite having this turned on, although unlikely, \nit may be a mod compatibility issue with something else, \nperhaps try disabling mods to find the troublesome one. \n \nIf nothing else works please let me know to by filing a bug report to me. \nIt would be easiest for me to reach & investigate your report at the discord link below: \nhttps://discord.gg/gtyGnv8Pxk"
local mod_compat_mode_spell_evolution_name = "Spell Evolution Compatibility Mode"
local mod_compat_mode_spell_evolution_desc = "Turn this setting on if youre playing with the Spell Evolution mod to fix it.\n \nAs far as I can tell, a bug in Spell Evolutions causes it to break if a modded spell \nUses translation keys for their name and/or description. \n \nUnfortunately there's nothing I can do about this as it's not my mod, \nand I have no intention to remove the translation keys \nas I hope to use them one day in the event \nIm offered a translation for the mod to another language. \nHowever, I can put a setting in to optionally let you use the spells without \ntranslation keys to get around the issue."
local custom_seed_name = "Set Custom Seed"
local custom_seed_desc = "Set a custom seed for the run. \nFor example: 0948274926, or PuppyDogs" --Sneak in some secret seeds here

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
  mod_compat_mode_conjurer_name = "Режим совместимости: Conjurer"
  mod_compat_mode_conjurer_desc = "У некоторых людей могут возникнуть проблемы с тем, что этот мод \n не загружается вместе с модом Conjurer должным образом. \nЕсли это произошло, попробуйте включить этот параметр и загрузить \n мод Conjurer снова. \n \nЭта опция включена по умолчанию, но может быть выключена, если вы хотите, \n чтобы пиксельные сцены и боссы появлялись в мирах Conjurer. \n \nЕсли Conjurer всё ещё не загружается, несмотря на включение этого параметра, \n хотя это маловероятно, может быть проблема совместимости мода с чем-то \n другим, возможно, попробуйте отключить все моды поочерёдно, \n чтобы найти проблемный. \nЕсли ничего не помогает, пожалуйста, сообщите мне об этом, написав \n сообщение об ошибке. \nМне будет проще всего связаться и изучить ваше сообщение из discord: \n https://discord.gg/gtyGnv8Pxk \n [ТОЛЬКО НА АНГЛИЙСКОМ]"
  mod_compat_mode_spell_evolution_name = "Режим совместимости: Spell Evolution"
  mod_compat_mode_spell_evolution_desc = "Включите этот параметр, если вы играете с модом Spell Evolution, \n чтобы исправить ошибки в нём.\n \nНасколько я могу судить, ошибка в Spell Evolutions приводит к тому, \n что он ломается, если модифицированное заклинание \n использует ключи перевода для своего имени и/или описания. \n \nК сожалению, я ничего не могу с этим поделать, поскольку это не мой \n мод, и у меня нет намерения удалять ключи перевода, поскольку \n я надеюсь использовать их однажды в случае, если мне \n предложат перевести мод на другие языки. \nОднако, я могу сделать настройку, которая позволит вам \n использовать заклинания без ключей перевода, чтобы обойти эту \n проблему."

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
mod_settings_version = 1
mod_settings = 
{
  {
    image_filename = "mods/Apotheosis/files/ui_gfx/interface_gfx/sunlight.png",
    ui_fn = mod_setting_image,
  },
  {
    id = "congacat_cat_immortal",
    ui_name = congacat_cat_immortal_name,
    ui_description = congacat_cat_immortal_desc,
    value_default = true,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "fairy_immortality",
    ui_name = fairy_immortality_name,
    ui_description = fairy_immortality_desc,
    value_default = false,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "motd_setting",
    ui_name = motd_setting_name,
    ui_description = motd_setting_desc,
    value_default = false,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "seasonal_events",
    ui_name = seasonal_events_name,
    ui_description = seasonal_events_desc,
    value_default = true,
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
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  {
    id = "particle_reduction",
    ui_name = particle_reduction_name,
    ui_description = particle_reduction_desc,
    value_default = false,
    scope = MOD_SETTING_SCOPE_RUNTIME,
  },
  {
    id = "spoopy_graphics",
    ui_name = spoopy_graphics_name,
    ui_description = spoopy_graphics_desc,
    value_default = false,
    scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
  },
  {
    id = "mod_compat_mode_conjurer",
    ui_name = mod_compat_mode_conjurer_name,
    ui_description = mod_compat_mode_conjurer_desc,
    value_default = true,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "mod_compat_mode_spell_evolution",
    ui_name = mod_compat_mode_spell_evolution_name,
    ui_description = mod_compat_mode_spell_evolution_desc,
    value_default = false,
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  },
  {
    id = "custom_seed",
    ui_name = custom_seed_name,
    ui_description = custom_seed_desc,
    value_default = "",
    text_max_length = 30,
    allowed_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789/.- ",
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
    settings = {
      {
        id = "seasonal_events_forced_april_fools",
        ui_name = seasonal_forced_april_fools_name,
        ui_description = seasonal_forced_april_fools_desc,
        value_default = false,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_birthday",
        ui_name = seasonal_forced_birthday_name,
        ui_description = seasonal_forced_birthday_desc,
        value_default = false,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_halloween",
        ui_name = seasonal_forced_halloween_name,
        ui_description = seasonal_forced_halloween_desc,
        value_default = false,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
      },
      {
        id = "seasonal_events_forced_smissmass",
        ui_name = seasonal_forced_smissmass_name,
        ui_description = seasonal_forced_smissmass_desc,
        value_default = false,
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
    scope = MOD_SETTING_SCOPE_NEW_GAME,
  })
end



--[[ This looks.. weird?
--Inserted to guarantee it always loads at the bottom of the settings list
table.insert(mod_settings,
{
  id = "credits",
  ui_name = "\n \n \nCredits: \nConga Lyne - Mod Creator, anything not specifically listed here was made by me \n \nSorako Hinoguchi - Voicing Cats \n \nSpoopy (The One The Only Spoopy Boi#7859) - Creating fluffy cat sprites \nCreating Size 3 Blob Sprites, Creating Size 4 Blob static Sprite, Creating Size 5 Blob Idle Animation \n \nSquirrelly#6472 - Created the mana drain effect lua script, your mana wouldn't be stolen without their help \n \nBlueberry#1414 - Translating the mod to Russian\n \nExtol#0629 - Helping getting translation keys working, needed for custom perks to show up correctly \nAlso helped make split shot significantly less game breaking \n \nZathers - creator of nxml.lua, a file required for pixel scenes to work with mod compatability for me. \n \nHorscht#6086 - Helping a ton with getting code working, including the toxic worm nest structure to spawn in the world, \nand all others as a result. \n \nRib#1963 - Help with stain UV map generation, I probably wouldn't be able to have UV maps for enemies without his help \n \nKeithSammut - Provided base scripts needed for ceiling enemies \n \nCopi (Human#6606) - Helping think up some enemy ideas for unused sprites I had lying around. \n \nAnd you, for giving Apotheosis a try \nI hope you enjoyed playing it as much as I enjoyed making it <3",
  not_setting = true,
})
]]--


function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end