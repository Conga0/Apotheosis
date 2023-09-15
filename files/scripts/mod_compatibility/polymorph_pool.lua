function polytest()
    local options = {
        "ant_fire",
        "ant_suffocate",
        "blindgazer",
        "blob_big",
        "blob_huge",
        "boss_toxic_worm_minion",
        --Liquid bubbles in here
        "bubbles/ambrosia/bubble_liquid",
        "bubbles/blood/bubble_liquid",
        "bubbles/water/bubble_liquid",
        "c_basebot_speeder_apotheosis",
        "cat_mocreeps",
        "cat_mocreeps_black",
        "cat_mocreeps_esoteric",
        "cat_mocreeps_golden",
        "cat_mocreeps_skateboard",
        "cat_mocreeps_sorako",
        "cat_mocreeps_spoopy",
        "cat_mocreeps_spoopy_frisky",
        "cat_mocreeps_spoopy_golden",
        "cat_mocreeps_spoopy_skittle",
        "cat_mocreeps_spoopy_tiger",
        "cat_mocreeps_white",
        "cat_mocreeps_wizard",
        "ccc_bat_psychic",
        "devourer_magic",
        "drone_mini",
        "esoteric_being",
        "fairy",
        "fairy_big",
        "fairy_big_discord",
        "fairy_esoteric",
        "forsaken_eye",
        "fungus_smoking_creep",
        "gazer_cold_apotheosis",
        "gazer_greater",
        "gazer_greater_cold",
        "gazer_greater_sky",
        "gazer_robot",
        "ghost_bow",
        "giant_centipede",
        "goo_slug",
        "hideous_mass",
        "hideous_mass_red",
        --"hiisi_thief",
        "hisii_giga_bomb",
        --"hisii_hobo",
        "hisii_hobo_rich",
        "hisii_minecart",
        "hisii_minecart_tnt",
        "hisii_minecart_weak",
        "hisii_rocketshotgun",
        "longleg_pillar",
        "mimic_explosive_box",
        "mudman_friendly",
        "musical_being",
        "musical_being_weak",
        "poring",
        "poring_devil",
        "poring_holy",
        "poring_lukki",
        "poring_magic",
        "rat_birthday",
        "sentry",
        "shaman_greater_apotheosis",
        "slime_leaker",
        "slime_teleporter",
        "star_child",
        "tentacler_big",
        "tesla_turret",
        "watermage",
        "watermage_greater",
        "whisp_big",
        "wizard_ambrosia",
        "wizard_copeseethmald",
        "wizard_corrupt_ambrosia",
        "wizard_corrupt_manaeater",
        "wizard_corrupt_neutral",
        "wizard_corrupt_swapper",
        "wizard_corrupt_teleport",
        "wizard_duck",
        "wizard_explosive",
        "wizard_firemage_greater",
        "wizard_jackofalltrades",
        "wizard_manaeater",
        "wizard_transmutation",
        "wizard_corrupt_wands",
        "wizard_z_poly_miniboss",
        "worm_wall",
        "worm_mechanical",
        "worm_esoteric",
        "wraith_alchemy_apotheosis",
        "wraith_returner_apotheosis",
        "wraith_weirdo_shield",
        --"mimic_perk_twwe",  --Should he be here?
    }

    if ModSettingGet( "Apotheosis.congacat_cat_immortal" ) then
        for k=1,#options do
            --PolymorphTableAddEntity( entity_xml:string, is_rare:bool = false, add_only_one_copy:bool = true ) [Adds the entity to the polymorph random table]
            --Remove cats from the chaotic polymorph pool if they're immortal
            --It'd be too confusing to have cats be immortal but people polymorph into mortal cats otherwise
            local cat_check = string.find(options[k],"cat_")
            if ModSettingGet( "Apotheosis.congacat_cat_immortal" ) and cat_check == false then
                PolymorphTableAddEntity( "data/entities/animals/" .. options[k] .. ".xml", false, true)
            end
        end
    else
        for k=1,#options do
            --PolymorphTableAddEntity( entity_xml:string, is_rare:bool = false, add_only_one_copy:bool = true ) [Adds the entity to the polymorph random table]
            PolymorphTableAddEntity( "data/entities/animals/" .. options[k] .. ".xml", false, true)
        end
    end

    --PolymorphTableAddEntity( "data/entities/animals/boss_pit/boss_pit.xml", false)

    --I don't know how table.concat works and it's 12am
    --Good night :congasleep:
end

polytest()

--Maybe corrupt wizards shouldn't be allowed in the chaotic poly pool, since the gods forsake them?
