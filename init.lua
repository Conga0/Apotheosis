dofile("data/scripts/lib/utilities.lua")

--local modCompatibilityConjurer = ModSettingGet( "Apotheosis.mod_compat_mode_conjurer" )
local modCompatibilitySpellEvolutions = ModSettingGet( "Apotheosis.mod_compat_mode_spell_evolution" )
local motdSetting = ModSettingGet( "Apotheosis.motd_setting" )
local seasonalSetting = ModSettingGet( "Apotheosis.seasonal_events" )
local spoopyGFXSetting = ModSettingGet( "Apotheosis.spoopy_graphics" )

local seasonalForced_AprilFools = ModSettingGet( "Apotheosis.seasonal_events_forced_april_fools" )
local seasonalForced_Birthday = ModSettingGet( "Apotheosis.seasonal_events_forced_birthday" )
local seasonalForced_Halloween = ModSettingGet( "Apotheosis.seasonal_events_forced_halloween" )
local seasonalForced_Smissmass = ModSettingGet( "Apotheosis.seasonal_events_forced_smissmass" )

local experimental_biomemap = ModSettingGet( "Apotheosis.exp_biomemap" )

local capeSetting = ModSettingGet( "Apotheosis.secret_golden_cape" )

--Debug flag removals, be sure to remove before release!!!
--RemoveFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" )
--RemoveFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings_spell" )

--Spawn Bosses

--This was a coding marathon and a half, huge shoutouts to Horscht for the help on this one.
--And Zathers for making this lua file
--Note: This has been moved lower down for cleaner organisation & implementing mod compatibility
--Note: 16/06/2023 Some boss spawns may be moved into biome files as well

--Retroactively add flags under new name if the player has the previous ones
local flags = {
  { "apotheosis_misc_pandora_chest_rain", "apotheosis_card_unlocked_pandora_chest_rain" },
  { "apotheosis_essence_fungus", "apotheosis_card_unlocked_essence_fungus" },
  { "apotheosis_moon_fungus_unlock", "apotheosis_card_unlocked_moon_fungus_unlock" }
}

for k=1,#flags
do local v = flags[k]
  if HasFlagPersistent(v[1]) then
    AddFlagPersistent(v[2])
    RemoveFlagPersistent(v[1])
  end
end




-- Spell Unlock Fixes
-- If someone attains a spell through another mod, twitch integration, etc, this is just to make sure they aren't getting unlocks they shouldn't.
-- They'll still get the spell, it just won't be added to their permanent record
-- Rat bite isn't "verified" because it's a funny spell

-- Protect spell progress in case of accidental unlocks
do
  for _, entry in ipairs({
    "divinebeing",
    "boss_toxic_worm",
    "musical_boss",
    "blob_boss",
    "fire_lukki",
    "cat_secret",
    "orb_12",
    "orb_14",
    "orb_15",
    "orb_16",
    "lost_alchemy",
    "omega_cross",
  }) do
    local progressflag = "apotheosis_card_unlocked_" .. entry
    if HasFlagPersistent( progressflag ) then
      AddFlagPersistent( progressflag .. "_spell" )
    else
      RemoveFlagPersistent( progressflag .. "_spell" )
    end
  end
end

--Ensure this flag is never enabled, so spells can properly be disabled in hardcore mode while still appearing in the progress log
RemoveFlagPersistent("this_should_never_spawn")












--Description fix for Ghostly Vision Perk
--Wow, I've come a long way since then.
--Thankyou for all the help, gamers!

