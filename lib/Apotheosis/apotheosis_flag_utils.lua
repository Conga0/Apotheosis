
dofile_once("mods/Apotheosis/files/actions.lua")
dofile_once("mods/Apotheosis/files/scripts/perks/custom_perks.lua")

apotheosis_flag_list = {}

do  --Spell flags
    for k=1,#apotheosis_spellappends do
        table.insert(apotheosis_flag_list,string.lower(table.concat({"action_",apotheosis_spellappends[k]["id"]})))
        table.insert(apotheosis_flag_list,string.lower(table.concat({"action_",apotheosis_spellappends[k]["id"],"_spell"})))
    end
end

do  --Perk flags
    for k=1,#apotheosis_perkappends do
        table.insert(apotheosis_flag_list,string.lower(table.concat({"perk_picked_",apotheosis_perkappends[k]["id"]})))
    end
end

do  --Perk creation altar flags
    local outputlist = {
        "PROTECTION_FIRE",
        "TELEKINESIS",
        "PROTECTION_ELECTRICITY",
        "BREATH_UNDERWATER",
        "APOTHEOSIS_ALCOHOL_IMMUNITY",
        "APOTHEOSIS_TRIP_IMMUNITY",
        "EDIT_WANDS_EVERYWHERE",
        "MEGA_BEAM_STONE",
        "REMOVE_FOG_OF_WAR",
        "REMOVE_FOG_OF_WAR",
        "GLOBAL_GORE",
        "APOTHEOSIS_PLANE_RADAR",
    }
    for k=1,#outputlist do
        table.insert(apotheosis_flag_list,string.lower(table.concat({"apotheosis_card_unlocked_perkforged_",outputlist[k]}))) --Perk creation altar flags
    end
end

--Any flags not picked up by the automated spell or perk scans
local remaining_flags = {
    "apotheosis_card_unlocked_ending_apotheosis_02",
    "apotheosis_card_unlocked_ending_apotheosis_02_spell",
    "apotheosis_card_unlocked_divinebeing",
    "apotheosis_card_unlocked_divinebeing_spell",
    "apotheosis_card_unlocked_divinebeing_goldmode",
    "apotheosis_card_unlocked_blob_boss",
    "apotheosis_card_unlocked_blob_boss_spell",
    "apotheosis_card_unlocked_blob_boss_goldmode",
    "apotheosis_card_unlocked_fire_lukki",
    "apotheosis_card_unlocked_fire_lukki_spell",
    "apotheosis_card_unlocked_fire_lukki_goldmode",
    "apotheosis_card_unlocked_boss_flesh_monster",
    "apotheosis_card_unlocked_boss_flesh_monster_spell",
    "apotheosis_card_unlocked_boss_flesh_monster_wrath",
    "apotheosis_card_unlocked_boss_flesh_monster_gourd_holy",
    "apotheosis_card_unlocked_boss_flesh_monster_goldmode",
    "apotheosis_card_unlocked_musical_boss",
    "apotheosis_card_unlocked_musical_boss_spell",
    "apotheosis_card_unlocked_musical_boss_goldmode",
    "apotheosis_card_unlocked_boss_toxic_worm",
    "apotheosis_card_unlocked_boss_toxic_worm_spell",
    "apotheosis_card_unlocked_boss_toxic_worm_goldmode",
    "apotheosis_card_unlocked_boss_monolith",
    "apotheosis_card_unlocked_worm_end_big",
    "apotheosis_card_unlocked_worm_end_big_spell",
    "apotheosis_card_unlocked_worm_end_big_goldmode",
    "apotheosis_card_unlocked_musical_magic_played",
    "apotheosis_tablet_ghost_encounter",
    "apotheosis_card_unlocked_rat_bite",
    "apotheosis_card_unlocked_rage_aura",
    "apotheosis_card_unlocked_rage_aura_goldmode",
    "apotheosis_card_unlocked_ending_apotheosis_speedrun",
    "apotheosis_card_unlocked_ending_apotheosis_speedrun_1hr",
    "apotheosis_card_unlocked_ending_apotheosis_hardcore",
    "apotheosis_card_unlocked_ending_apotheosis_everything",
    "apotheosis_card_unlocked_ending_apotheosis_01",
    "apotheosis_card_unlocked_ending_apotheosis_02",
    "apotheosis_card_unlocked_ending_apotheosis_03",
    "apotheosis_card_unlocked_orb_12",
    "apotheosis_card_unlocked_orb_12_spell",
    "apotheosis_card_unlocked_orb_14",
    "apotheosis_card_unlocked_orb_14_spell",
    "apotheosis_card_unlocked_orb_15",
    "apotheosis_card_unlocked_orb_15_spell",
    "apotheosis_card_unlocked_orb_16",
    "apotheosis_card_unlocked_orb_16_spell",
    "apotheosis_card_unlocked_divine_red_fish_unlocked",
    "apotheosis_card_unlocked_donated_beggar",
    "apotheosis_card_unlocked_divine_liquid",
    "apotheosis_card_unlocked_divine_liquid_goldmode",
    "apotheosis_card_unlocked_45_orbs",
    "apotheosis_card_unlocked_foundneworb",
    "apotheosis_card_unlocked_foundallneworbs",
    "apotheosis_card_unlocked_challenge_hardcore_win",
    "apotheosis_card_unlocked_ending_apotheosis_hardcore",
    "apotheosis_card_unlocked_lost_alchemy",
    "apotheosis_card_unlocked_lost_alchemy_spell",
    "apotheosis_card_unlocked_toiletpaper_spell",
    "apotheosis_card_unlocked_omega_cross",
    "apotheosis_card_unlocked_omega_cross_spell",
    "apotheosis_card_unlocked_sleep",
    "apotheosis_card_unlocked_coalpits_dense_smoke",
    "apotheosis_portal_midboss",
    "apotheosis_intro_cutscene",
    "apotheosis_card_unlocked_essence_fungus",
    "apotheosis_card_unlocked_cat_secret",
    "apotheosis_card_unlocked_cat_secret_spell",
    "apotheosis_card_unlocked_cat_secret_goldmode",
    "apotheosis_stone_heretic_purified",
    "apotheosis_card_unlocked_moon_fungus_unlock",
    "apotheosis_card_unlocked_pandora_chest_rain",
    "apotheosis_card_unlocked_clam_chest_rain",
    "apotheosis_card_unlocked_perk_creation",
    "apotheosis_card_unlocked_challenge_towerclimb_win",
    "apotheosis_card_unlocked_ending_apotheosis_hardcore",
    "apotheosis_card_unlocked_challenge_missingmagic_win",
    "apotheosis_card_unlocked_radarfound",
    "apotheosis_card_unlocked_secret_knowledge_of_kings",
    "apotheosis_card_unlocked_secret_knowledge_of_kings_spell",
    "apotheosis_card_unlocked_support_bullet_spell",
    "apotheosis_card_unlocked_support_bullet_spell_spell",
}

for k=1,#remaining_flags do
    table.insert(apotheosis_flag_list,remaining_flags[k])
end