local content = ModTextFileGetContent("data/translations/common.csv")
ModTextFileSetContent("data/translations/common.csv", content .. [[
perk_apotheosis_ghostly_vision,Ghostly Vision,Призрачное зрение,,,,,,,,,,,,
perk_apotheosis_ghostly_vision_description,You can see things which aren't there.. Without assistance.,"Вы можете видеть вещи, которых тут нет... Без посторонней помощи.",,,,,,,,,,,,
perk_apotheosis_ghostly_vision,Ghostly Vision,Призрачное зрение,,,,,,,,,,,,
perk_apotheosis_ghostly_vision_description,You can see things which aren't there.. Without assistance.,"Вы можете видеть вещи, которых тут нет... Без посторонней помощи.",,,,,,,,,,,,
perk_apotheosis_rage_aura,Enraging Aura,Раздражающая аура,,,,,,,,,,,,
perk_apotheosis_rage_aura_description,Creatures are sent into a blind rage by your presence.,От вашего присутствия существа впадают в слепую ярость.,,,,,,,,,,,,
book_apotheosis_divine_liquid,Tablet of Apotheosis,Скрижаль Апофеоза,,,,,,,,,,,,
book_apotheosis_divine_liquid_description,"Long have been the days since the universe was in union. \nWhen Slime was no different from above and below was no different from slime. \nSome species have adapted to these changes however, excessively, and became attuned to the pinnacles and depths of this world. \nThey must distance themselves with truly divine purpose.","Давно прошли те дни, когда вселенная была в единстве. \nКогда слизь не отличалась от верха, а низ не отличался от слизи. \nНекоторые виды, однако, чрезмерно приспособились к этим изменениям и стали сонастроены с вершинами и глубинами этого мира. \nОни должны отдаляться с истинно божественной целью.",,,,,,,,,,,,
book_apotheosis_materia_conversion,Alchemist's Notes,Записи алхимика,,,,,,,,,,,,
book_apotheosis_materia_conversion_description,"Transmutation.. Materia Conversion. \nFor years I've dedicated my life to this art, only to foolishly trick myself. \nFor years I thought Materia Conversion could only be used on solid matter, \nBut only now in my last few days I've come to learn it can be harnessed on magic as well. \nI can only hope the fruits of my labour will not forgotten.","Трансмутация. Превращение материи. \nГодами я посвящал свою жизнь этому искусству, но только для того, чтобы обмануть самого себя. \nДолгие годы я думал, что преобразование материи можно использовать только в твёрдой материи, \nНо только теперь, в последние дни, я узнал, что его можно использовать и в магии. \nОстаётся надеяться, что плоды моего труда не будут забыты.",,,,,,,,,,,,
book_apotheosis_materia_conversion_spell,Alchemist's Notes,Записи алхимика,,,,,,,,,,,,
book_apotheosis_trophy_room,Alchemist's Notes,Записи алхимика,,,,,,,,,,,,
book_apotheosis_trophy_room_description,"I have come to learn this Tree was deemed unfitting of.. certain.. accomplishments by the gods. \nCross the lava, descend where you would not normal. \nThere they will humour you.","Я узнал, что боги сочли это Дерево непригодным для... определённых... свершений. \nПересеките лаву, спуститесь туда, куда обычно не спускаются. \nТам они будут над вами насмехаться.",,,,,,,,,,,,
book_apotheosis_trophy_room_description_purgatory,"I have come to learn this Tree was deemed unfitting of.. certain.. accomplishments by the gods. \nSpelunk east before you visit their place of worship, cross the fungus, holding the ceiling dear. \nThere they will humour you.","Я узнал, что боги сочли это Дерево непригодным для... определённых... свершений. \nСпешите на Восток, прежде чем посетить место их поклонения, перейдите по грибку, держась за потолок. \nТам они будут над вами насмехаться.",,,,,,,,,,,,
mat_cloth,Cloth,Ткань,,,,,,,,,,,,
book_apotheosis_cat_rat,Cat Lover's Notes,Записи любителя кошек,,,,,,,,,,,,
book_apotheosis_cat_rat_description,My cats seem scared of normal rats.. \nBut have an irresistible hate towards magical rats for some reason. \nIt's kind of cute.. But I can't brush away the feeling they distance themselves with truly divine purpose...,"Мои кошки боятся обычных крыс... \nНо почему-то испытывают непреодолимую ненависть к магическим крысам. \nЭто даже мило... Но я не могу избавиться от ощущения, что они отдаляются от меня с поистине божественной целью...",,,,,,,,,,,,
item_apotheosis_chest_cursed,Pandora's Chest,Сундук Пандоры,,,,,,,,,,,,
status_apotheosis_magicwet_ui,Magical Wetness,Магическая влажность,,,,,,,,,,,,
statusdesc_apotheosis_magicwet_ui,Wet clothes protect you from fire.,Мокрая одежда защищает вас от огня.,,,,,,,,,,,,
status_apotheosis_magicfire_ui,Magical Fire,Волшебный огонь,,,,,,,,,,,,
statusdesc_apotheosis_magicfire_ui,You're on fire! Find water quickly!,Вы горите! Быстро найдите воду!,,,,,,,,,,,,
status_apotheosis_magicurine_ui,Magical Jarate,Волшебный Банкате,,,,,,,,,,,,
statusdesc_apotheosis_magicurine_ui,Wet clothes protect you from fire. \nYou sense an increased chance of receiving critical strikes.,Мокрая одежда защищает вас от огня. \nВы чувствуете повышенную вероятность получения критических попаданий по себе.,,,,,,,,,,,,
status_apotheosis_magicpolymorph_ui,Magical Polymorph,Волшебный полиморфизм,,,,,,,,,,,,
statusdesc_apotheosis_magicpolymorph_ui,You have been polymorphed into a vulnerable sheep!,Вы превратились в беззащитную овцу!,,,,,,,,,,,,
log_apotheosis_reality_mutation_00,YOU SENSE THE REALITY HAS SHIFTED,"ВЫ ЧУВСТВУЕТЕ, ЧТО В РЕАЛЬНОСТИ ЧТО-ТО СМЕСТИЛОСЬ",,,,,,,,,,,,
log_apotheosis_reality_mutation_01,YOU FEEL THE WORLD'S CREATURES HAVE CHANGED,"ВЫ ЧУВСТВУЕТЕ, ЧТО СУЩЕСТВА МИРА ИЗМЕНИЛИСЬ",,,,,,,,,,,,
log_apotheosis_reality_mutation_02,THE WORLD'S LIFE HAS BEEN SHAKEN,ЖИЗНЬ МИРА ПОШАТНУЛАСЬ,,,,,,,,,,,,
log_apotheosis_reality_mutation_03,YOU SENSE THE PATH OF EVOLUTION HAS CHANGED,"ВЫ ЧУВСТВУЕТЕ, ЧТО ПУТЬ ЭВОЛЮЦИИ ИЗМЕНИЛСЯ",,,,,,,,,,,,
log_apotheosis_reality_mutation_04,YOU FEEL REALITY HAS BEEN ALTERED,"ВЫ ЧУВСТВУЕТЕ, ЧТО В РЕАЛЬНОСТИ ЧТО-ТО ИЗМЕНИЛОСЬ",,,,,,,,,,,,
log_apotheosis_reality_mutation_05,YOU FEEL LIFE IN THE COSMOS HAS SHIFTED,"ВЫ ЧУВСТВУЕТЕ, ЧТО ЖИЗНЬ В КОСМОСЕ СДВИНУЛАСЬ",,,,,,,,,,,,
material_apotheosis_meat_irritating,Irritating Meat,Раздражающее мясо,,,,,,,,,,,,
material_apotheosis_meat_decaying,Decaying Meat,Разлагающееся мясо,,,,,,,,,,,,
material_apotheosis_meat_feathery,Feathery Meat,Пернатое мясо,,,,,,,,,,,,
material_apotheosis_meat_centipede,Centipede Meat,Мясо сороконожки,,,,,,,,,,,,
material_apotheosis_sand_pink,Pink Sand,Розовый песок,,,,,,,,,,,,
material_apotheosis_sand_red,Red Sand,Синий песок,,,,,,,,,,,,
material_apotheosis_sand_insect_husk,Insect Husk,Шелуха насекомого,,,,,,,,,,,,
material_apotheosis_mist_poison,Poisonous Mist,Ядовитый туман,,,,,,,,,,,,
material_apotheosis_gem_green,Green Gem,Зелёный самоцвет,,,,,,,,,,,,
material_apotheosis_magic_divine_liquid,Divine Liquid,Божественная жидкость,,,,,,,,,,,,
material_apotheosis_spark_orange,Orange Spark,Оранжевая искра,,,,,,,,,,,,
material_apotheosis_blood_centipede,Centipede Blood,Кровь сороконожки,,,,,,,,,,,,
spell_apotheosis_thrower_disc_name,Giga Disc Projectile Thrower,Метатель гигантских дисков,,,,,,,,,,,,
spell_apotheosis_thrower_disc_desc,Makes a projectile cast Giga Disc Projectiles in random directions,Снаряд испускает гигантские дисковые снаряды в случайном направлении,,,,,,,,,,,,
spell_apotheosis_thrower_cursed_orb_name,Cursed Orb Thrower,Метатель проклятых сфер,,,,,,,,,,,,
spell_apotheosis_thrower_cursed_orb_desc,Makes a projectile cast Cursed Orbs in random directions,Снаряд испускает проклятые шары в случайном направлении,,,,,,,,,,,,
spell_apotheosis_thrower_tnt_name,Dynamite Thrower,Метатель динамита,,,,,,,,,,,,
spell_apotheosis_thrower_tnt_desc,Makes a projectile cast Dynamite in random directions,Снаряд испускает динамит в случайном направлении,,,,,,,,,,,,
spell_apotheosis_thrower_ice_ball_name,Ice Ball Thrower,Метатель ледяных шариков,,,,,,,,,,,,
spell_apotheosis_thrower_ice_ball_desc,Makes a projectile cast Ice Balls in random directions,Снаряд испускает ледяные шарики в случайном направлении,,,,,,,,,,,,
spell_apotheosis_thrower_nuke_name,Nuke Thrower,Метатель ядерного оружия,,,,,,,,,,,,
spell_apotheosis_thrower_nuke_desc,Are you sure?                               ,Вы уверены?                               ,,,,,,,,,,,,
spell_apotheosis_thrower_disc_enemy_name,Personal Giga Disc Projectile Thrower,Личный метатель гигантских дисков,,,,,,,,,,,,
spell_apotheosis_thrower_disc_enemy_desc,Makes a projectile turn the creatures it hits into living Sawblade throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей пил",,,,,,,,,,,,
spell_apotheosis_thrower_cursed_orb_enemy_name,Personal Cursed Orb Thrower,Личный метатель проклятых сфер,,,,,,,,,,,,
spell_apotheosis_thrower_cursed_orb_enemy_desc,Makes a projectile turn the creatures it hits into living Cursed Orb throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей проклятых сфер",,,,,,,,,,,,
spell_apotheosis_thrower_ice_ball_enemy_name,Personal Ice Ball Thrower,Личный метатель ледяных шариков,,,,,,,,,,,,
spell_apotheosis_thrower_ice_ball_enemy_desc,Makes a projectile turn the creatures it hits into living Ice Ball throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей ледяных шариков",,,,,,,,,,,,
spell_apotheosis_thrower_tnt_enemy_name,Personal Dynamite Thrower,Личный метатель динамита,,,,,,,,,,,,
spell_apotheosis_thrower_tnt_enemy_desc,Makes a projectile turn the creatures it hits into living Dynamite throwers,"Снаряд превращает существ, с которыми сталкивается, в метателей динамита",,,,,,,,,,,,
spell_apotheosis_thrower_nuke_enemy_name,Personal Nuke Thrower,Личный метатель ядерного оружия,,,,,,,,,,,,
spell_apotheosis_thrower_nuke_enemy_desc,Makes a projectile turn the creatures it hits into living... Nuke throwers?!?!!,"Снаряд превращает существ, с которыми сталкивается, в... метателей ядерного оружия?!?!!",,,,,,,,,,,,
spell_apotheosis_holy_orb_barrage_name,Holy Orb Barrage,Шквал священных сфер,,,,,,,,,,,,
spell_apotheosis_holy_orb_barrage_desc,Casts a barrage of 7 holy orbs. Also has some magical properties...,Вызывает шквал из 7 святых шаров. Также обладает некоторыми магическими свойствами...,,,,,,,,,,,,
spell_apotheosis_cursed_orb_barrage_name,Cursed Orb Barrage,Шквал проклятых сфер,,,,,,,,,,,,
spell_apotheosis_cursed_orb_barrage_desc,Casts a barrage of 7 cursed orbs. Has some noticeably destructive properties.,Вызывает шквал из 7 проклятых шаров. Обладает заметными разрушительными свойствами.,,,,,,,,,,,,
spell_apotheosis_giga_bomb_name,Giga Bomb,Большая бомба,,,,,,,,,,,,
spell_apotheosis_giga_bomb_desc,Explosion!!,Бум!!,,,,,,,,,,,,
spell_apotheosis_aqua_mine_name,Aqua Mine,Водяная мина,,,,,,,,,,,,
spell_apotheosis_aqua_mine_desc,Creates an explosive Aquamine with subtle homing properties.,Создёет взрывоопасную водяную мину с тонкими свойствами самонаведения.,,,,,,,,,,,,
spell_apotheosis_mass_materia_conversion_name,Mass Materia Conversion,Массовое преобразование материалов,,,,,,,,,,,,
spell_apotheosis_mass_materia_conversion_desc,Cave quid volunt,Cave quid volunt,,,,,,,,,,,,
spell_apotheosis_bungal_shift_name,Fungal Shift,Грибковое смещение,,,,,,,,,,,,
spell_apotheosis_bungal_shift_desc,Cave quid volunt                 ,Cave quid volunt                 ,,,,,,,,,,,,
spell_apotheosis_musical_proj_name,Musical Strike,Музыкальный удар,,,,,,,,,,,,
spell_apotheosis_musical_proj_desc,"Fires a powerful musical attack, careful not to lose your creativity","Стреляет мощной музыкальной атакой, стараясь не потерять свой творческий потенциал",,,,,,,,,,,,
spell_apotheosis_musical_proj_trig_name,Musical Strike with trigger,Музыкальный удар с активацией,,,,,,,,,,,,
spell_apotheosis_musical_proj_trig_desc,"Fires a powerful musical attack, casts another spell upon collision","Стреляет мощной музыкальной атакой, при столкновении вызывает другое заклинание",,,,,,,,,,,,
spell_apotheosis_reverberation_name,Reverberation,Реверберация,,,,,,,,,,,,
spell_apotheosis_reverberation_desc,"Creates a reverberation of sound in the air, slicing anything nearby to pieces.","Создаёт отзвук в воздухе, разрывая на куски всё, что находится поблизости.",,,,,,,,,,,,
spell_apotheosis_bite_name,Bite,Укус,,,,,,,,,,,,
spell_apotheosis_bite_desc,...Magic?,...Волшебство?,,,,,,,,,,,,
spell_apotheosis_bungal_shift_hyper_name,Hyper Fungal Shift,Супергрибковое смещение,,,,,,,,,,,,
spell_apotheosis_bungal_shift_hyper_desc,Insane....                          ,Безумие....                          ,,,,,,,,,,,,
spell_apotheosis_summon_worm_name,Summon Jättimato,Призыв яттимато,,,,,,,,,,,,
spell_apotheosis_summon_worm_desc,Dangerous....                      ,Опасно....                      ,,,,,,,,,,,,
spell_apotheosis_bite_crit_name,Bloody Bite,Кровавый укус,,,,,,,,,,,,
spell_apotheosis_bite_crit_desc,Magic...............................?       ,Волшебство...............................?       ,,,,,,,,,,,,
spell_apotheosis_spells_to_sorako_name,Spells to Cats,Превращение в кошек,,,,,,,,,,,,
spell_apotheosis_spells_to_sorako_desc,Transforms every projectile currently in the air into Cats; a cute idea,"Превращает каждый снаряд, находящийся в воздухе, в кошку. Милая идея",,,,,,,,,,,,
spell_apotheosis_split_shot_name,Split Shot,Разделяющийся выстрел,,,,,,,,,,,,
spell_apotheosis_split_shot_desc,50% chance to duplicate the next cast,50% шанс на удвоение при следующем заклинании,,,,,,,,,,,,
spell_apotheosis_status_drunk_name,Mass Drunk,Массовое пьянство,,,,,,,,,,,,
spell_apotheosis_status_drunk_desc,Affects every creature in a large radius with a drunken curse,Проклятие пьянства действует на каждое существо в большом радиусе,,,,,,,,,,,,
spell_apotheosis_status_wet_name,Mass Wet,Массовая влага,,,,,,,,,,,,
spell_apotheosis_status_wet_desc,Soaks every creature in a large radius with a magical wetness,Пропитывает волшебной влагой всех существ в большом радиусе,,,,,,,,,,,,
spell_apotheosis_status_fire_name,Mass Fire,Массовый огонь,,,,,,,,,,,,
spell_apotheosis_status_fire_desc,Burns every creature in a large radius with a magical fire,Сжигает волшебным огнём всех существ в большом радиусе,,,,,,,,,,,,
spell_apotheosis_status_urine_name,Mass Jarate,Массовое Банкате,,,,,,,,,,,,
spell_apotheosis_status_urine_desc,Douses every creature in a large radius with a magical jarate.,Обливает всех существ в большом радиусе волшебным Банкате,,,,,,,,,,,,
spell_apotheosis_status_polymorph_name,Mass Polymorph,Массовый полиморфизм,,,,,,,,,,,,
spell_apotheosis_status_polymorph_desc,Afflicts every creature in a large radius with a magical polymorphine,Поражает всех существ в большом радиусе волшебным полиморфизмом,,,,,,,,,,,,
setting_apotheosis_catimmortality_name,Cat immortality,Бессмертие кошек,,,,,,,,,,,,
setting_apotheosis_catimmortality_desc,Are cats immortal?,Являются ли кошки бессмертными?,,,,,,,,,,,,
setting_apotheosis_fairyimmortality_name,Fairy immortality,Бессмертие фей,,,,,,,,,,,,
setting_apotheosis_fairyimmortality_desc,Are Keiju immortal?,Являются ли Кейдзю бессмертными?,,,,,,,,,,,,
setting_apotheosis_motd_name,Message of the Day,Сообщение дня,,,,,,,,,,,,
setting_apotheosis_motd_desc,Will a MOTD be displayed at the start of each run? \nMay contain bonus hints for various secrets.,Будет ли сообщение дня отображаться в начале каждого забега? \nМожет содержать бонусные подсказки с различными секретами.,,,,,,,,,,,,
setting_apotheosis_seasonal_name,Seasonal Events,Сезонные события,,,,,,,,,,,,
setting_apotheosis_seasonal_desc,"Are seasonal events enabled? \nFor example, Halloween, More Creep's Birthday, etc.","Включены ли сезонные события? \nНапример, Хэллоуин, день рождения мода More Creep и т.д.",,,,,,,,,,,,
setting_apotheosis_bosshealthmultiplier_name,Boss Health Multiplier,Множитель здоровья босса,,,,,,,,,,,,
setting_apotheosis_bosshealthmultiplier_desc,"Multiply all Bosses health by this much. \nFor those who seek extra durable opponents. \nDoes not affect Kolmisilma \nMinibosses will also have their health boosted by a partial amount. \nThis can be changed mid-run but may not update for all bosses, remember to restart after updating the multiplier.\n \nFor Modders: \nIf your mod isn't listed in the compatibility section of the mod page, \nthis likely won't boost it, you'll need to add a lua component to your bosses. \nDo not hesitate to contact me for instructions or help if needed. \nIt would be easiest for me to respond to you on discord, Conga Lyne#2452","Умножает здоровье всех боссов на это количество. \nДля тех, кто ищет особо стойких противников. \nНе влияет на Колмисильмяна \nМини-боссы также будут иметь частичное увеличение здоровья. \nЭто можно изменить в середине игры, но не для всех боссов, не забудьте перезапустить игру после обновления множителя.\n \nДля создателей модов: \nЕсли ваш мод не указан в разделе совместимости на странице модов, \nэто скорее всего не поможет, вам придётся добавить lua компонент к вашим боссам. \nНе стесняйтесь обращаться ко мне за инструкциями или помощью, если это необходимо. \nМне будет проще всего ответить вам в discord, Conga Lyne#2452.",,,,,,,,,,,,
setting_apotheosis_compatmode_conjurer_name,Conjurer extra Compatibility mode,Режим совместимости: Conjurer,,,,,,,,,,,,
setting_apotheosis_compatmode_conjurer_desc,"Some people may have issues with this mod not loading into Conjurer properly. \nIf this happens, try enabling this option and loading conjurer again. \n \nThis option is on by default but can be turned off if you wish to \nhave the pixel scenes & bosses appear in conjurer worlds. \n \nIf Conjurer still fails to load despite having this turned on, although unlikely, \nit may be a mod compatibility issue with something else, \nperhaps try disabling mods to find the troublesome one. \n \nIf nothing else works please let me know to by filing a bug report to me. \nIt would be easiest for me to reach & investigate your report at the discord link below: \nhttps://discord.gg/gtyGnv8Pxk","У некоторых людей могут возникнуть проблемы с тем, что этот мод не загружается вместе с модом Conjurer должным образом. \nЕсли это произошло, попробуйте включить этот параметр и загрузить Conjurer снова. \n \nЭта опция включена по умолчанию, но может быть выключена, если вы хотите, чтобы пиксельные сцены и боссы появлялись в мирах Conjurer. \n \nЕсли Conjurer всё ещё не загружается, несмотря на включение этого параметра, хотя это маловероятно, \nможет быть проблема совместимости мода с чем-то другим, \nвозможно, попробуйте отключить все моды поочерёдно, чтобы найти проблемный. \nЕсли ничего не помогает, пожалуйста, сообщите мне об этом, написав сообщение об ошибке. \nМне будет проще всего связаться и изучить ваше сообщение по ссылке на discord: \nhttps://discord.gg/gtyGnv8Pxk",,,,,,,,,,,,
setting_apotheosis_compatmode_spell_evolution_name,Spell Evolution Compatibility Mode,Режим совместимости: Spell Evolution,,,,,,,,,,,,
setting_apotheosis_compatmode_spell_evolution_desc,"Turn this setting on if you're playing with the Spell Evolution mod to fix it.\n \nAs far as I can tell, a bug in Spell Evolutions causes it to break if a modded spell \n Uses translation keys for their name and/or description. \n \nUnfortunately there's nothing I can do about this as it's not my mod, \nand I have no intention to remove the translation keys \nas I hope to use them one day in the event \nI'm offered a translation for the mod to another language. \nHowever, I can put a setting in to optionally let you use the spells without \ntranslation keys to get around the issue.","Включите этот параметр, если вы играете с модом Spell Evolution, чтобы исправить ошибки.\n \nНасколько я могу судить, ошибка в Spell Evolutions приводит к тому, что он ломается, если модифицированное заклинание \n использует ключи перевода для своего имени и/или описания. \n \nК сожалению, я ничего не могу с этим поделать, поскольку это не мой мод, \n и у меня нет намерения удалять ключи перевода, \n поскольку я надеюсь использовать их однажды в случае, если мне предложат перевести мод на другие языки. \Однако, я могу сделать настройку, которая позволит вам использовать заклинания без ключей перевода, чтобы обойти эту проблему.",,,,,,,,,,,,
status_apotheosis_duckcurse_name,Duck Curse,Утиное проклятие,,,,,,,,,,,,
status_apotheosis_duckcurse_desc,Their Quacky visions haunt you,Их утиные взгляды преследуют вас,,,,,,,,,,,,
status_apotheosis_manadrain_name,Mana Degradation,Разложение маны,,,,,,,,,,,,
status_apotheosis_manadrain_desc,You are losing Mana Rapidly!!,Вы стремительно теряете ману!!!,,,,,,,,,,,,
status_apotheosis_transmute_name,Unstable Transmutation,Нестабильная трансмутация,,,,,,,,,,,,
status_apotheosis_transmute_desc,Your being is transmuting nearby matter uncontrollably!,Ваша сущность бесконтрольно превращается близлежащую материю!,,,,,,,,,,,,
1.1.0 content below,"=====================================================================================================================================================================================================================================================Below here are 1.1.0 translation keys",,,,,,,,,,,,,
item_apotheosis_essence_fungus_name,Essence of Fungus,Эссенция грибка,,,,,,,,,,,,
item_apotheosis_essence_fungus_desc,Your very being is infecting the environment around it!,Сама ваша сущность заражает окружающую среду!,,,,,,,,,,,,
sign_apotheosis_welcome_hint,"Hello and Welcome to Apotheosis! \nAlthough this may seem inconvenient, please take a moment to view the mod settings page in Options > Mod Settings. \nSome mods need compatibility modes enabled, I did I my best but some things are outside my control sadly. Other than that, go nuts and have fun <3","Здравствуйте и добро пожаловать в мод Apotheosis \nХотя это может показаться неубедительным, пожалуйста, уделите время просмотру страницы настроек мода в «Параметры» > «Модификации». \nНекоторые моды требуют включения модов совместимости, я сделал всё возможное, но некоторые вещи, к сожалению, находятся вне моего контроля. В остальном, не сомневайтесь и получайте удовольствие <3",,,,,,,,,,,,
sign_apotheosis_aprilfools_intro,Happy April Fools <3,Счастливого дня смеха <3,,,,,,,,,,,,
status_apotheosis_trip_red_00_name,Blazed,Ломка,,,,,,,,,,,,
status_apotheosis_trip_red_00_desc,You feel dizzy.,Вы чувствуете головокружение.,,,,,,,,,,,,
status_apotheosis_trip_red_01_name,Somewhat Blazed,Небольшая ломка,,,,,,,,,,,,
status_apotheosis_trip_red_01_desc,You feel interlinked with Yggdrasil.,Вы чувствуете связь с Иггдрасилем.,,,,,,,,,,,,
status_apotheosis_trip_red_02_name,Really Blazed,Сильная ломка,,,,,,,,,,,,
status_apotheosis_trip_red_02_desc,You feel a pleasant burning sensation build up inside you.,"Вы чувствуете, как внутри вас нарастает приятное жжение.",,,,,,,,,,,,
status_apotheosis_trip_red_03_name,Blazed as Hell,Чертовски сильная ломка,,,,,,,,,,,,
status_apotheosis_trip_red_03_desc,Usual concepts don't apply.,Обычные понятия неприменимы.,,,,,,,,,,,,
item_apotheosis_fungus_stone_name,Sienenkivi,Сененкиви,,,,,,,,,,,,
item_apotheosis_fungus_stone_desc,You feel the world transforming in the palm of your hand.,"Вы чувствуете, как мир преображается у вас на ладони.",,,,,,,,,,,,
item_apotheosis_chest_portals,Dimensional Chest,Пространственный сундук,,,,,,,,,,,,
item_apotheosis_chest_volcanic,Volcanic Chest,Вулканический сундук,,,,,,,,,,,,
status_apotheosis_haste_name,Haste,Спешка,,,,,,,,,,,,
status_apotheosis_haste_desc,You feel faster,Вы чувствуете себя быстрее,,,,,,,,,,,,
material_apotheosis_meat_mana,Enchanting Meat,Очаровательное мясо,,,,,,,,,,,,
material_apotheosis_smoke_static_slowburn_name,Dense Smoke,Плотный дым,,,,,,,,,,,,
material_apotheosis_meat_fire_lukki,Infernal Meat,Адское мясо,,,,,,,,,,,,
material_apotheosis_meat_fire_lukki_rock,Brimstone,Сера,,,,,,,,,,,,
material_apotheosis_mudman_mud,Magical Mud,Волшебный ил,,,,,,,,,,,,
material_apotheosis_knowledge_of_kings,Yggdrasil's Knowledge,Знания Иггдрасиля,,,,,,,,,,,,
spell_apotheosis_targetter_name,Targetter,Целеуказатель,,,,,,,,,,,,
spell_apotheosis_targetter_desc,Fire a projectile which causes irresistable hatred towards anything it hits,"Выпускает снаряд, который вызывает непреодолимую ненависть ко всему, во что попадает",,,,,,,,,,,,
spell_apotheosis_firecharge_name,Fire Charge,Огненный заряд,,,,,,,,,,,,
spell_apotheosis_firecharge_desc,"Imbues a projectile with a fiery charge, that it will release on impact","Наделяет снаряд огненным зарядом, который он выпустит при ударе",,,,,,,,,,,,
spell_apotheosis_knowledge_of_kings_name,The Knowledge of Kings,Знание королей,,,,,,,,,,,,
spell_apotheosis_knowledge_of_kings_desc,Casting this spell causes something irreversibly permanent to occur,Использовании этого заклинания происходит нечто необратимо постоянное,,,,,,,,,,,,
spell_apotheosis_portal_lukki_red_portal_name,Summon Red Portal,Призыв красного портала,,,,,,,,,,,,
spell_apotheosis_portal_lukki_red_portal_desc,"Summons a red tinted portal where it is focused, Right Click to mark a location for the portal to focus on.","Призыв портала с красным оттенком. Щёлкните правой кнопкой мыши, чтобы отметить место, на котором будет сфокусирован портал.",,,,,,,,,,,,
spell_apotheosis_portal_lukki_blue_portal_name,Summon Blue Portal,Призыв синего портала,,,,,,,,,,,,
spell_apotheosis_portal_lukki_blue_portal_desc,"Summons a blue tinted portal where it is focused, Right Click to mark a location for the portal to focus on.","Призыв портала с синим оттенком. Щёлкните правой кнопкой мыши, чтобы отметить место, на котором будет сфокусирован портал.",,,,,,,,,,,,
spell_apotheosis_portal_lukki_green_portal_name,Summon Green Portal,Призыв зелёного портала,,,,,,,,,,,,
spell_apotheosis_portal_lukki_green_portal_desc,"Summons a green tinted portal where it is focused, Right Click to mark a location for the portal to focus on.","Призыв портала с зелёным оттенком. Щёлкните правой кнопкой мыши, чтобы отметить место, на котором будет сфокусирован портал.",,,,,,,,,,,,
spell_apotheosis_alt_fire_teleport_name,"Alt Fire Teleport Bolt",Телепортирующая молния (ПКМ),,,,,,,,,,,,
spell_apotheosis_alt_fire_teleport_desc,"Right Click to fire a magical bolt that moves you wherever it ends up flying","Щёлкните правой кнопкой мыши, чтобы запустить телепортационную молнию.",,,,,,,,,,,,
spell_apotheosis_alt_fire_teleport_short_name,"Alt Fire Small Teleport Bolt",Малая телепортирующая молния (ПКМ),,,,,,,,,,,,
spell_apotheosis_alt_fire_teleport_short_desc,"Right Click to fire a shortlived magical bolt that moves you wherever it ends up flying","Щёлкните правой кнопкой мыши, чтобы запустить малую телепортационную молнию.",,,,,,,,,,,,
misc_apotheosis_energy_nova,Energy Nova,Энергия Новы,,,,,,,,,,,,
log_apotheosis_moon_altar_fungus,AN IRREVERSIBLE CORRUPTION HAS OCCURRED,ПРОИЗОШЛА НЕОБРАТИМАЯ ПОРЧА,,,,,,,,,,,,
logdesc_apotheosis_moon_altar_fungus,WHAT HAVE YOU DONE!?,ЧТО ВЫ НАДЕЛАЛИ!?,,,,,,,,,,,,
log_apotheosis_toxicnest_secret_name,I TOLD YOU NOT TO VISIT THE WORM NEST AT 3AM,Я ЖЕ ГОВОРИЛ ВАМ НЕ ПОСЕЩАТЬ ГНЕЗДО ЧЕРВЕЙ В 3 ЧАСА НОЧИ,,,,,,,,,,,,
status_apotheosis_protection_lava_name,Lava Immunity,Стойкость к лаве,,,,,,,,,,,,
status_apotheosis_protection_lava_desc,You take no direct damage from lava or fire.,Вы не получаете прямого урона от лавы или огня.,,,,,,,,,,,,
status_apotheosis_explosive_orb_name,Explosive,Взрывчатка,,,,,,,,,,,,
status_apotheosis_explosive_orb_desc,You're transmuting magic into explosives!,Вы превращаете магию во взрывчатку!,,,,,,,,,,,,
creep_apotheosis_boss_fire_lukki_name,Lämmön Esteetikko,,,,,,,,,,,,,
integration_apotheosis_RANDOM_CATS_name,Kitty Cats!!,Кошечки!!!,,,,,,,,,,,,
integration_apotheosis_RANDOM_CATS_desc,Cat! I'm a kitty cat! And I dance dance dance! And I dance dance dance!!,Кошка!! Я кошечка!! И я танцую туц-туц!! И я танцую танцую танцую танцую!!!,,,,,,,,,,,,
integration_apotheosis_RANDOM_CREEPS_name,Random Creeps & Weirdos,Случайные твари и чудики,,,,,,,,,,,,
integration_apotheosis_RANDOM_CREEPS_desc,Random Creeps & Weirdos will appear in 5 seconds.,Случайные твари и чудики появятся через 5 секунд.,,,,,,,,,,,,
integration_apotheosis_WAND_WONDERS_name,Spawn Wand of Wonders,Создать Жезл чудес,,,,,,,,,,,,
integration_apotheosis_WAND_WONDERS_desc,A wonderful wand capable of anything. Cast it!,"Чудесный жезл, способный на всё. Колдуйте!!",,,,,,,,,,,,
integration_apotheosis_PANDORA_CHEST_name,Pandora's Chest,Сундук Пандоры,,,,,,,,,,,,
integration_apotheosis_PANDORA_CHEST_desc,Do you dare open?,Осмелитесь ли вы открыть?,,,,,,,,,,,,
integration_apotheosis_RANDOM_CREEPS_BOSS_name,Random Weirdo Boss,Случайный босс-чудик,,,,,,,,,,,,
integration_apotheosis_RANDOM_CREEPS_BOSS_desc,A random Apotheosis boss will appear after 10 seconds.,Через 10 секунд появится случайный босс мода Apotheosis.,,,,,,,,,,,,
integration_apotheosis_STONE_FUNGUS_name,Sienenkivi,Сененкиви,,,,,,,,,,,,
integration_apotheosis_STONE_FUNGUS_desc,Fungus Stone,Грибковый камень,,,,,,,,,,,,
integration_apotheosis_CREATURE_SHIFT_name,Creature Shift,Сдвиг существ,,,,,,,,,,,,
integration_apotheosis_CREATURE_SHIFT_desc,Causes a creature to randomly be shifted with another.,Вызывает случайное смещение одного существа с другим.,,,,,,,,,,,,
integration_apotheosis_TRANSFORM_WORMS_name,Spells to Worms,Превращение в червяков,,,,,,,,,,,,
integration_apotheosis_TRANSFORM_WORMS_desc,All projectiles currently in the air turn into worms!,"Все снаряды, находящиеся в воздухе, превращаются в червей!!",,,,,,,,,,,,
integration_apotheosis_MUD_MEN_name,Summon Mud Men,Призыв грязевика,,,,,,,,,,,,
integration_apotheosis_MUD_MEN_desc,MUD MEN are here to save the day!!,"ГРЯЗЕВИК пришёл, чтобы помочь вам!!!",,,,,,,,,,,,
integration_apotheosis_HUNGRY_ORB_name,Hungry Orb,Голодный шар,,,,,,,,,,,,
integration_apotheosis_HUNGRY_ORB_desc,???,???,,,,,,,,,,,,
integration_apotheosis_DELUSIONAL_name,Delusional Streamer,Стример-шизик,,,,,,,,,,,,
integration_apotheosis_DELUSIONAL_desc,Your senses deceive you.,Ваши чувства обманывают вас.,,,,,,,,,,,,
integration_apotheosis_CLOWNS_name,CLOWNS,КЛОУНЫ,,,,,,,,,,,,
integration_apotheosis_CLOWNS_desc,"You're not a clown, you're the entire circus!!","Вы не клоун, вы целый цирк!!!",,,,,,,,,,,,
integration_apotheosis_SWAPPER_CURSE_name,Curse of Swapping,Проклятие подмены,,,,,,,,,,,,
integration_apotheosis_SWAPPER_CURSE_desc,You feel the blood of Swapper Mages runs through you,"Вы чувствуете, как в вас течёт кровь магов-подменщиков.",,,,,,,,,,,,
secretmessage_apotheosis_herobrine_01,I see you.,Я тебя вижу.,,,,,,,,,,,,
secretmessage_apotheosis_divineorb_name,You discovered an orb of divine knowledge,Вы обнаружили шар божественных знаний,,,,,,,,,,,,
secretmessage_apotheosis_divineorb_desc,Secrets of otherworldly royalty have been unlocked to you.,Вам стали открыты секреты потусторонней королевской власти.,,,,,,,,,,,,
secretmessage_apotheosis_kingly_alreadydone,You feel the secrets of otherworldly royalty have already been unleashed...,"Вы чувствуете, что секреты потусторонней королевской власти уже раскрыты...",,,,,,,,,,,,
secretmessage_apotheosis_kingly_cheater,You feel the magic is incomplete...,"Вы чувствуете, что волшебство не завершено...",,,,,,,,,,,,
secretmessage_apotheosis_capeget_name,You feel more.. pretty..?,Вы чувствуете себя более.. симпатичными..?,,,,,,,,,,,,
secretmessage_apotheosis_capeget_desc,Truly befitting.,Очень удовлетворительно.,,,,,,,,,,,,
secretmessage_apotheosis_divineorb_heart_name,You found a familiar orb of divine knowledge,Вы нашли знакомый шар божественных знаний,,,,,,,,,,,,
book_apotheosis_symbol_centipede_blood,Tuhatjalkainen Veri,Тухатьялкайнен Вери,,,,,,,,,,,,
book_apotheosis_symbol_centipede_blood_description,"Half a circle, and a spine connected to it. \nThree legs on each side, and the centipede's inner liquid is born.","Половина круга, и к нему присоединяется позвоночник. \nТри ноги с каждой стороны, и рождается внутренняя жидкость сороконожки.",,,,,,,,,,,,
book_apotheosis_symbol_redsand,Punainen Hiekka,Пунайнен Хиекка,,,,,,,,,,,,
book_apotheosis_symbol_redsand_description,"Three lines. One Horizonal, two more starting at the edges of the first line which converge upwards to touch each other at their ends. \nWithin this new shape, circles lay. \none. two. and three. \nThese three circles represent the specks of dust, and thus a blazing red powder is born.","Три линии. Одна горизонтальная, две другие, начинающиеся от краёв первой линии, которые сходятся вверх и касаются друг друга своими концами. \nВ этой новой форме лежат круги. \nОдин. два. и три. \nЭти три круга представляют собой пылинки, и таким образом рождается пылающий красный порошок.",,,,,,,,,,,,
book_apotheosis_symbol_insecthusk,Hyönteisten Kuori,Хьонтейстен Куори,,,,,,,,,,,,
book_apotheosis_symbol_insecthusk_description,"One triangle, and another below facing the other way. \nDraw a line to connect these two formations. \nStart from the center of the first, and draw down until it pierces through the second triangle. \nFrom this new symbol, the husk of insects is born.","Один треугольник, а другой внизу обращён в другую сторону. \nНарисуйте линию, соединяющую эти два образования. \nНачните с центра первого треугольника и проведите линию вниз, пока она не пронзит второй треугольник. \nИз этого нового символа рождается шелуха насекомых.",,,,,,,,,,,,
book_apotheosis_symbol_divineliquid,Jumalallinen Neste,Джумалаллинен Несте,,,,,,,,,,,,
book_apotheosis_symbol_divineliquid_description,"Place down your brush, and draw nothing less than a perfect circle. \n \nWithin this circle, draw the four elements. \nOne line for Fire \nOne for Water \nOne for Earth \nand One for Air. \n \nWhere the elements converge, make another perfect circle, fill it in with purpose. \nWith this, a divine drink is born.","Положите кисть и нарисуйте не менее чем идеальный круг. \n \nВ этом круге нарисуйте четыре элемента. \nОдна линия для огня \nОдна для воды \nОдна для земли \nи одна для воздуха. \nТам, где элементы сходятся, сделайте ещё один идеальный круг, заполните его. \nПосле этого рождается божественный напиток.",,,,,,,,,,,,
book_apotheosis_symbol_pinksand,Vaaleanpunainen Hiekka,Ваалеанпунайнен Хиекка,,,,,,,,,,,,
book_apotheosis_symbol_pinksand_description,"A triangle. Within this, create a line piercing through it's purpose. \nInside this triangle near it's peak, a circle sits. \nThe circle is pierced by the line, and is ready to change shape. \nWith this symbol, the pinkest sand will be born.","Треугольник. Внутри него проведите линию, пронизывающую его насквозь. \nВнутри этого треугольника, около его вершины, сидит круг. \nКруг пронзён линией и готов изменить форму. \nС этим символом родится самый розовый песок.",,,,,,,,,,,,
book_apotheosis_symbol_fungus,Sieni,Сиени,,,,,,,,,,,,
book_apotheosis_symbol_fungus_description,"Two circles, these are specks of dust. \nBetween these specks, draw a line moving upwards. \nWhere the line stops draw two more moving towards the circles. \nConnect the ends of those lines together with one final line, and a fungal infection is born.","Два круга - это пылинки. \nМежду ними проведите линию, двигающуюся вверх. \nВ месте остановки линии нарисуйте ещё две, двигаясь по направлению к кругам. \nСоедините концы этих линий вместе последней линией, и таким образом родится грибковая инфекция.",,,,,,,,,,,,
book_apotheosis_fire_lukki,Scorched Notes,Опалённые записки,,,,,,,,,,,,
book_apotheosis_fire_lukki_description,"I remember finding a stone, blazing with fire but nothing more than a gentle touch in my hand. \nIt belonged to those fire cretins who hunted me I bet. \n \nWanting to get back at them I threw the stone into the deepest body of lava I could find in those wretched mines.. \nBut that was my fatal mistake. \n \nThe stone seemed to attract... something. \nI dared not look back after hearing the lava stir violently behind me, I feel lucky to be alive. \n \nMy robes were scorched by it's mere presence. \nMy pride reduced to burn marks of what it once was. \nI hope I need never return to that place.","Я помню, как нашёл камень, пылающий огнём, но не более чем легкое прикосновение моей руки. \nНаверняка он принадлежал тем огненным кретинам, которые охотились на меня. \nЖелая отомстить им, я бросил камень в самую глубокую лаву, которую смог найти в этих жалких шахтах. \nНо это была моя роковая ошибка. \n \n Камень, казалось, притягивал... что-то. \nЯ не смел оглянуться, когда услышал, как за спиной яростно зашипела лава. Мне повезло, что я остался жив. \nМоя одежда опалилась от одного его присутствия. \nМоя гордость превратилась в ожоги от того, чем она когда-то была. Надеюсь, я никогда не вернусь в это место.",,,,,,,,,,,,
status_apotheosis_plagiarize_swapper_name,Curse of Swapping,Проклятие подмены,,,,,,,,,,,,
status_apotheosis_plagiarize_swapper_desc,"Taking damage makes you swap places with the attacker",,,,,,,,,,,,,
status_apotheosis_delusional_name,Delusional,Галлюцинации,,,,,,,,,,,,
status_apotheosis_delusional_desc,Your senses deceive you.,Ваши чувства обманывают вас.,,,,,,,,,,,,
status_apotheosis_creatureshift_cd_name,Unshiftable,Несдвигаемый,,,,,,,,,,,,
status_apotheosis_creatureshift_cd_desc,The path of evolution is set in stone... For now.,Путь эволюции предначертан... Пока что.,,,,,,,,,,,,
perk_apotheosis_revenge_reflective,Revenge Reflection,Отражение мести,,,,,,,,,,,,
perk_apotheosis_revenge_reflective_description,"Reflect copies of enemy projectiles upon taking damage, with a steep damage boost as payback.",Отражение копий вражеских снарядов при получении урона с резким увеличением урона в качестве расплаты.,,,,,,,,,,,,
biomemod_apotheosis_smoke_dense,The air feels unusually dense,Воздух кажется необычайно плотным,,,,,,,,,,,,
credits_apotheosis_line_01,a mod made by,"мод, созданный",,,,,,,,,,,,
credits_apotheosis_line_04,Main Developer of Apotheosis,Главный разработчик Apotheosis,,,,,,,,,,,,
credits_apotheosis_line_07,Voice Actor of the Cats,Актёр озвучивания кошек,,,,,,,,,,,,
credits_apotheosis_line_10,"Creating sprites for the Blobs, Fluffy Cats & Aesthete of Heat boss","Создание спрайтов для сгустка, пушистых кошек и босса эстета тепла",,,,,,,,,,,,
credits_apotheosis_line_11,Creating the Colossal Blob's Vomit Ball attack,Создание атаки «РВОТНЫЙ ШАР» для колоссального сгустка,,,,,,,,,,,,
credits_apotheosis_line_14,Creator of the Mana Drain Script,Создатель скрипта расхода маны,,,,,,,,,,,,
credits_apotheosis_line_17,Russian Translator,Перевод на русский,,,,,,,,,,,,
credits_apotheosis_line_20,"Helped with some creature design & mod direction, also helped with alt-fire spells.","Помогал с дизайном существ и направлением мода, также помогал с заклинаниями на ПКМ.",,,,,,,,,,,,
credits_apotheosis_line_22,Special Thanks to,Особая благодарность,,,,,,,,,,,,
credits_apotheosis_line_39,And many modders of the Noita Discord,И многим создателям модов из Discord-сервера Noita,,,,,,,,,,,,
credits_apotheosis_line_43,"And finally.. you, for giving Apotheosis a try and making it this far into the mod!","И наконец.. вам, за то, что попробовали Apotheosis и зашли так далеко в этом моде!",,,,,,,,,,,,
credits_apotheosis_line_44,I hope you enjoyed playing it as much as I enjoyed making it <3,"Надеюсь, вам понравилось играть в него так же, как мне понравилось его создавать <3",,,,,,,,,,,,
credits_apotheosis_line_45,Best of luck in your future adventures - Conga Lyne,Желаю удачи в ваших будущих приключениях - Conga Lyne,,,,,,,,,,,,
credits_apotheosis_line_horscht,Provided a ton of help in the mod support channel during development and let me use his credits script.,Оказал тонну помощи в канале поддержки мода во время разработки и позволил мне использовать его скрипт для этого меню.,,,,,,,,,,,,
Apotheosis content below,"=====================================================================================================================================================================================================================================================Below here are 1.1.0 translation keys",,,,,,,,,,,,,
teleport_portal_alternate,"Portal Elsewhere",,,,,,,,,,,,,
biome_slime_hell,"Virulent Caverns",,,,,,,,,,,,,
biome_toxic_worm_cave,"Toxic Nest",,,,,,,,,,,,,
biome_abandoned_assembly,"Sandy Assembly",,,,,,,,,,,,,
biome_esoteric_den,"Abyssum",,,,,,,,,,,,,
biome_underground_forest,"Subterrain Woodland",,,,,,,,,,,,,
biome_evil_temple,"Temple of Sacrilegious Remains",,,,,,,,,,,,,
biome_desert_pit,"Sinkhole",,,,,,,,,,,,,
biome_lava_excavation,"Core Mines",,,,,,,,,,,,,
biome_abyssal_depths,"Forgotten Depths",,,,,,,,,,,,,
biome_mueseum,"Marble Halls",,,,,,,,,,,,,
biome_ant_hell,"Ant Nest",,,,,,,,,,,,,
biome_plane_yggdrasil,"Plane of Yggdrasil",,,,,,,,,,,,,
biome_plane_yggdrasil_border,"Outer Plane of Yggdrasil",,,,,,,,,,,,,
biome_plane_magic,"Plane of Soul",,,,,,,,,,,,,
biomemod_esoteric_presence,"You feel an indescribable aura...",,,,,,,,,,,,,
biomemod_magmatic,"The air is burning",,,,,,,,,,,,,
biomemod_necromancy,"The Dead are Restless",,,,,,,,,,,,,
biomemod_esoteric_den,"You feel the world has indescribable shapes...",,,,,,,,,,,,,
biomemod_alchemic,"You feel an alchemical mist in the air",,,,,,,,,,,,,
biomemod_plane_yggdrasil,"A dense jungle with endless life, filled with monsters foreign",,,,,,,,,,,,,
biomemod_plane_magic,"Your soul feels heavy",,,,,,,,,,,,,
biomemod_slime_hell,"You feel strangely warm",,,,,,,,,,,,,
material_apotheosis_bloodystone,"Bloody Stonework",,,,,,,,,,,,,
material_apotheosis_corruptflesh,"Vacillating Flesh",,,,,,,,,,,,,
material_apotheosis_blood_infectous,"Infectious Blood",,,,,,,,,,,,,
material_apotheosis_volcanicrock_static_dense,"Dense Volcanic Rock",,,,,,,,,,,,,
material_apotheosis_volcanicrock_superhot,"Burning Rock",,,,,,,,,,,,,
material_apotheosis_cursed_liquid,"Cursed Liquid",,,,,,,,,,,,,
material_apotheosis_magic_liquid_infinite_flight,"Soarium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_nukes,"Nukium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_escapium,"Escium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_attunium,"Attunium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_attunium_cloud,"Attunium Mist",,,,,,,,,,,,,
material_apotheosis_magic_liquid_pure_light,"Pure Light",,,,,,,,,,,,,
material_apotheosis_magic_liquid_pure_light_cloud,"Pure Light Mist",,,,,,,,,,,,,
material_apotheosis_magic_liquid_suffocatium,"Suffocatium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_velocium,"Veloium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_mimic,"Mimicium",,,,,,,,,,,,,
material_apotheosis_magic_liquid_rideshare,"Portalium",,,,,,,,,,,,,
material_apotheosis_hidden_liquid_magic_catalyst,"Magic Catalyst",,,,,,,,,,,,,
material_apotheosis_hidden_liquid_wand_essence,"Magus Elixir",,,,,,,,,,,,,
material_apotheosis_sunkenrock,"Sunken Rock",,,,,,,,,,,,,
material_apotheosis_sunkenrock_sandy,"Sandy Rock",,,,,,,,,,,,,
material_apotheosis_ambrosia_dull,"Infected Ambrosia",,,,,,,,,,,,,
material_apotheosis_meat_slime_blue,"Blue Slimy Meat",,,,,,,,,,,,,
material_apotheosis_meat_homing,"Writhing Meat",,,,,,,,,,,,,
material_apotheosis_malicious_powder,"Volcanic Powder",,,,,,,,,,,,,
material_apotheosis_milk,"Milk",,,,,,,,,,,,,
material_apotheosis_esoteric_stone,"Esoteric Stone",,,,,,,,,,,,,
material_apotheosis_esoteric_stone_glowing,"Luminescent Rock",,,,,,,,,,,,,
material_apotheosis_crystal_glow,"Glowing Crystal",,,,,,,,,,,,,
material_apotheosis_cursed_rock_hard,"Sacred Rock",,,,,,,,,,,,,
material_apotheosis_radioactive_liquid_strong,"Noxious Sludge",,,,,,,,,,,,,
material_apotheosis_radioactive_mud,"Defiled Mud",,,,,,,,,,,,,
material_apotheosis_milk_powder,"Powdered Milk",,,,,,,,,,,,,
magic_liquid_berserk_cloud_name,"Berserkium Mist",,,,,,,,,,,,,
magic_liquid_charm_cloud_name,"Pheromone Mist",,,,,,,,,,,,,
spell_apotheosis_spells_to_cursor_name,"Redirect",,,,,,,,,,,,,
spell_apotheosis_spells_to_cursor_desc,"Redirects all airborne projectiles towards your mouse cursor at a high speed",,,,,,,,,,,,,
spell_apotheosis_status_drunk_intense_name,Intense Mass Drunk,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_drunk_intense_desc,Affects every creature in a large radius a short but intense curse of endless spirits.,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_wet_intense_name,Intense Mass Wet,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_wet_intense_desc,Soaks every creature in a large radius with a short but intense curse of magical wetness.,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_fire_intense_name,Intense Mass Fire,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_fire_intense_desc,Burns every creature in a large radius with a dying but more damaging magical fire.,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_urine_intense_name,Intense Mass Jarate,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_urine_intense_desc,Douses every creature in a large radius with a short but intense curse of magical jarate.,,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_status_polymorph_intense_name,Mass Chaotic Polymorph,,,,,,,,,,,,
spell_apotheosis_status_polymorph_intense_desc,"Afflicts every creature in a large radius with a magical chaotic polymorphine",,,,,,,,,,,,,
spell_apotheosis_mass_burrow_name,"Kaivossade",,,,,,,,,,,,
spell_apotheosis_mass_burrow_desc,"Rapidly excavate a large amount of terrain",,,,,,,,,,,,,
spell_apotheosis_status_dry_name,"Mass Infiltration",,,,,,,,,,,,,
spell_apotheosis_status_dry_desc,"Freezes the stains on every creature in a large radius with a magical spell",,,,,,,,,,,,,
status_apotheosis_teleport_cancel_name,"Teleport Nullification",,,,,,,,,,,,,
status_apotheosis_teleport_cancel_desc,"You can no longer teleport",,,,,,,,,,,,,
spell_apotheosis_autofire_name,"Auto-Fire",,,,,,,,,,,,,
spell_apotheosis_autofire_desc,"Causes the wand to automatically shoot if there's nearby enemies",,,,,,,,,,,,,
spell_apotheosis_upgrade_alwayscast_name,"Spell Infusion",,,,,,,,,,,,,
spell_apotheosis_upgrade_alwayscast_desc,"The first spell slotted in your wand will be applied to the wand as an always cast. Spell is voided upon use!",,,,,,,,,,,,,
spell_apotheosis_alt_fire_swapper_name,"Alt Fire Swapper Bolt",,,,,,,,,,,,,
spell_apotheosis_alt_fire_swapper_desc,"Right Click to fire a projectile that swaps your position with the target's",,,,,,,,,,,,,
spell_apotheosis_alt_fire_cov_name,"Alt Fire Circle of Vigour",,,,,,,,,,,,,
spell_apotheosis_alt_fire_cov_desc,"Right Click to cast a field of regenerative magic",,,,,,,,,,,,,
spell_apotheosis_alt_fire_alpha_name,"Alt Fire Alpha",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_alt_fire_alpha_desc,"Right Click to cast a copy of the first spell in your wand for 40 mana",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_critical_drunk_name,"Critical on Drunk",,,,,,,,,,,,,
spell_apotheosis_critical_drunk_desc,"Make a projectile always do a critical hit on drunk enemies",,,,,,,,,,,,,
spell_apotheosis_affluence_name,"Affluence",,,,,,,,,,,,,
spell_apotheosis_affluence_desc,"Creatures hit by your projectiles drop extra gold",,,,,,,,,,,,,
spell_apotheosis_liquidsphere_acid_name,"Sphere of Acid",,,,,,,,,,,,,
spell_apotheosis_liquidsphere_acid_desc,"Cast a powerful sphere of acid, melting everything in its path",,,,,,,,,,,,,
spell_apotheosis_liquidsphere_water_name,"Sphere of Water",,,,,,,,,,,,,
spell_apotheosis_liquidsphere_water_desc,"Cast an enduring sphere of water, soaking everything in its path",,,,,,,,,,,,,
spell_apotheosis_liquidsphere_teleportatium_name,"Sphere of Teleportatium",,,,,,,,,,,,,
spell_apotheosis_liquidsphere_teleportatium_desc,"Cast a malicious sphere of teleportatium, relocating everything in its path",,,,,,,,,,,,,
spell_apotheosis_star_shot_name,"Star Shot",,,,,,,,,,,,,
spell_apotheosis_star_shot_desc,"Fire two starry projectiles with a bright light",,,,,,,,,,,,,
spell_apotheosis_hex_water_name,"Vulnerability Hex - Water",,,,,,,,,,,,,
spell_apotheosis_hex_water_desc,"Creatures hit by your projectiles take damage from water and other wet substances",,,,,,,,,,,,,
spell_apotheosis_hex_oil_name,"Vulnerability Hex - Oil",,,,,,,,,,,,,
spell_apotheosis_hex_oil_desc,"Creatures hit by your projectiles take damage from oil and other oily substances",,,,,,,,,,,,,
spell_apotheosis_hex_blood_name,"Vulnerability Hex - Blood",,,,,,,,,,,,,
spell_apotheosis_hex_blood_desc,"Creatures hit by your projectiles take damage from blood and other bloody substances",,,,,,,,,,,,,
spell_apotheosis_mist_attunium_name,"Attunium Mist",,,,,,,,,,,,,
spell_apotheosis_mist_attunium_desc,"A cloud of attunium mist",,,,,,,,,,,,,
spell_apotheosis_homing_delayed_name,"Delayed Homing",,,,,,,,,,,,,
spell_apotheosis_homing_delayed_desc,"Makes a projectile accelerate towards your foes after a short delay",,,,,,,,,,,,,
spell_apotheosis_material_slime_name,"Slime",,,,,,,,,,,,,
spell_apotheosis_material_slime_desc,"Transmute globs of slime out of nothing!",,,,,,,,,,,,,
spell_apotheosis_material_alcohol_name,"Whiskey",,,,,,,,,,,,,
spell_apotheosis_material_alcohol_desc,"Transmute drops of whiskey out of nothing!",,,,,,,,,,,,,
spell_apotheosis_material_confuse_name,"Flummoxium",,,,,,,,,,,,,
spell_apotheosis_material_confuse_desc,"Transmute drops of flummoxium out of nothing!",,,,,,,,,,,,,
spell_apotheosis_material_copper_name,"Copper",,,,,,,,,,,,,
spell_apotheosis_material_copper_desc,"Transmute grains of copper out of nothing!",,,,,,,,,,,,,
spell_apotheosis_material_fungi_name,"Fungus",,,,,,,,,,,,,
spell_apotheosis_material_fungi_desc,"Transmute fungal sprouts out of nothing!",,,,,,,,,,,,,
spell_apotheosis_death_cross_omega_name,"Omega Death Cross",,,,,,,,,,,,,
spell_apotheosis_death_cross_omega_desc,"A violent, giant, deadly energy cross that explodes after a short time",,,,,,,,,,,,,
spell_apotheosis_mudman_slimy_name,"Transmute into Mutamies on Slimy Enemies",,,,,,,,,,,,,
spell_apotheosis_mudman_slimy_desc,"Make a projectile transmute a creature into Mutamies upon collision with creatures covered in slime",,,,,,,,,,,,,
spell_apotheosis_cloud_gunpowder_name,"Gunpowder Cloud",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_cloud_gunpowder_desc,"Creates a rain of gunpowder",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_cloud_volcanic_name,"Volcanic Cloud",,,,,,,,,,,,,
spell_apotheosis_cloud_volcanic_desc,"Creates a volcanic rain of lava and ash",,,,,,,,,,,,,
spell_apotheosis_noragdoll_name,"Corpse Sublimation",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_noragdoll_desc,"Magically converts an enemy's corpse to smoke on death",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_trail_enhancer_name,"Trail Enhancer",,,,,,,,,,,,,
spell_apotheosis_trail_enhancer_desc,"Significantly increase the amount of material produced by other trail spells in the wand",,,,,,,,,,,,,
spell_apotheosis_trail_reducer_name,"Trail Reducer",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_trail_reducer_desc,"Significantly reduce the amount of material produced by other trail spells in the wand",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_larpa_delayed_name,"Burst Larpa",,,,,,,,,,,,,
spell_apotheosis_larpa_delayed_desc,"Make a projectile cast a burst of copies after a short delay",,,,,,,,,,,,,
spell_apotheosis_random_homing_name,"Random Homing",,,,,,,,,,,,,
spell_apotheosis_random_homing_desc,"Cast one random homing spell     ",,,,,,,,,,,,,
spell_apotheosis_lua_sharing_name,"Magic Inebriation",,,,,,,,,,,,,
spell_apotheosis_lua_sharing_desc,"Wildly diffuses the magical properties of different projectiles amongst each other",,,,,,,,,,,,,
spell_apotheosis_gluecharge_name,"Glue Charge",,,,,,,,,,,,,
spell_apotheosis_gluecharge_desc,"Imbues a projectile with a sticky charge, that it will release on impact",,,,,,,,,,,,,
spell_apotheosis_electrosphere_name,"Bolt Orb",,,,,,,,,,,,,
spell_apotheosis_electrosphere_desc,"Cast a slow orb which zaps nearby creatures periodically",,,,,,,,,,,,,
spell_apotheosis_sea_berserk_name,"Sea of Berserkium",,,,,,,,,,,,,
spell_apotheosis_sea_berserk_desc,"Summons a large body of Berserkium below the caster",,,,,,,,,,,,,
spell_apotheosis_kindness_to_power_name,"Kindness to Power",,,,,,,,,,,,,
spell_apotheosis_kindness_to_power_desc,"Increase critical hit chance proportional to how many charmed creatures are nearby",,,,,,,,,,,,,
spell_apotheosis_mind_vision_name,"Mind Vision",,,,,,,,,,,,,
spell_apotheosis_mind_vision_desc,"Creatures hit by a projectile are temporarily revealed through fog of war",,,,,,,,,,,,,
spell_apotheosis_water_power_name,"Hydromancy",,,,,,,,,,,,,
spell_apotheosis_water_power_desc,"Reduce mana cost by 30 and increase fire rate when wet",,,,,,,,,,,,,
spell_apotheosis_blood_power_name,"Hemomancy",,,,,,,,,,,,,
spell_apotheosis_blood_power_desc,"Projectiles will pierce 2 times when bloody",,,,,,,,,,,,,
spell_apotheosis_shape_wall_name,"Formation - Wall",,,,,,,,,,,,,
spell_apotheosis_shape_wall_desc,"Casts 5 spells in a wall-shaped pattern",,,,,,,,,,,,,
spell_apotheosis_summon_star_child_name,"Summon Star Child",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_summon_star_child_desc,"Summons a celestial familiar",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
spell_apotheosis_fire_wall_name,"Wall of Fire",,,,,,,,,,,,,
spell_apotheosis_fire_wall_desc,"Summons a wall of fire to ward off foes",,,,,,,,,,,,,
spell_apotheosis_random_burst_name,"Random Cast",,,,,,,,,,,,,
spell_apotheosis_random_burst_desc,"Multicasts between 4 to 8 random spells     ",,,,,,,,,,,,,
spell_apotheosis_jumper_cables_name,"Summon Jumper Cables",,,,,,,,,,,,,
spell_apotheosis_jumper_cables_desc,"Summon a pair of electrifying vices to shock your victims",,,,,,,,,,,,,
spell_apotheosis_chi_name,"Chi",,,,,,,,,,,,,
spell_apotheosis_chi_desc,"Copies every utility-type spell in the wand when cast",,,,,,,,,,,,,
actiondesc_curse_wither_projectile,Creatures hit by a projectile takes 100% extra projectile damage for a time,Пораженная снарядом цель временно получает 100% дополнительного урона от снарядов,O alvo atingido por um projétil recebe mais 100% de dano do projétil por um tempo.,El objetivo golpeado por el proyectil recibe un 100 % más de daño de proyectiles durante un tiempo,"Bewirkt, dass von Projektilen getroffene Ziele eine Zeit lang 100 % zusätzlichen Projektilschaden erleiden",La cible touchée par un projectile subit 100 % de dégâts supplémentaires des projectiles pendant un moment,Il bersaglio colpito dal proiettile subisce il 100% di danni da proiettile in più per un certo periodo,Cel trafiony pociskiem przez pewien czas otrzymuje 100% więcej obrażeń od pocisków,被投射物击中的目标短时间内会受到额外的 100% 投射物伤害,放射物が当たったターゲットが一定期間100%の追加の放射物ダメージを受ける,일정 시간 동안 발사체가 명중한 대상이 대미지를 100% 더 받습니다.,,,
actiondesc_curse_wither_explosion,Creatures hit by a projectile takes 100% extra explosion damage for a time,Пораженная снарядом цель временно получает 100% дополнительного урона от взрывов,O alvo atingido por um projétil recebe mais 100% de dano de explosão por um tempo.,El objetivo golpeado por el proyectil recibe un 100 % más de daño de explosiones durante un tiempo,"Bewirkt, dass von Projektilen getroffene Ziele eine Zeit lang 100 % zusätzlichen Explosionsschaden erleiden",La cible touchée par un projectile subit 100 % de dégâts supplémentaires des explosions pendant un moment,Il bersaglio colpito dal proiettile subisce il 100% di danni da esplosione in più per un certo periodo,Cel trafiony pociskiem przez pewien czas otrzymuje 100% więcej obrażeń od wybuchów,被投射物击中的目标短时间内会受到额外的 100% 爆炸伤害,放射物が当たったターゲットが一定期間100%の追加の爆破ダメージを受ける,일정 시간 동안 폭발이 명중한 대상이 대미지를 100% 더 받습니다.,,,
actiondesc_curse_wither_melee,Creatures hit by a projectile takes 100% extra melee damage for a time,Пораженная снарядом цель временно получает 100% дополнительного урона от рукопашной,O alvo atingido por um projétil recebe mais 100% de dano de ataques corpo a corpo por um tempo.,El objetivo golpeado por el proyectil recibe un 100 % más de daño cuerpo a cuerpo durante un tiempo,"Bewirkt, dass von Projektilen getroffene Ziele eine Zeit lang 100 % zusätzlichen Nahkampfschaden erleiden",La cible touchée par un projectile subit 100 % de dégâts supplémentaires des attaques de mêlée pendant un moment,Il bersaglio colpito dal proiettile subisce il 100% di danni da mischia in più per un certo periodo,Cel trafiony pociskiem przez pewien czas otrzymuje 100% więcej obrażeń od ataków wręcz,被投射物击中的目标短时间内会受到额外的 100% 近战伤害,放射物が当たったターゲットが一定期間100%の追加の近接ダメージを受ける,일정 시간 동안 근접 공격이 명중한 대상이 대미지를 100% 더 받습니다.,,,
actiondesc_curse_wither_electricity,Creatures hit by a projectile takes 100% extra electricity damage for a time,Пораженная снарядом цель временно получает 100% дополнительного урона от электричества,O alvo atingido por um projétil recebe mais 100% de dano de eletricidade por um tempo.,El objetivo golpeado por el proyectil recibe un 100 % más de daño eléctrico durante un tiempo,"Bewirkt, dass von Projektilen getroffene Ziele eine Zeit lang 100 % zusätzlichen Elektrizitätsschaden erleiden",La cible touchée par un projectile subit 100 % de dégâts supplémentaires de l'électricité pendant un moment,Il bersaglio colpito dal proiettile subisce il 100% di danni da elettricità in più per un certo periodo,Cel trafiony pociskiem przez pewien czas otrzymuje 100% więcej obrażeń od elektryczności,被投射物击中的目标短时间内会受到额外的 100% 电力伤害,放射物が当たったターゲットが一定期間100%の追加の電撃ダメージを受ける,일정 시간 동안 전기가 명중한 대상이 대미지를 100% 더 받습니다.,,,
actiondesc_mana_reduce,Adds 30 mana to the wand           ,Добавляет жезлу 30 ед           . маны,Adiciona 30 de mana à varinha           ,Añade 30 maná a la varita           ,Fügt dem Zauberstab 30 Mana hinzu           ,Ajoute 30 points de mana à la baguette           ,Aggiunge 30 punti mana alla bacchetta.           ,Dodaje do różdżki 30 pkt. many           ,向魔杖增加 30 法力           ,30マナを杖に追加する,완드에 마나 30을 추가합니다.           ,,,
spell_apotheosis_cov_desc,"A field of regenerative magic; Uncopyable.",,,,,,,,,,,,,
spell_apotheosis_healing_bolt_desc,"A magical bolt that heals other beings; Uncopyable.",,,,,,,,,,,,,
spell_apotheosis_piercing_shot_desc,"Makes a projectile penetrate 5 times, but become harmful to the caster",,,,,,,,,,,,,
spell_apotheosis_locked_spell_name,"Faulty Magic",,,,,,,,,,,,,
spell_apotheosis_locked_spell_desc,"It seems this magic is unusable after being afflicted by a curse.",,,,,,,,,,,,,
orb_apotheosis_12_desc,"Secrets of controlling the arcane have been unlocked to you.",,,,,,,,,,,,,
orb_apotheosis_14_desc,"Secrets of the drowning depths have been unlocked to you.",,,,,,,,,,,,,
orb_apotheosis_15_desc,"Secrets of unworldly transmutation have been unlocked to you.",,,,,,,,,,,,,
orb_apotheosis_16_desc,"Secrets of wild magic have been unlocked to you.",,,,,,,,,,,,,
book_apotheosis_orbbook_12_name,"Emerald Tablet - Volume XI",,,,,,,,,,,,,
book_apotheosis_orbbook_12_description,"The world shook asunder and cried in neither fear nor joy. \nnor anger nor sadness, nor any \nnor the tears flew above or below, but to the east and west. \nThe world birth itself anew as it grew and took on new forms \nSome creatures were weary \nSome intrigued \nOthers excited \nMany unaware.",,,,,,,,,,,,,
book_apotheosis_orbbook_13_name,"Emerald Tablet - Volume XII",,,,,,,,,,,,,
book_apotheosis_orbbook_13_description,"There once was a time the world froze to a halt.\nThe water didn't flow, the heart didn't beat and the box didn't fall.\nAfter a moment time flowed again as it always did, however,\nsomething was missing afterwards.\nLook around you, do you not sense it?\nIt is our pursuit to discover what that thing was.",,,,,,,,,,,,,
book_apotheosis_orbbook_14_name,"Emerald Tablet - Volume XIII",,,,,,,,,,,,,
book_apotheosis_orbbook_14_description,"The bird cackled and sang\nWhat good is one's time if it is without encouragement?\nTo those who dream when they feel, they know not the encouragement\nof knowing what to do before their dream and how much.\nTo those who plan their dream ahead of time, when and where,\nthey know what they can do and what time they have to do it.\nThe bird cackled once more before it flew off.\nIt's wisdom soaked into the minds of those who heard it, \nas water soaked into glass.",,,,,,,,,,,,,
book_apotheosis_orbbook_15_name,"Emerald Tablet - Volume XIV",,,,,,,,,,,,,
book_apotheosis_orbbook_15_description,"If only you knew how the mountains were made.\nHow the rivers flowed,\nWhy the emeralds were heavy,\nWhat creature made the eternal fire.\nOur art is not wrapped in layers of secrecy because we hide it.\nYou can know, but choose not to, and so are left with nothing to do but pray to your gods for salvation.",,,,,,,,,,,,,
book_apotheosis_orbbook_stone_workinprogress_description,"Seeker of knowledge, your nose is on the right path \nyet some secrets are yet to be revealed.",,,,,,,,,,,,,
book_apotheosis_orbbook_stone_12_description,"Evolution is forever changing.",,,,,,,,,,,,,
book_apotheosis_orbbook_stone_13_description,"Bring your friends along when you travel.",,,,,,,,,,,,,
book_apotheosis_orbbook_stone_14_description,"To gain true knowledge, one must remain pure and unintoxicated.",,,,,,,,,,,,,
book_apotheosis_orbbook_stone_15_description,"Attune with and home in on your goals;\nDo so and your arrow shall move faster.",,,,,,,,,,,,,
book_apotheosis_playerghost_name,"A Message From Beyond",,,,,,,,,,,,,
book_apotheosis_playerghost_description,"Stake your eyes on these glyphs. \nFor in time, they too shall change.",,,,,,,,,,,,,
book_apotheosis_materia_conversion_spell_description_new,Conversion.. \nRemember these words.... \nFungus \nWorm \nRat \nSpark \nMass,Превращение... \nЗапомните эти слова.... \nГрибок \nЧервь \nКрыса \nИскровая \nМассовая,,,,,,,,Kono kotoba wo oboete oku youni...\nKinoko \nWorm \nNezumi \nHibana \nSutētasu,,,,
book_apotheosis_material_spells_name,"Lost Alchemy",,,,,,,,,,,,,
book_apotheosis_material_spells_description,"I used to commit alchemy here a long time ago, it was a safe hideaway where my brothers wouldn't bother me. \nHowever.. it seems these ants have taking a liking to it. \n..Never the matter, to my future self, the master of alchemy, \nTurn this metal into a material which aids with flight, and your vault will be unlocked to you. \nIf you're someone who isn't me and you found this place, please leave what you found untouched.",,,,,,,,,,,,,
book_apotheosis_omegadeath_name,"Death",,,,,,,,,,,,,
book_apotheosis_omegadeath_description,"Follow my exact path only. I detailed it in the land containing the diamond \nOnly the uninitiated will bare usefulness to this knowledge to avoid corruption among our ranks, \nso teach the right way to teleport only to those pure \nThose who have strayed from my pathway will not be rewarded with death",,,,,,,,,,,,,
book_apotheosis_realquest_name,"Day 7",,,,,,,,,,,,,
book_apotheosis_realquest_description,"I've come here in search of the legendary Red Fish, I remember it's name on the tip of my tongue..\nSomething starting with H.. yet I can't recall it\nNo matter, I'll name it after myself after I become the first to discover it.\nThen I'll never forget it's name again!",,,,,,,,,,,,,
book_apotheosis_realquest_alt_name,"Day 297",,,,,,,,,,,,,
book_apotheosis_realquest_alt_description,"Remember.\nThe red fish is real.\nThe red fish is real.\nThe red fish is real.\nThe red fish is real.\nThe red fish is real\nThe red fish is reall\nThe red f",,,,,,,,,,,,,
book_apotheosis_realquest_tale_name,"Gone Fishing",,,,,,,,,,,,,
book_apotheosis_realquest_tale_description,"The grand red fish is divine bait, only with it will one catch \nthe grandest of beasts lying at the ocean's trench.\nFinding such a specimen often requires one's entire life however, \nand those who have tried often return without fruit or holding defeat.\nTales speak of the red fish coming to those who wait patiently at the water, \nbut only if your palm holds the right blessing.",,,,,,,,,,,,,
perk_apotheosis_shield_oversized_name,"Oversized Shield",,,,,,,,,,,,,
perk_apotheosis_shield_oversized_description,"You gain a very large, permanent shield.",,,,,,,,,,,,,
perk_apotheosis_haste_name,"Haste",,,,,,,,,,,,,
perk_apotheosis_haste_description,"You move faster and levitate quicker.",,,,,,,,,,,,,
perk_apotheosis_contactdamage_description,"You take no damage from close-range enemy attacks but enemies near you take damage.",,,,,,,,,,,,,
perk_apotheosis_alcohol_immunity,"Alcohol Immunity",,,,,,,,,,,,,
perk_apotheosis_alcohol_immunity_description,"You take no effect to being drunk.",,,,,,,,,,,,,
perk_apotheosis_trip_immunity,"Shift Immunity",,,,,,,,,,,,,
perk_apotheosis_trip_immunity_description,"The world is set in stone and can not be shifted so long as you live.",,,,,,,,,,,,,
perk_apotheosis_no_recoil,"No Recoil",,,,,,,,,,,,,
perk_apotheosis_no_recoil_description,"Your spells have no recoil.",,,,,,,,,,,,,
perk_apotheosis_void,"Void",,,,,,,,,,,,,
perk_apotheosis_void_description,"Gain immense power, but the void grows jealous of your options.",,,,,,,,,,,,,
perk_apotheosis_infinite_flight,"Our Gift",,,,,,,,,,,,,
perk_apotheosis_infinite_flight_description,"A divine blessing grants you infinite flight.",,,,,,,,,,,,,
perk_apotheosis_copy_spells,"Copy Spells",,,,,,,,,,,,,
perk_apotheosis_copy_spells_description,"Copy the Uncopyable.",,,,,,,,,,,,,
perk_apotheosis_curse_mana,"Endless Mana",,,,,,,,,,,,,
perk_apotheosis_curse_mana_reveal,"Curse of Mana",,,,,,,,,,,,,
perk_apotheosis_curse_mana_description,"Your wands feel terribly unstable.. but have infinite mana!",,,,,,,,,,,,,
perk_apotheosis_curse_mana_description_reveal,"You have infinite mana.. but feel horribly sick...",,,,,,,,,,,,,
perk_apotheosis_curse_mana_disrupt,"Disrupted Mana",,,,,,,,,,,,,
perk_apotheosis_curse_mana_disrupt_description,"Your wands are unable to cast!",,,,,,,,,,,,,
perk_apotheosis_no_blood,"Smoked Corpses",,,,,,,,,,,,,
perk_apotheosis_no_blood_description,"Enemies leave behind no corpse, and bleed no blood.",,,,,,,,,,,,,
perk_apotheosis_god_ti,"Divine Intervention",,,,,,,,,,,,,
perk_apotheosis_god_ti_description,"The gods will cause something sporadic to occur every 3-4 minutes.",,,,,,,,,,,,,
perk_apotheosis_plane_radar,"Divine Radar",,,,,,,,,,,,,
perk_apotheosis_plane_radar_description,"You can sense otherworldy energy somewhere in the world.",,,,,,,,,,,,,
status_apotheosis_nohealing_name,"Wounded",,,,,,,,,,,,,
status_apotheosis_nohealing_desc,"You can not be healed.",,,,,,,,,,,,,
status_apotheosis_magicwet_intense_ui,"Intense Wetness",,,,,,,,,,,,,
status_drunk_intense_ui,"Aura of Spirits",,,,,,,,,,,,,
status_apotheosis_magicurine_intense_ui,"Magic Incontinence",,,,,,,,,,,,,
status_apotheosis_magicfire_intense_ui,"Cursed Flames",,,,,,,,,,,,,
status_apotheosis_dry_spell_name,"Infiltrated",,,,,,,,,,,,,
status_apotheosis_dry_spell_desc,"Your stains are set in stone, nothing can be removed and nothing can be added.",,,,,,,,,,,,,
status_apotheosis_infinite_flight_name,"Limitless Flight",,,,,,,,,,,,,
status_apotheosis_infinite_flight_desc,"You can fly forever.",,,,,,,,,,,,,
status_apotheosis_escapium_name,"Safe Escape",,,,,,,,,,,,,
status_apotheosis_escapium_desc,"A protective barrier shields you, and you feel faster.",,,,,,,,,,,,,
status_apotheosis_projectile_immunity_name,"Projectile Assimilation",,,,,,,,,,,,,
status_apotheosis_projectile_immunity_desc,"You heal from projectiles.",,,,,,,,,,,,,
status_apotheosis_homing_name,"Projectile Attunement",,,,,,,,,,,,,
status_apotheosis_homing_desc,"Your spells seek targets automatically.",,,,,,,,,,,,,
status_apotheosis_light_reflect_name,"Magical Light",,,,,,,,,,,,,
status_apotheosis_light_reflect_desc,"Taking damage causes you to retaliate with a beam of light.",,,,,,,,,,,,,
status_apotheosis_breath_drain_name,"Suffocating",,,,,,,,,,,,,
status_apotheosis_breath_drain_desc,"You are rapidly loosing oxygen!!",,,,,,,,,,,,,
status_apotheosis_speedup_name,"Accelerated Velocity",,,,,,,,,,,,,
status_apotheosis_speedup_desc,"Your spells feel significantly faster.",,,,,,,,,,,,,
status_apotheosis_clear_status_name,"Pure Stomach",,,,,,,,,,,,,
status_apotheosis_clear_status_desc,"Your stomach is clear from negative effects you've ingested.",,,,,,,,,,,,,
status_apotheosis_rideshare_name,"Portalic Rideshare",,,,,,,,,,,,,
status_apotheosis_rideshare_desc,"You feel nearby creatures will follow you through portals.",,,,,,,,,,,,,
status_apotheosis_hex_water_name,"Abyssal Hex",,,,,,,,,,,,,
status_apotheosis_hex_water_desc,"You take damage from water and other wet substances.",,,,,,,,,,,,,
status_apotheosis_hex_oil_name,"Industrious Hex",,,,,,,,,,,,,
status_apotheosis_hex_oil_desc,"You take damage from oil and other oily substances.",,,,,,,,,,,,,
status_apotheosis_hex_blood_name,"Lively Hex",,,,,,,,,,,,,
status_apotheosis_hex_blood_desc,"You take damage from blood and other bloody substances.",,,,,,,,,,,,,
status_apotheosis_protection_all_dull_name,"Shattered Protection",,,,,,,,,,,,,
status_apotheosis_protection_all_dull_desc,"Provides no protection, spreads to nearby ambrosia.",,,,,,,,,,,,,
status_apotheosis_infusion_vulnerability_name,"Vulnerable Infusion",,,,,,,,,,,,,
status_apotheosis_infusion_vulnerability_desc,"Your attacks inflict vulnerability.",,,,,,,,,,,,,
status_apotheosis_infusion_hex_water_name,"Water Hex Infusion",,,,,,,,,,,,,
status_apotheosis_infusion_hex_water_desc,"Your attacks inflict Abyssal Hex.",,,,,,,,,,,,,
status_apotheosis_no_flight_name,"Grounded",,,,,,,,,,,,,
status_apotheosis_no_flight_desc,"You are unable to levitate.",,,,,,,,,,,,,
status_apotheosis_creature_shifted_name,"The evolution has shifted",,,,,,,,,,,,,
status_apotheosis_creature_shifted_desc,"You sense life is no longer what it used to be.",,,,,,,,,,,,,
statusdesc_curse_wither_projectile,You take 100% extra damage from projectiles.,Вы получаете 100% дополнительного урона от снарядов.,Você recebe mais 100% de dano de projéteis.,Recibes 100 % más de daño de proyectiles.,Du erleidest 100 % zusätzlichen Schaden durch Projektile.,Vous subissez 100 % de dégâts supplémentaires des projectiles.,Subisci il 100% in più di danni da proiettili.,Otrzymujesz 100% więcej obrażeń od pocisków.,投射物额外对你造成 100% 伤害。,放射物から100%の追加ダメージを受ける。,발사체로부터 대미지를 100% 더 받습니다.,,,
statusdesc_curse_wither_explosion,You take 100% extra damage from explosions.,Вы получаете 100% дополнительного урона от взрывов.,Você recebe mais 100% de dano de explosões.,Recibes 100 % más de daño de explosiones.,Du erleidest 100 % zusätzlichen Schaden durch Explosionen.,Vous subissez 100 % de dégâts supplémentaires des explosions.,Subisci il 100% in più di danni da esplosioni.,Otrzymujesz 100% więcej obrażeń od wybuchów.,爆炸额外对你造成 100% 伤害。,爆破から100%の追加ダメージを受ける。,폭발로부터 대미지를 100% 더 받습니다.,,,
statusdesc_curse_wither_melee,You take 100% extra damage from melee attacks.,Вы получаете 100% дополнительного урона от рукопашных атак.,Você recebe mais 100% de dano de ataques corpo a corpo.,Recibes 100 % más de daño de ataques cuerpo a cuerpo.,Du erleidest 100 % zusätzlichen Schaden durch Nahkampfangriffe.,Vous subissez 100 % de dégâts supplémentaires des attaques de mêlée.,Subisci il 100% in più di danni da mischia.,Otrzymujesz 100% więcej obrażeń od ataków wręcz.,近战攻击额外对你造成 100% 伤害。,近接攻撃から100%の追加ダメージを受ける。,근접 공격으로부터 대미지를 100% 더 받습니다.,,,
statusdesc_curse_wither_electricity,You take 100% extra damage from electricity.,Вы получаете 100% дополнительного урона от электричества.,Você recebe mais 100% de dano de eletricidade.,Recibes 100 % más de daño de electricidad.,Du erleidest 100 % zusätzlichen Schaden durch Elektrizität.,Vous subissez 100 % de dégâts supplémentaires de l'électricité.,Subisci il 100% in più di danni da elettricità.,Otrzymujesz 100% więcej obrażeń od elektryczności.,雷电额外对你造成 100% 伤害。,電撃から100%の追加ダメージを受ける。,전기로부터 대미지를 100% 더 받습니다.,,,
creep_apotheosis_boss_flesh_monster_name,"Kerettiläinenhirviö",,,,,,,,,,,,,
log_apotheosis_fish,"The red fish is real",,,,,,,,,,,,,
log_apotheosis_shift_blocked_name,"Shift Blocked",,,,,,,,,,,,,
log_apotheosis_shift_blocked_desc,"The world is set in stone.",,,,,,,,,,,,,
log_apotheosis_upgrade_alwayscast_cheater_name,"You cannot cheat the gods!",,,,,,,,,,,,,
log_apotheosis_upgrade_alwayscast_cheater_desc,"Always cast upgrade can only be used once",,,,,,,,,,,,,
log_apotheosis_upgrade_alwayscast_success_name,"A permanent enchantment sinks into your wand",,,,,,,,,,,,,
log_apotheosis_upgrade_alwayscast_success_desc,"Some things can never be undone...",,,,,,,,,,,,,
log_apotheosis_flesh_boss_warning,"Something wicked this way comes...",,,,,,,,,,,,,
item_apotheosis_egg_fire_lukki_name,"Volcanic Egg",,,,,,,,,,,,,
item_apotheosis_egg_fire_lukki_desc,"It feels warm to the touch.",,,,,,,,,,,,,
item_apotheosis_chest_death_cross,"Deathly Chest",,,,,,,,,,,,,
item_apotheosis_egg_fairy_name,"Glowing Egg",,,,,,,,,,,,,
item_apotheosis_egg_fairy_desc,"The egg looks luminescent",,,,,,,,,,,,,
item_apotheosis_egg_robot_name,"Robotic Egg",,,,,,,,,,,,,
item_apotheosis_egg_robot_desc,"The egg feels like it's moving",,,,,,,,,,,,,
item_apotheosis_egg_mud_name,"Muddy Egg",,,,,,,,,,,,,
item_apotheosis_egg_mud_desc,"The egg feels amorphous",,,,,,,,,,,,,
item_apotheosis_money_1,Gold nugget (1),Золотой самородок (1),Pepita de ouro (1),Pepita de oro (1),Goldklumpen (1),Pépite d'or (1),Pepita d'oro (1),Grudka złota (1),金块 (1),金塊 (1),황금 덩어리(1),,,
item_apotheosis_bloodmoney_1,Bloody gold nugget (1),Кровавый золотой самородок (1),Pepita de ouro ensanguentada (1),Pepita de oro sangrienta (1),Blutiger Goldklumpen (1),Pépite d'or ensanglantée (1),Pepita d'oro insanguinata (1),Krwaw grudka złota (1),染血金块 (1),ブラッディー金塊 (1),피투성이 황금 덩어리(1),,,
item_apotheosis_stone_heretic_name,"Korruptoitunutkivi",,,,,,,,,,,,,
item_apotheosis_stone_heretic_desc,"It feels drenched in blood.",,,,,,,,,,,,,
item_apotheosis_stone_radar_name,"Opastavakivi",,,,,,,,,,,,,
item_apotheosis_stone_radar_desc,"It pulses strangely.",,,,,,,,,,,,,
item_apotheosis_potion_reinforced_name,"Large Potion",,,,,,,,,,,,,
item_apotheosis_potion_reinforced_name_with_material,"$0 Large Potion",,,,,,,,,,,,,
item_apotheosis_orb_mattereater_name,"Hungry Orb","Голодный шар",,,,,,,,,,,,
item_apotheosis_orb_mattereater_desc,"You feel the matter around it being sucked in. What happens if you kick it, you wonder...",,,,,,,,,,,,,
item_apotheosis_orb_affluence_name,"Affluent Orb",,,,,,,,,,,,,
item_apotheosis_orb_affluence_desc,"You can see reflections of endless treasure within it. What happens if you kick it, you wonder...",,,,,,,,,,,,,
item_apotheosis_sampo_33_name,"Heretical Knowledge",,,,,,,,,,,,,
item_apotheosis_sampo_34_name,"Our Gift",,,,,,,,,,,,,
sign_apotheosis_custom_seed,"Custom Seed successfully set",,,,,,,,,,,,,
wand_apotheosis_deck_of_cards_name,"Korttipakka",,,,,,,,,,,,"DOESN'T NEED TO BE TRANSLATED",
wand_apotheosis_aimbot_name,"Wand of Aiming",,,,,,,,,,,,,
wand_apotheosis_rat_name,"Rat",,,,,,,,,,,,,
wand_apotheosis_cat_name,"Cat",,,,,,,,,,,,,
wand_apotheosis_mana_battery_name,"Mana Battery",,,,,,,,,,,,,
wand_apotheosis_wand_of_wonders_name,"Wand of Wonders",,,,,,,,,,,,,
damage_apotheosis_reverberation,"Sound Waves",,,,,,,,,,,,,
damage_apotheosis_toxic_sphere,"Toxic Sphere",,,,,,,,,,,,,
curse_apotheosis_yggdrasil_name,"Yggdrasil's Curse",,,,,,,,,,,,,
curse_apotheosis_yggdrasil_desc,"You can no longer teleport. \nYou are unable to levitate.",,,,,,,,,,,,,
curse_apotheosis_glassed_name,"Glassed Curse",,,,,,,,,,,,,
curse_apotheosis_glassed_desc,"All creatures have glass cannon.",,,,,,,,,,,,,
curse_apotheosis_hardcore_name,"Hardcore",,,,,,,,,,,,,
curse_apotheosis_hardcore_desc,"Healing Spells are uncopyable.\nMost enemies have additional health depending on the biome.\nSome creatures from late game biomes may have additional attack speed.\nMost bosses have significantly increased health.\nAlt-Fire teleport bolt replaces normal teleport bolt.\nEnemies spawn 1 NG+ level earlier.",,,,,,,,,,,,,
curse_apotheosis_missingspells_name,"Missing Spells",,,,,,,,,,,,,
curse_apotheosis_missingspells_desc,"Half of all spells are removed from reality.",,,,,,,,,,,,,
curse_apotheosis_towerclimb_name,"Towerclimb",,,,,,,,,,,,,
curse_apotheosis_towerclimb_desc,"All biomes can spawn any creature.",,,,,,,,,,,,,
motd_apotheosis,Message of the Day,Сообщение дня,,,,,,,,,,,,
motd_apotheosis_description,"Message of the Day \nYou shouldn't be reading this.","Сообщение дня \nВы не должны были это прочесть.",,,,,,,,,,,,
motd_apotheosis_description_birthday,"Message of the Day \nHappy Birthday Apotheosis","Сообщение дня \nПоздравлем с днём рождения, Apotheosis",,,,,,,,,,,,
motd_apotheosis_description_halloween,"Message of the Day \nHappy Halloween!","Сообщение дня \nСчастливого Хэллоуина!",,,,,,,,,,,,
motd_apotheosis_description_smissmass,"Message of the Day \nHappy Noitmass!","Сообщение дня \nСчастливого Нойтждества!",,,,,,,,,,,,
motd_apotheosis_description_new_year,"Happy new year! \nThankyou for playing, although you'll only read this once a year, I mean it every time you play. \nI'm happy seeing people enjoy my projects, and I'm happy making them myself, so sincerely, thankyou. - Conga Lyne.",,,,,,,,,,,,,
motd_apotheosis_description_red_fish,"Message of the Day \nThe Red Fish is real.",,,,,,,,,,,,,
motd_apotheosis_description_001,"Message of the Day \nAlso try Worse Enemies!","Сообщение дня \nТакже попробуйте мод Worse Enemies!",,,,,,,,,,,,
motd_apotheosis_description_002,"Message of the Day \nHobos love Material Donations","Сообщение дня \nБродяги любят пожертвования в виде денег",,,,,,,,,,,,
motd_apotheosis_description_003,"Message of the Day \nBlood is Fuel.","Сообщение дня \nКровь - это топливо.",,,,,,,,,,,,
motd_apotheosis_description_004,"Message of the Day \nAlso try Copis Things!","Сообщение дня \nТакже попробуйте мод Copis Things!",,,,,,,,,,,,
motd_apotheosis_description_005,"Message of the Day \nMeow. Meow. Meow. Meow. Meow.","Сообщение дня \nМяу. Мяу. Мяу. Мяу. Мяу.",,,,,,,,,,,,
motd_apotheosis_description_006,"Message of the Day \nGo outside.",,,,,,,,,,,,,
motd_apotheosis_description_007,"Message of the Day \nApotheosis successfully initialised.",,,,,,,,,,,,,
motd_apotheosis_description_008,"Message of the Day \nHey? Can you hear me?! Get out while you still can!! HURRY.","Сообщение дня \nЭй? Вы меня слышите?! Уходите, пока ещё не поздно!!! СКОРЕЕ.",,,,,,,,,,,,
motd_apotheosis_description_009,"Message of the Day \nAlso try Chemical Curiosities!","Сообщение дня \nТакже попробуйте мод Chemical Curiosities!",,,,,,,,,,,,
motd_apotheosis_description_010,"Message of the Day \nEat crayons for divine knowledge.",,,,,,,,,,,,,
motd_apotheosis_description_011,"Message of the Day \nRemember to check your wand before firing!",,,,,,,,,,,,,
motd_apotheosis_description_012,"Message of the Day \nI have 7 very important lore related questions.",,,,,,,,,,,,,
motd_apotheosis_description_013,"Message of the Day \nToday's magic numbers are: 78 40 28 59 20 13",,,,,,,,,,,,,
motd_apotheosis_description_014,"Message of the Day \nEsoteric Beings fear curses.",,,,,,,,,,,,,
motd_apotheosis_description_015,"Message of the Day \nCan you hear ghosts? \nWithout assistance?",,,,,,,,,,,,,
motd_apotheosis_description_016,"Message of the Day \nMasters of Trolling like red outlines. \nThey'll fit right in","Сообщение дня \nМастера троллинга любят красные контуры. \nОни отлично впишутся",,,,,,,,,,,,
motd_apotheosis_description_017,"Message of the Day \nMusical Beings fear more than just stones....","Сообщение дня \nМузыкальные существа боятся больше, чем просто камней....",,,,,,,,,,,,
motd_apotheosis_description_018,"Message of the Day \nKnowledge is scattered around the world.. find it.","Сообщение дня \nЗнания разбросаны по всему миру... найдите их.",,,,,,,,,,,,
motd_apotheosis_description_019,"Message of the Day \nTry as you might, some creatures take all but a single chip from your attacks.",,,,,,,,,,,,,
motd_apotheosis_description_020,"Message of the Day \nThe coldest Magical temple may hold vital treasure. \nJust don't descend.","Сообщение дня \nСамый холодный магический храм может содержать жизненно важные сокровища. \nПросто не спускайтесь.",,,,,,,,,,,,
motd_apotheosis_description_021,"Message of the Day \nRed sand is delicious!",,,,,,,,,,,,,
motd_apotheosis_description_022,"Message of the Day \nThankyou for helping us get this far!",,,,,,,,,,,,,
motd_apotheosis_description_023,"Message of the Day \nPerhaps not every creep is a hostile. \nPerhaps not every crystal is a threat.","Сообщение дня \nПожалуй, не каждый гад - враг. \Возможно, не каждый кристалл является угрозой.",,,,,,,,,,,,
motd_apotheosis_description_024,"Message of the Day \nAlso try Conga's Cats! ...Just not with Apotheosis enabled. \nApotheosis cats override Conga's Cats' cats... Update your settings!!!","Сообщение дня \nТакже попробуйте мод Congas Cats! ...только не с включенным модом Apotheosis. \nКошки из мода Apotheosis будут конфликтовать с кошками мода Congas Cats... Обновите настройки!!!",,,,,,,,,,,,
motd_apotheosis_description_025,"Message of the Day \nFun Fact, Despite this mod releasing on 24/10/2022, \nthe birthday event occurs in July to avoid clashing with Halloween.","Сообщение дня \nПрикольный факт, несмотря на то, что этот мод вышел 10.24.2022, \n праздник дня рождения происходит в ноябре, чтобы избежать столкновения с Хэллоуином.",,,,,,,,,,,,
motd_apotheosis_description_026,"Message of the Day \nGoodluck and have fun!. \nIf you're feeling frustrated or stressed, remember to take a break.","Сообщение дня \nУдачи и веселья! \nЕсли вы чувствуете разочарование или стресс, не забудьте сделать перерыв.",,,,,,,,,,,,
motd_apotheosis_description_027,"Message of the Day \nI believe in you.","Сообщение дня \nЯ верю в вас.",,,,,,,,,,,,
motd_apotheosis_description_028,"Message of the Day \nFor a fun time: pour the densest liquid in the overgrowth",,,,,,,,,,,,,
motd_apotheosis_description_029,"Message of the Day \nVenture into the desert. \nThere I will humour you.",,,,,,,,,,,,,
motd_apotheosis_description_030,"Message of the Day \nHappy today! Good Now, be happy you're still here!","Сообщение дня \nСчастливый день! Счастливо, будьте счастливы, что вы ещё здесь!",,,,,,,,,,,,
motd_apotheosis_description_031,"Message of the Day \nDon't visit the Toxic Worm Nest at 3 am.","Сообщение дня \nНе посещайте гнездо токсичных червей в 3 часа ночи.",,,,,,,,,,,,
motd_apotheosis_description_alt_001,"Message of the Day \nAlso try Grahams Things!",,,,,,,,,,,,,
motd_apotheosis_description_alt_002,"Message of the Day \nBe weary when travelling to other worlds.",,,,,,,,,,,,,
motd_apotheosis_description_alt_003,"Message of the Day \nStay inside.",,,,,,,,,,,,,
motd_apotheosis_description_alt_004,"Message of the Day \nDid you eat your powerballs today?",,,,,,,,,,,,,
motd_apotheosis_description_alt_005,"Message of the Day \nSourcream with Polish Sausage is delicious.",,,,,,,,,,,,,
motd_apotheosis_description_alt_006,"Message of the Day \nEver have one of those days?",,,,,,,,,,,,,
motd_apotheosis_description_alt_007,"Message of the Day \nApotheosis\nmade by Conga & Friends",,,,,,,,,,,,,
motd_apotheosis_description_alt_008,"Message of the Day \nWelcome Back\nI'm sure your wand seemed more intuitive in the design docs.",,,,,,,,,,,,,
motd_apotheosis_description_alt_009,"Message of the Day \nWan Wan!",,,,,,,,,,,,,
motd_apotheosis_description_alt_010,"Message of the Day \nRobin was a fool.",,,,,,,,,,,,,
motd_apotheosis_description_alt_011,"Message of the Day \nBe honest with your feelings.\nBe honest with yourself.",,,,,,,,,,,,,
motd_apotheosis_description_alt_012,"Message of the Day \nYou are not a clown, you are the entire circus.",,,,,,,,,,,,,
motd_apotheosis_description_alt_013,"Message of the Day \nFriendship is a step on the path to success.",,,,,,,,,,,,,
motd_apotheosis_description_alt_014,"Message of the Day \nPortalium is my favourite liquid.\nWhat's yours?",,,,,,,,,,,,,
motd_apotheosis_description_alt_015,"Message of the Day \nAlso try More Stuff!",,,,,,,,,,,,,
motd_apotheosis_description_alt_016,"Message of the Day \n1432",,,,,,,,,,,,,
motd_apotheosis_description_alt_017,"Message of the Day \nIf fighting is sure to result in victory,\nthen you must FIGHT!",,,,,,,,,,,,,
motd_apotheosis_description_alt_018,"Message of the Day \nBlue fire doesn't always mean cold fire...",,,,,,,,,,,,,
motd_apotheosis_description_alt_031,"Message of the Day \nDon't visit the Toxic Worm Nest at 3 am.","Сообщение дня \nНе посещайте гнездо токсичных червей в 3 часа ночи.",,,,,,,,,,,,
]])

--Yggdrasil's Knowledge (The knowledge of life)
--
--Custom Spell Border for one-off spells would be sick
--
--Previous contact damage description
--perk_apotheosis_contactdamage_description,"You take no damage from close-range enemy attacks but enemies near you take damage; the damage is higher the lower your health gets.",,,,,,,,,,,,,




--Regular Spawns

ModLuaFileAppend( "data/scripts/biomes/wizardcave.lua", "mods/Apotheosis/files/scripts/biomes/wizardcave_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/tower_end.lua", "mods/Apotheosis/files/scripts/biomes/tower_end_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/coalmine_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/the_end_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/desert.lua", "mods/Apotheosis/files/scripts/biomes/desert_populator.lua" )

ModLuaFileAppend( "data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/crypt_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/pyramid_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/fungicave_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/coalmine_alt_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/pyramid_hallway.lua", "mods/Apotheosis/files/scripts/biomes/pyramid_hallway_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/liquidcave.lua", "mods/Apotheosis/files/scripts/biomes/liquidcave_populator.lua" )


ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/vault_frozen.lua", "mods/Apotheosis/files/scripts/biomes/vault_frozen_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/fungiforest.lua", "mods/Apotheosis/files/scripts/biomes/fungiforest_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/Apotheosis/files/scripts/biomes/snowcastle_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/Apotheosis/files/scripts/biomes/snowcave_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/wandcave.lua", "mods/Apotheosis/files/scripts/biomes/wandcave_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/meat.lua", "mods/Apotheosis/files/scripts/biomes/meat_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/sandcave_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/vault_populator.lua" )
--ModLuaFileAppend( "data/scripts/biomes/tower.lua", "mods/Apotheosis/files/scripts/biomes/tower_populator.lua" )
ModLuaFileAppend( "data/scripts/biomes/rainforest.lua", "mods/Apotheosis/files/scripts/biomes/rainforest_populator.lua" ) --Jungle
ModLuaFileAppend( "data/scripts/biomes/rainforest_dark.lua", "mods/Apotheosis/files/scripts/biomes/rainforest_dark_populator.lua" ) --Lukki Lair
ModLuaFileAppend( "data/scripts/biomes/winter.lua", "mods/Apotheosis/files/scripts/biomes/winter_populator.lua" ) --Snow Chasm
ModLuaFileAppend( "data/scripts/biomes/clouds.lua", "mods/Apotheosis/files/scripts/biomes/clouds_populator.lua" ) --Cloud Scape, for example coral chest area & essence of air area
ModLuaFileAppend( "data/scripts/biomes/robobase.lua", "mods/Apotheosis/files/scripts/biomes/robobase_populator.lua" ) --Power Plant
ModLuaFileAppend( "data/scripts/biomes/lake_statue.lua", "mods/Apotheosis/files/scripts/biomes/lake_statue_populator.lua" ) --Lake Island
ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/Apotheosis/files/scripts/biomes/hills_populator.lua" ) --Hills and shallow caves
ModLuaFileAppend( "data/scripts/biomes/robot_egg.lua", "mods/Apotheosis/files/scripts/biomes/robot_egg_populator.lua" ) --End of Everything Robotic Egg

--Not looking quite as good as the statues, might need a different art approach
--ModLuaFileAppend( "data/scripts/biomes/mountain_tree.lua", "mods/Apotheosis/files/scripts/biomes/mountain_tree_populator.lua" ) --Treechievements


ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Apotheosis/files/actions.lua" )

ModLuaFileAppend( "data/scripts/gun/gun.lua", "mods/Apotheosis/files/gun.lua" )







--Appends Global Spawns to vanilla biome
do  -- Global Spawns
  --DO NOT INCLUDE ANYTHING TOWER RELATED HERE, they're... "special" and need to be done in their own unique way
  for _, append in ipairs({
    { -- General
      script = "global_populator",
      biomes = {
        "wizardcave",       --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.
        "coalmine",         --Coal Mine, first area, goodluck on your run
        "desert",           --Desert above ground, careful not to die to any Stendari
        "crypt",            --Temple of the Arts.. who died here?
        "pyramid",          --Presumably everything below the entrance to the pyramid
        "fungicave",        --BUNGUS!! cave, west side of area 2 for example
        "coalmine_alt",     --Coalmine but to the west side near damp cave
        "pyramid_hallway",  --Pyramid entrance, presumably
        "excavationsite",   --Coal Pits, area 2
        "fungiforest",      --Overgrowth
        "snowcave",         --Snowy Depths
        "wandcave",         --Magical temple.. huh
        "sandcave",         --Desert sand cave, I don't think it includes desert chasm
        "winter",           --Winter appears to be the snow chasm... terrifying. Also line 69!
        "rainforest",       --Jungle
        "rainforest_dark",  --Lukki Lair.. creepy
        "liquidcave",       --Abandoned Alchemy Lab
      }
    },
    { -- No Magic
      script = "global_populator_no_magic",
      biomes = {
        "the_end",          --Heaven, or Hell, your choice. Either are The Work.
        "vault",            --The Vault
        "robot_egg",        --I'm sure you can guess
        "vault_frozen",     --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
        "snowcastle",       --Hisii Base... Interesting name.. I won't judge.. too much, I've used some really weird inengine names myself in the past
        "robobase",         --Power Plant
      }
    },
    { -- Small Only
      script = "global_populator_smallonly",
      biomes = {
        "clouds",           --Cloudscapes
        "hills",            --Hills, aka forest.
      }
    },
  }) do
    -- Generate append script file path
    local appendpath = table.concat({"mods/apotheosis/files/scripts/biomes/", append.script, ".lua"})
    -- Iterate over all biomes for the path
    for _, biome in ipairs(append.biomes) do
      -- Generate biome file path
      local biomepath = table.concat({"data/scripts/biomes/", biome, ".lua"})
      -- Add the stuff
      ModLuaFileAppend(biomepath, appendpath)
    end
  end
end

--Appends Global Spawns to new biome files
do  -- Global Spawns
  --DO NOT INCLUDE ANYTHING TOWER RELATED HERE, they're... "special" and need to be done in their own unique way
  for _, append in ipairs({
    { -- General
      script = "global_populator",
      biomes = {
        "lava_excavation",       --Core Mines, Volcanic lava filled land in the desert with plenty of loot but plenty of death
        "evil_temple",       --Temple of Sacriligious Remains
      }
    },
  }) do
    -- Generate append script file path
    local appendpath = table.concat({"mods/apotheosis/files/scripts/biomes/", append.script, ".lua"})
    -- Iterate over all biomes for the path
    for _, biome in ipairs(append.biomes) do
      -- Generate biome file path
      local biomepath = table.concat({"mods/apotheosis/files/scripts/biomes/newbiome/", biome, ".lua"})
      -- Add the stuff
      ModLuaFileAppend(biomepath, appendpath)
    end
  end
end



--- Boss Spawns
--These use the Mountain Hall for biome compatibility.

--[[

--Spawns Toxic Worm boss after filling the dragon egg with toxic sludge
--This was the original intent, now the Toxic Worm spawns inside of a "nest" area of sorts with an egg, approach it and get got!
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/toxic_worm_nest_populator.lua" )


--Spawns the Abandoned Orchestra in the sandcaves.
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/boss_musical_ghost_sandcave_populator.lua" )


--Spawns a Magic Devourer inside the Abandoned Alchemy Lab to show off its' gimmick, only one though, and the only one with cell eater capabilities in the entire game!
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/devourer_magic_liquidcave_spawn.lua" )


--Spawns a wand editting crystal inside the pyramid, this will provide people incentive to go there and wander around the actual pyramid part for a bit before rushing either the boss or the orb.
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/pyramid_wandedit_crystal_populator.lua" ) 


--Deletes polymorph crystal surrounding the entrance to the Temple of the Art. Wouldn't want to get cockblocked by a poly crystal covering the entrance and a tentacler camping right behind the wall.
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/crypt_polycrystal_deletion_populator.lua" ) 


--Spawns a Hisii Beggar near the essence of earth, hopefully demonstrates or at least hints towards how to interact with them
ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/hisii_beggar_populator.lua" ) 

]]--


--Spawns all the above spawns in a single file and appends to pixel scenes to prevent double spawning
-- If Conjurer is enabled, disable this for a fix.
if ModIsEnabled("raksa") == false then
  dofile_once( "mods/Apotheosis/files/scripts/biomes/boss_spawns/boss_spawn_list.lua" )
  dofile_once( "mods/Apotheosis/files/scripts/biomes/boss_spawns/blob_cave_spawn_list.lua" )
end



--Spawns statues in the trophy room
--Deprecated, now down through a spawner w/ pixelscenes

--[[
if ModIsEnabled("purgatory") then
  ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/purgatory/statue_room_populator.lua" ) 
else
  ModLuaFileAppend( "data/scripts/biomes/mountain/mountain_hall.lua", "mods/Apotheosis/files/scripts/biomes/boss_spawns/statue_room_populator.lua" ) 
end
]]--





--Modded compatibility

--Alternate Biomes
--Remember to make specific files for these at some point.. it'd be weird if there were totally normal guys spawning in irridiated mines, or magical people in the robotics factory
if ModIsEnabled("biome-plus") then

    --Normal Spawns
    ModLuaFileAppend( "data/scripts/biomes/mod/floodcave.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/aquifer_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/void_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/floating_mountain.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/floating_mountain_populator.lua" )
    
    ModLuaFileAppend( "data/scripts/biomes/mod/holy_temple.lua", "mods/Apotheosis/files/scripts/biomes/crypt_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/collapsed_lab.lua", "mods/Apotheosis/files/scripts/biomes/fungicave_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/irradiated_mines.lua", "mods/Apotheosis/files/scripts/biomes/coalmine_alt_populator.lua" )
    
    ModLuaFileAppend( "data/scripts/biomes/mod/blast_pit.lua", "mods/Apotheosis/files/scripts/biomes/excavationsite_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/snowvillage.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/hisiivillage_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/frozen_passages.lua", "mods/Apotheosis/files/scripts/biomes/snowcave_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/catacombs.lua", "mods/Apotheosis/files/scripts/biomes/wandcave_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/sandcave_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/robofactory.lua", "mods/Apotheosis/files/scripts/biomes/vault_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/swamp.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/swamp_populator.lua" ) --Jungle, could probably include bonus fungus here
    ModLuaFileAppend( "data/scripts/biomes/mod/rainforest_wormy.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/wormtunnels_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/winter_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/sulfur_cave.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/alt_biomes/hiddengrove_populator.lua" ) --Hidden Grove, Overgrowth populator

    --Global Spawns
    ModLuaFileAppend( "data/scripts/biomes/mod/irradiated_mines.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/blast_pit.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/frozen_passages.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/collapsed_lab.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/catacombs.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/swamp.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/robofactory.lua", "mods/Apotheosis/files/scripts/biomes/global_populator_no_magic.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/holy_temple.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/snowvillage.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/rainforest_wormy.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/sulfur_cave.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )
    
    --Dark Areas
    ModLuaFileAppend( "data/scripts/biomes/mod/irradiated_mines.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/conduit.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" )
    ModLuaFileAppend( "data/scripts/biomes/mod/the_void.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" )

end


--Flesh Biome
if ModIsEnabled("flesh_biome") then

    --Normal Spawns
	ModLuaFileAppend( "mods/flesh_biome/files/scripts/flesh_biome.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/flesh_biome_populator.lua" )

    --Global Spawns
	ModLuaFileAppend( "mods/flesh_biome/files/scripts/flesh_biome.lua", "mods/Apotheosis/files/scripts/biomes/global_populator.lua" )

end


--New Enemies, boosts ghost spawnrate in sandcave so they aren't flushed out by the quantity of other creatures.
--Also boosts Divine Being & Divine Poring spawnrates in Heaven & Hell for unlocks
if ModIsEnabled("new_enemies") then
	ModLuaFileAppend( "data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/sandcave_ghostbooster_populator.lua" )
	ModLuaFileAppend( "data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/the_end_angelboost_populator.lua" )
end

--New Enemies, boosts ghost spawnrate in sandcave so they aren't flushed out by the quantity of other creatures, compatibility for alt biomes.
if ModIsEnabled("new_enemies") then
  if ModIsEnabled("biome-plus") then
    ModLuaFileAppend( "data/scripts/biomes/mod/tomb.lua", "mods/Apotheosis/files/scripts/biomes/mod_compatibility/sandcave_ghostbooster_populator.lua" )
  end
end




-- Conjurer Mod, adds enemies, buildings and wands to a custom tab
if ModIsEnabled("raksa") then
  ModLuaFileAppend( "mods/raksa/files/scripts/lists/entity_categories.lua", "mods/Apotheosis/files/scripts/mod_compatibility/conjurer_populator.lua" )
end



--Worse Enemies, Overrides Hisii Minecart visuals & attacks to match those from the mod
if ModIsEnabled("worse_enemies") then

  local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
  local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_tnt.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_tnt.xml"
  xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file = "data/entities/projectiles/cocktail_gunpowder.xml"
  ModTextFileSetContent("data/entities/animals/hisii_minecart_tnt.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse.xml"
  xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file = "data/entities/projectiles/meteor_green.xml"
  xml:first_of("Base"):first_of("DamageModelComponent").attr.hp = "1.0"
  xml:add_child(nxml.parse([[
    <SpriteComponent 
      _tags="character" 
      image_file="mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_emissive.xml"
      offset_x="0"
      offset_y="0"
      alpha="1" 
      emissive="1"
      additive="1">
	</SpriteComponent>
  ]]))
  ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_weak.xml"
  xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file = "data/entities/projectiles/fireball_buckshot.xml"
  ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))

  --Bat Illusion Fix
  local content = ModTextFileGetContent("data/entities/animals/psychotic/bat.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "data/enemies_gfx/worse/bat.xml"
  ModTextFileSetContent("data/entities/animals/psychotic/bat.xml", tostring(xml))

  --Illusion Shotgunner Hisii Fix
  local content = ModTextFileGetContent("data/entities/animals/psychotic/shotgunner.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file = "mods/Apotheosis/files/entities/projectiles/psychotic/meteor_green.xml"
  ModTextFileSetContent("data/entities/animals/psychotic/shotgunner.xml", tostring(xml))

end

-- Noita Toether compatibility, allows items like the new tablets, Fungus Stone & Hungry Orb to be added to the item bank
--This is done... weirdly
--[[
if ModIsEnabled("noita-together") then
  ModLuaFileAppend( "mods/noita-together/files/scripts/item_list.lua", "mods/Apotheosis/files/scripts/mod_compatibility/nt_itemlist_populator.lua" )
end
]]--




-- Custom Perk support injection
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/Apotheosis/files/scripts/perks/custom_perks.lua" )


-- Custom Status support injection
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Apotheosis/files/scripts/status_effects/status_effects.lua" )


-- Custom Audio Support
ModRegisterAudioEventMappings("mods/Apotheosis/files/audio/GUIDs.txt")



-- Misc

--Twitch Integration
--Conga: This has been disabled as I don't feel comfortable maintaining Twitch Integration, vanilla TI is also really.. extreme.
--It's it's own discussion, but I feel if I want more TI integration, it's best to make it as a seperate mod.
--ModLuaFileAppend( "data/scripts/streaming_integration/event_list.lua", "mods/Apotheosis/files/scripts/streaming_integration/event_list_populator.lua" )


--Musicstone tag addition
dofile_once( "mods/Apotheosis/files/scripts/magic/music_magic_tag_nxml.lua" )

if HasFlagPersistent( "action_apotheosis_aqua_mine" ) or HasFlagPersistent( "action_apotheosis_bomb_giga" ) then
  AddFlagPersistent( "apotheosis_card_unlocked_welcome_hint" )
end

--MOTD & Welcome Hint
if ModIsEnabled("raksa") == false then
  local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_welcome_hint" )
  if motdSetting == true then
    dofile_once( "mods/Apotheosis/files/scripts/misc/motd_list.lua" )
  elseif flag_status == false then
    --dofile_once( "mods/Apotheosis/files/scripts/misc/welcome_hint.lua" )
  end
end

--Allows hisii to jump into minecarts
local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
if ModIsEnabled("Ride Minecart") == false then
  local content = ModTextFileGetContent("data/entities/props/physics_minecart.xml")
  local xml = nxml.parse(content)
  xml.attr.name = "minecart_hisii_hopin"
  ModTextFileSetContent("data/entities/props/physics_minecart.xml", tostring(xml))
  ModTextFileSetContent("data/entities/props/physics/minecart.xml", tostring(xml))
end

--local content = ModTextFileGetContent("data/entities/props/physics/minecart.xml")
--local xml = nxml.parse(content)
--xml.attr.name = "minecart_hisii_hopin"
--ModTextFileSetContent("data/entities/props/physics/minecart.xml", tostring(xml))


--Same thing but for hisii
local content = ModTextFileGetContent("data/entities/animals/shotgunner.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/shotgunner.xml", tostring(xml))

--Same thing but for weak hisii
local content = ModTextFileGetContent("data/entities/animals/shotgunner_weak.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin_weak.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/shotgunner_weak.xml", tostring(xml))

--Same thing but for hisii with TNT
local content = ModTextFileGetContent("data/entities/animals/miner_weak.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
    <LuaComponent
        script_source_file="mods/Apotheosis/files/scripts/buildings/hisii_minecart_hopin_tnt.lua"
        execute_every_n_frame="60"
        >
    </LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/miner_weak.xml", tostring(xml))



-- Stendari magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/firemage.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005"
ModTextFileSetContent("data/entities/animals/firemage.xml", tostring(xml))

-- Gazer magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/gazer.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water,water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005,0.0005"
ModTextFileSetContent("data/entities/animals/gazer.xml", tostring(xml))

-- Burning Skull magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/fireskull.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005"
ModTextFileSetContent("data/entities/animals/fireskull.xml", tostring(xml))

-- Spit Monster magic wetness fix
local content = ModTextFileGetContent("data/entities/animals/spitmonster.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
attrs.materials_that_damage = attrs.materials_that_damage .. ",water,water_fading"
attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.0005,0.0005"
ModTextFileSetContent("data/entities/animals/spitmonster.xml", tostring(xml))

--Allows for essence of fungus to be turned into a stone
local content = ModTextFileGetContent("data/entities/buildings/essence_eater.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent
		execute_every_n_frame="-1"
		script_death="mods/Apotheosis/files/scripts/essence/away_modded.lua"
		remove_after_executed="0"
		>
	</LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/essence_eater.xml", tostring(xml))

--Allows for moon shenanigans involving essences at the Sky Moon
local content = ModTextFileGetContent("data/entities/buildings/moon_altar.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent 
    _enabled="1" 
    execute_every_n_frame="70"
    script_source_file="mods/Apotheosis/files/scripts/magic/moon_altar_modded.lua" 
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/moon_altar.xml", tostring(xml))

--Allows for moon shenanigans involving essences at the Dark Moon
local content = ModTextFileGetContent("data/entities/buildings/dark_moon_altar.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<LuaComponent 
    _enabled="1" 
    execute_every_n_frame="70"
    script_source_file="mods/Apotheosis/files/scripts/magic/dark_moon_altar_modded.lua" 
    >
  </LuaComponent>
]]))
ModTextFileSetContent("data/entities/buildings/dark_moon_altar.xml", tostring(xml))



--Nightmare & Purgatory fixes for bubbles so they don't spew out infinite liquid everywhere
--I forgot nightmare/purgatory naturally reduces blood multipliers by default anyways.. oops
--[[
if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then

  local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
  local content = ModTextFileGetContent("data/entities/animals/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "20"
  ModTextFileSetContent("data/entities/animals/bubble_liquid.xml", tostring(xml))

  local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
  local content = ModTextFileGetContent("data/entities/animals/bubbles/acid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "20"
  ModTextFileSetContent("data/entities/animals/bubbles/acid/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "30"
  ModTextFileSetContent("data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/cursed_liquid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/cursed_liquid/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/ambrosia/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "20"
  ModTextFileSetContent("data/entities/animals/bubbles/ambrosia/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/alchemicprecursor/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "15"
  ModTextFileSetContent("data/entities/animals/bubbles/alchemicprecursor/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/healthium/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "15"
  ModTextFileSetContent("data/entities/animals/bubbles/healthium/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/unstablePandorium/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/unstablePandorium/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/pandorium/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/pandorium/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/stophittingyourself/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/stophittingyourself/bubble_liquid.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/animals/bubbles/sliceLiquid/bubble_liquid.xml")
  local xml = nxml.parse(content)
  local attrs = xml:first_of("Base"):first_of("DamageModelComponent").attr
  attrs.blood_multiplier = "10"
  ModTextFileSetContent("data/entities/animals/bubbles/sliceLiquid/bubble_liquid.xml", tostring(xml))
  
end
]]--

--Resets Blob Boss kill reward to prevent cheesing multiple "reward events" per kill
ModLuaFileAppend( "data/scripts/newgame_plus.lua", "mods/Apotheosis/files/scripts/newgame_plus_appends.lua" )
--GameRemoveFlagRun( "apotheosis_blob_boss_slain" )

--Adds custom enlightened alchemist types
--Could instead have a script that has a 2 in 6 chance to occur, and if it does make the alchemist one of the new variants, and append all this as a script on the englightened alch entity that runs after the vanilla init occurs
local content = ModTextFileGetContent("mods/Apotheosis/files/scripts/mod_compatibility/vanilla_enlightened_alchemist_init_append.lua")
ModTextFileSetContent( "data/scripts/animals/enlightened_alchemist_init.lua", tostring(content) )
--ModLuaFileAppend( "data/scripts/animals/enlightened_alchemist_init.lua", "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_enlightened_alchemist_init_append.lua" )

-- Adds musical_stone tag to the worm projectile, not to make musical ghosts appear but rather to make it double for a "spells to worms" effect
local content = ModTextFileGetContent("data/entities/projectiles/deck/worm_shot.xml")
local xml = nxml.parse(content)
xml.attr.tags = xml.attr.tags .. ",musical_stone"
ModTextFileSetContent("data/entities/projectiles/deck/worm_shot.xml", tostring(xml))

-- Adds various powders to dissolve powders perk
local content = ModTextFileGetContent("data/entities/misc/perks/dissolve_powders.xml")
local xml = nxml.parse(content)
local attrs = xml:first_of("CellEaterComponent").attr
attrs.materials = attrs.materials .. ",apotheosis_insect_husk,apotheosis_sand_pink,templebrick_static_broken_apotheosisoft"
ModTextFileSetContent("data/entities/misc/perks/dissolve_powders.xml", tostring(xml))

-- Adds various liquids to freeze charge modifier
local content = ModTextFileGetContent("data/entities/particles/freeze_charge.xml")
local xml = nxml.parse(content)
local attrs = xml:all_of("MagicConvertMaterialComponent")
attrs[2].attr.from_material_array = attrs[2].attr.from_material_array .. ",apotheosis_water_fading_fast,water_fading"
attrs[2].attr.to_material_array = attrs[2].attr.to_material_array .. ",ice_static,ice_static"
ModTextFileSetContent("data/entities/particles/freeze_charge.xml", tostring(xml))

-- Adds various liquids to circle of stillness
local content = ModTextFileGetContent("data/entities/projectiles/deck/freeze_field.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<MagicConvertMaterialComponent
      kill_when_finished="0"
      from_material="water_fading"
      steps_per_frame="5"
      to_material="ice_static"
      is_circle="1"
      radius="72" >
    </MagicConvertMaterialComponent>
]]))
ModTextFileSetContent("data/entities/projectiles/deck/freeze_field.xml", tostring(xml))

-- Adds various liquids to freeze field perk
local content = ModTextFileGetContent("data/entities/misc/perks/freeze_field.xml")
local xml = nxml.parse(content)
xml:add_child(nxml.parse([[
	<MagicConvertMaterialComponent
      kill_when_finished="0"
      from_material="apotheosis_water_fading_fast"
      steps_per_frame="5"
      to_material="ice_static"
      is_circle="1"
      radius="72" >
    </MagicConvertMaterialComponent>
]]))
ModTextFileSetContent("data/entities/misc/perks/freeze_field.xml", tostring(xml))





--Boss health multiplier insertion
dofile_once( "mods/Apotheosis/files/scripts/mod_compatibility/boss_health_multiplier_plug.lua" )

--Boss vulnerability immunity insertion
dofile_once( "mods/Apotheosis/files/scripts/mod_compatibility/boss_vulnerability_immune_plug.lua" )

--Modifies vanilla entity data
--Try not to tinker with base noita too much, the main goal to this mod is to be an expansion pack, not a rebalance.
dofile_once( "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_appends.lua" )

-- If Conjurer is enabled, disable this for a fix.
-- Adds custom Pixel Scenes in
if ModIsEnabled("raksa") == false then
  dofile_once( "mods/Apotheosis/files/scripts/pixelscenes/scene_list.lua" )
end

--Overrides some creep's settings for spoopy's alternate graphics
--Removed as it uses Spoopy's Graphics by default
--[[
if spoopyGFXSetting == true then

  --Esoteric Being
  local content = ModTextFileGetContent("data/entities/animals/esoteric_being.xml")
  local xml = nxml.parse(content)
  xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_action_frame = "2"
  xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/esoteric_being_alt.xml"
  xml:first_of("SpriteComponent").attr.offset_x = "18.5"
  xml:first_of("SpriteComponent").attr.offset_y = "17.5"
  ModTextFileSetContent("data/entities/animals/esoteric_being.xml", tostring(xml))

  local content = ModTextFileGetContent("data/entities/buildings/esoteric_being_asleep.xml")
  local xml = nxml.parse(content)
  xml:first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/esoteric_being_alt_asleep.xml"
  ModTextFileSetContent("data/entities/buildings/esoteric_being_asleep.xml", tostring(xml))

  local content = ModTextFileGetContent("mods/Apotheosis/files/scripts/animals/angel_holy_beam_calldown_alt.lua")
  ModTextFileSetContent("mods/Apotheosis/files/scripts/animals/angel_holy_beam_calldown.lua", content)

end
]]--






  














--Master of Masters master spawner insertion, allows him to spawn Master of Mallards & Master of Immortality too.. He doesn't appreciate Master of Trolling too much to invite him in
--Note, this has been moved to a file override, could probably use string.gsub to fix that
--Note 17/07/2023, string.gsub has been used






-- Seasonal
local year, month, day, hour, minute = GameGetDateAndTimeLocal()


if seasonalSetting == true then

  -- Halloween Event
  if (( month == 10 ) and ( day >= 15 )) or seasonalForced_Halloween then
    ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua" ) --Coal Mine, first area, goodluck on your run
    ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua" ) --Coalmine but to the west side near damp cave
    ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua" ) --Coal Pits, area 2
    ModLuaFileAppend( "data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/halloween.lua" ) --Presumably everything below the entrance to the pyramid

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/entities/animals/poring.xml")
    local xml = nxml.parse(content)
    xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/poring_halloween.xml"
    xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file = "mods/Apotheosis/files/ragdolls/poring_halloween/filenames.txt"
    ModTextFileSetContent("data/entities/animals/poring.xml", tostring(xml))

    local content = ModTextFileGetContent("data/entities/animals/coal_mines/poring.xml")
    local xml = nxml.parse(content)
    xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/poring_halloween_weak.xml"
    xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file = "mods/Apotheosis/files/ragdolls/poring_halloween_weak/filenames.txt"
    ModTextFileSetContent("data/entities/animals/coal_mines/poring.xml", tostring(xml))

    local content = ModTextFileGetContent("data/entities/animals/psychotic/poring.xml")
    local xml = nxml.parse(content)
    xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/poring_halloween.xml"
    xml:first_of("Base"):first_of("DamageModelComponent").attr.ragdoll_filenames_file = "mods/Apotheosis/files/ragdolls/poring_halloween/filenames.txt"
    ModTextFileSetContent("data/entities/animals/psychotic/poring.xml", tostring(xml))

  end



  -- Smissmass Event
  if (( month == 12 ) and ( day >= 15 )) or seasonalForced_Smissmass then

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_tnt.xml")
    local xml = nxml.parse(content)
    xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_tnt_santa.xml"
    xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file = "data/entities/projectiles/present.xml"
    xml:add_child(nxml.parse([[
      <LuaComponent
          script_source_file="mods/Apotheosis/files/scripts/animals/esoteric_being_shifted_smoke.lua"
          execute_every_n_frame="1"
          remove_after_executed="1"
          >
      </LuaComponent>
      ]]))
    ModTextFileSetContent("data/entities/animals/hisii_minecart_tnt.xml", tostring(xml))

    if ModIsEnabled("worse_enemies") then
      local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
      local xml = nxml.parse(content)
      xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_smissmass.xml"
      ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))
    else
      local content = ModTextFileGetContent("data/entities/animals/hisii_minecart.xml")
      local xml = nxml.parse(content)
      xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_smissmass.xml"
      ModTextFileSetContent("data/entities/animals/hisii_minecart.xml", tostring(xml))
    end

    if ModIsEnabled("worse_enemies") then
      local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
      local xml = nxml.parse(content)
      xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_worse_weak_smissmass.xml"
      ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))
    else
      local content = ModTextFileGetContent("data/entities/animals/hisii_minecart_weak.xml")
      local xml = nxml.parse(content)
      xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/hisii_minecart_weak_smissmass.xml"
      ModTextFileSetContent("data/entities/animals/hisii_minecart_weak.xml", tostring(xml))
    end

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/entities/animals/poring.xml")
    local xml = nxml.parse(content)
    xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/poring_santa.xml"
    ModTextFileSetContent("data/entities/animals/poring.xml", tostring(xml))

    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
    local content = ModTextFileGetContent("data/entities/animals/coal_mines/poring.xml")
    local xml = nxml.parse(content)
    xml:first_of("Base"):first_of("SpriteComponent").attr.image_file = "mods/Apotheosis/files/enemies_gfx/poring_santa_weak.xml"
    ModTextFileSetContent("data/entities/animals/coal_mines/poring.xml", tostring(xml))

  end


  -- Birthday Event
  -- Update to be centered on 21/07/2022, this is when the first enemy was created and development officially began. Should be a fair trade off between not being the official release date but also not clashing with Halloween
  --Remember Update global_populator & global_populator_small too, wand tinkering crystal spawns are inside.
  if (( month == 7 ) and (( day >= 20 ) and ( day <= 22 ))) or seasonalForced_Birthday then
    ModLuaFileAppend( "data/scripts/biomes/hills.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua" ) --Hills slightly below ground
    ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua" ) --Coal Mine, first area, goodluck on your run
    ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua" ) --Coalmine but to the west side near damp cave
    ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua" ) --Coal Pits, area 2
    ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua" ) --Hiisi Base
    ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua" )
    ModLuaFileAppend( "data/scripts/biomes/desert.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday.lua" )
    ModLuaFileAppend( "data/scripts/biomes/rainforest.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua" )
    ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/seasonal/birthday_rare.lua" )
  end


  -- April Fools Event
  if (( month == 4 ) and ( day == 1 )) or seasonalForced_AprilFools then

    --Replace all hisii hobos with clowns.
    local content = ModTextFileGetContent("data/entities/animals/seasonal/hisii_hobo.xml")
    ModTextFileSetContent("data/entities/animals/hisii_hobo.xml", content)

    --Replace small fairies with lethal versions.
    local content = ModTextFileGetContent("data/entities/animals/seasonal/fairy_cheap.xml")
    ModTextFileSetContent("data/entities/animals/fairy_cheap.xml", content)

    --Replace big fairies with non-lethal versions.
    local content = ModTextFileGetContent("data/entities/animals/seasonal/fairy_big.xml")
    ModTextFileSetContent("data/entities/animals/fairy_big.xml", content)
    
    local randomCap = 10

    SetRandomSeed( hour + minute, hour + day )
    --10% chance for any main path biome to become weird in April Fools
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/rainforest.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      ModLuaFileAppend( "mods/apotheosis/files/scripts/biomes/newbiome/lava_excavation.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/snowcave.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/coalmine_alt.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end
    if Random(1,randomCap) == 1 then
      ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )
      randomCap = randomCap + 1
    end

    --100% chance for the Temple of the Art to be spawn everything
    ModLuaFileAppend( "data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/global_everything_populator.lua" )



    --Remember to check global spawn files, pandora's chest spawnrate boost is managed there

  end

end













--Dark Areas
ModLuaFileAppend( "data/scripts/biomes/wizardcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Wizard's Den, aside from the darkness it's pretty habitable. Polymorph liquid is scarier, I can't shield that.

ModLuaFileAppend( "data/scripts/biomes/crypt.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Temple of the Arts.. who died here?
ModLuaFileAppend( "data/scripts/biomes/pyramid.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Presumably everything below the entrance to the pyramid
ModLuaFileAppend( "data/scripts/biomes/fungicave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --BUNGUS!! cave, west side of area 2 for example

ModLuaFileAppend( "data/scripts/biomes/fungiforest.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Overgrowth
ModLuaFileAppend( "data/scripts/biomes/wandcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Magical temple.. huh
ModLuaFileAppend( "data/scripts/biomes/sandcave.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Desert sand cave, I don't think it includes desert chasm
ModLuaFileAppend( "data/scripts/biomes/vault.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --The Vault

ModLuaFileAppend( "data/scripts/biomes/winter.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Winter appears to be the snow chasm... terrifying.
ModLuaFileAppend( "data/scripts/biomes/rainforest_dark.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Lukki Lair.. creepy
ModLuaFileAppend( "data/scripts/biomes/vault_frozen.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Like the vault, but way colder, worse, more hisii and with a really rude welcoming
ModLuaFileAppend( "data/scripts/biomes/robobase.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Power Plant
ModLuaFileAppend( "data/scripts/biomes/the_end.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --Heaven & Hell, but for this specific lua file append I'm only adding to hell

ModLuaFileAppend( "mods/apotheosis/files/scripts/biomes/newbiome/evil_temple.lua", "mods/Apotheosis/files/scripts/biomes/suspicious.lua" ) --The Vault

--ModLuaFileAppend( "data/scripts/biome_modifiers.lua", "mods/Apotheosis/files/scripts/weather/weather_wet_append.lua" ) --Attempt to insert shaman into biome wet modifier spawn additions. Started eating up too much time.
--If you know how to do this, please let me know. -Conga Lyne


--Secret

do  -- Player Editor
  local path = "data/entities/player_base.xml"
  local xml = nxml.parse(ModTextFileGetContent(path))
  --Adds Biome tracker script to the player character, it will update their current biome difficulty and save the highest one they've ever achieved, maxing out at 7 in Heaven/Hell
  --This is currently only used for twitch integration so is disabled if TI is turned off, can be changed if needed elsewhere
--  xml:add_child(nxml.parse([[
--    <LuaComponent
--      script_source_file="mods/apotheosis/files/scripts/magic/biome_difficulty_tracker.lua"
--      execute_every_n_frame="600"
--      execute_times="-1"
--      remove_after_executed="0"
--      >
--    </LuaComponent>
--  ]]))

  --Makes player take contact damage from cursed liquid, poisonous gas, and other materials added by Apotheosis
  --Cursed Liquid, Cursed Liquid (Static), Poisonous Gas, Radioactive Gas (Fading)
  local attrs = xml:first_of("DamageModelComponent").attr
  attrs.materials_that_damage = attrs.materials_that_damage .. ",apotheosis_cursed_liquid_red,apotheosis_cursed_liquid_red_static,poison_gas,apotheosis_radioactive_gas_fading"
  attrs.materials_how_much_damage = attrs.materials_how_much_damage .. ",0.003,0.003,0.0008,0.001"

  if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) and capeSetting then
    --Adds Golden Cape if check is successful
    xml:add_child(nxml.parse([[
      <LuaComponent
        script_source_file="data/apotheosis_gfx/player_cape_colour_append.lua"
        execute_every_n_frame="2"
        execute_times="1"
        remove_after_executed="1"
        >
      </LuaComponent>
    ]]))
  end

  --Adds Parallel World checker to the player
  xml:add_child(nxml.parse([[
    <LuaComponent
      script_source_file="mods/apotheosis/files/scripts/magic/player_parallel_check.lua"
      execute_every_n_frame="1800"
      execute_times="-1"
      remove_after_executed="0"
      >
    </LuaComponent>
  ]]))

  --Debug
  --xml:add_child(nxml.parse([[
  --  <SpriteComponent 
  --  _tags="character" 
  --  alpha="1" 
  --  image_file="mods/apotheosis/files/player_gfx/perk_wings.xml"
  --  next_rect_animation="" 
  --  offset_x="6" 
  --  offset_y="14" 
  --  rect_animation="walk" 
  --  z_index="0.61"
  --></SpriteComponent>
  --]]))
  ModTextFileSetContent(path, tostring(xml))
end



--Guarantees Dense Smoke modifier to appear in the coalpits for your first run when playing with Apotheosis
if ModIsEnabled("raksa") == false then
  if (HasFlagPersistent( "apotheosis_card_unlocked_coalpits_dense_smoke" ) ~= true)then
    
    local filepc = "data/biome/_pixel_scenes.xml"
    if ModIsEnabled("purgatory") then
      filepc = "mods/purgatory/files/biome/_pixel_scenes.xml"
      local content = ModTextFileGetContent(filepc)
      local xml = nxml.parse(content)
      xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="1003" pos_y="111" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
      ModTextFileSetContent(filepc, tostring(xml))
    elseif ModIsEnabled("noitavania") then
      filepc = "mods/noitavania/data/biome/_pixel_scenes.xml"
      local content = ModTextFileGetContent(filepc)
      local xml = nxml.parse(content)
      xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="192" pos_y="1635" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
      ModTextFileSetContent(filepc, tostring(xml))
    else
      local content = ModTextFileGetContent(filepc)
      local xml = nxml.parse(content)
      xml:first_of("mBufferedPixelScenes"):add_child(nxml.parse([[
          <PixelScene pos_x="192" pos_y="1635" just_load_an_entity="data/entities/buildings/smoke_dense_creator_apotheosis_message.xml" />
      ]]))
      ModTextFileSetContent(filepc, tostring(xml))
    end


    ModLuaFileAppend( "data/scripts/biomes/excavationsite.lua", "mods/Apotheosis/files/scripts/biomes/excavationsite_populator_densesmoke.lua" )
  end
end

-- Sets biome map to the new one
--[[
if experimental_biomemap then
  ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers_experimental.xml") --Sets the biome map
  dofile_once( "mods/Apotheosis/files/scripts/mod_compatibility/vanilla_appends_experimental.lua" ) --appends experimental data
  Note: It would be fun to replace the entire world map one day, but that's biting off way more than I can chew, a small rat eating a whole cow level huge,
  A single person with 0 mods for a game trying to make an Rlcraft modpack huge
  Maybe after Apotheosis is done and we have a bunch of biome assets, enemy assets, spell, perk, item, etc assets, we could make a new world
  But until that day comes, We're sticking to the plan!
else
  ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers.xml") --Sets the biome map
  side note: maybe in that new world enemies could drop wands directly instead of finding them on pedestals
end
]]--

ModMagicNumbersFileAdd("mods/Apotheosis/files/magic_numbers.xml") --Sets the biome map

--Custom biome modifiers
--ModTextFileSetContent("data/scripts/biome_modifiers.lua", ModTextFileGetContent("mods/apotheosis/files/scripts/biome_modifiers/biome_modifiers.lua"))

--More Musical Magic implementation, coded by Y🍵
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_default.lua")
ModLuaFileAppend("data/moremusicalmagic/musicmagic.lua", "data/moremusicalmagic/songs_apotheosis.lua")


--Set Custom Seed (And Check for Secret Seeds)
dofile_once("mods/apotheosis/files/scripts/setup/secret_seeds.lua")

--Appending extra modiifers
ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/apotheosis/files/scripts/spells/gun_extra_populator.lua")

--Polymorph pool addition preperation
--Will be controlled via mod settings until it's pushed to main
--If you want to enable it, you can toggle "Expanded Polymorph Pool" in the mod settings
if ModSettingGet( "Apotheosis.exp_poly" ) == true then
  if ModIsEnabled("Global_Poly") then
    ModLuaFileAppend( "mods/global_poly/files/scripts/poly_pool.lua", "mods/apotheosis/files/scripts/mod_compatibility/poly_control_compat.lua")
  else
    function OnWorldInitialized()
      dofile_once("mods/apotheosis/files/scripts/mod_compatibility/polymorph_pool.lua")
    end
  end
end

--Randomly cause a fungal shift/creature shift at any time, at random.
--And print Happy April Fools at the start of the run
--Happy april fools <3
function AprilFoolsPlayerSpawn()
  if (( month == 4 ) and ( day == 1 )) or seasonalForced_AprilFools then
    local x, y = EntityGetTransform( player_entity )
    local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/moon_fungus_curse_slow.xml", x, y)
    EntityAddChild( player_entity, cid )
    local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/moon_creature_curse_slow.xml", x, y)
    EntityAddChild( player_entity, cid )
    local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/creature_shift_april_fools_bootup.xml", x, y) --20 random creature shifts at the start of the run
    EntityAddChild( player_entity, cid )

    GamePrint("$sign_apotheosis_aprilfools_intro")
  end
end


-- Creature shift fix upon reloading world
-- Keep this at the bottom of the file, and only let one of this function exist, silly
function OnPlayerSpawned( player_entity )
	local x, y = EntityGetTransform( player_entity ) --This was just "player" by default but I feel like something broke.. I hope not
	EntityLoad("mods/Apotheosis/files/entities/special/entity_shift_refresh_fixer.xml", x, y)

  --Previously a game print to warn against Ride Minecarts
  --[[if ModIsEnabled("Ride Minecart") == true then
    GamePrint("Error, could not initialise hopping into minecarts because of [Ride Minecarts], Apotheosis should function as normal otherwise though.")
  end]]--

  --Warns the player if Mo Creeps is enabled, to shut it off
  if ModIsEnabled("Mo_Creeps") then
    GamePrintImportant("WARNING: MO CREEPS IS ENABLED","Apotheosis & More Creeps should not be enabled at the same time, Mo Creeps content is already inside apotheosis.")
  end

  --Debug Testing for intro scene
  --RemoveFlagPersistent( "apotheosis_intro_cutscene_devtest" )

  --Handles the intro cutscene if the player hasn't encountered it yet
  if ModIsEnabled("Mo_Creeps") == false and HasFlagPersistent( "apotheosis_intro_cutscene_devtest" ) == false then
    EntityLoad("mods/apotheosis/files/entities/intro/controller_scenes.xml", x, y)
    --This is added when the cutscene ends to prevent a softlock
    --AddFlagPersistent( "apotheosis_intro_cutscene_devtest" )
  end

  if custom_seed then
    GamePrint("$sign_apotheosis_custom_seed" )
  end

  --Handles AprilFools related code
  AprilFoolsPlayerSpawn()

  --Calculate RNG
  SetRandomSeed(111,222)
  if Random(1,10000) == 1 then
    GameAddFlagRun(table.concat({"apothe","osis_","div","ine_red_fi","sh"}))
  end
end



--Custom Materials
ModMaterialsFileAdd( "mods/Apotheosis/files/scripts/materials/secret_materials.xml" )
ModMaterialsFileAdd( "mods/Apotheosis/files/scripts/materials/custom_materials.xml" )


ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/Apotheosis/files/scripts/potions/potion_appends.lua" )
ModLuaFileAppend( "data/scripts/items/powder_stash.lua", "mods/Apotheosis/files/scripts/potions/powder_stash_appends.lua" )
ModLuaFileAppend( "data/scripts/items/potion_aggressive.lua", "mods/Apotheosis/files/scripts/potions/potion_aggressive_appends.lua" )

function OnMagicNumbersAndWorldSeedInitialized()

  --You can just edit material file data after appending it and it works, uhh, cool, thanks Nolla; Thanks Wondible
  do --Setup Magic Catalyst data
    dofile("mods/apotheosis/files/scripts/materials/secret_materials_generate.lua")
    GenerateMagicCatalyst()
  end

end
