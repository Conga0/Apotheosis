

local towerclimb_enemies = { "boss_toxic_worm_minion", "bubble_liquid", "bubbles/ambrosia/bubble_liquid", "blindgazer", "blob_big", "blob_huge", "forsaken_eye", "fungus_smoking_creep", "gazer_cold_apotheosis", "gazer_greater", "gazer_greater_cold", "gazer_greater_sky", "gazer_robot", "ghost_bow", "giant_centipede", "vault/goo_slug", "ccc_bat_psychic", "fungiforest/ceiling_fungus", "devourer_ghost", "devourer_magic", "drone_mini", "drone_status_ailment", "esoteric_being", "fairy_big", "fairy_big_discord", "fairy_esoteric", "crypt/hideous_mass", "vault/hisii_engineer", "hisii_giga_bomb", "hisii_minecart", "hisii_minecart_tnt", "hisii_rocketshotgun", "locust_swarm", "lukki_fungus", "lukki_swarmling", "mimic_explosive_box", "musical_being_weak", "poisonmushroom", "poring", "poring_holy", "poring_lukki", "poring_magic", "rat_birthday", "sentry", "star_child", "slime_leaker", "slime_leaker_weak", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_big", "tesla_turret", "triangle_gem", "whisp", "whisp_big", "wizard_ambrosia", "wizard_copeseethmald", "wizard_duck", "wizard_explosive", "wizard_manaeater", "wizard_transmutation", "wizard_firemage_greater", "wizard_z_poly_miniboss", "wraith_returner_apotheosis", "wraith_weirdo_shield", "acidshooter", "alchemist", "ant", "assassin", "barfer", "bat", "bigbat", "bigfirebug", "bigzombie", "blob", "bloodcrystal_physics", "bloom", "chest_mimic", "crystal_physics", "drone_physics", "enlightened_alchemist", "failed_alchemist", "failed_alchemist_b", "firebug", "firemage", "fireskull", "flamer", "fly", "frog", "frog_big", "fungus", "fungus_big", "gazer", "ghoul", "giant", "giantshooter", "healerdrone_physics", "icer", "iceskull", "lasershooter", "longleg", "maggot", "miner", "miner_fire", "missilecrab", "monk", "necromancer", "necromancer_shop", "phantom_a", "phantom_b", "rat", "roboguard", "scavenger_clusterbomb", "scavenger_heal", "scavenger_grenade", "scavenger_leader", "scavenger_mine", "scavenger_poison", "scavenger_smg", "shooterflower", "shotgunner", "skullfly", "skullrat", "slimeshooter", "sniper", "spitmonster", "statue_physics", "tank", "tank_rocket", "tank_super", "tentacler", "tentacler_small", "thundermage", "thunderskull", "turret_left", "turret_right", "wizard_dark", "wizard_neutral", "wizard_poly", "wizard_returner", "wizard_swapper", "wizard_tele", "wolf", "wraith", "wraith_glowing", "wraith_storm", "zombie", "skycrystal_physics", "scavenger_shield", "spearbot", "statue", "goblin_bomb", }

--Small enemies
if g_small_enemies then

    for k=1,#towerclimb_enemies
    do enemy = towerclimb_enemies[k]
        table.insert(g_small_enemies,
        {
            prob           = 0.0005,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/" .. enemy .. ".xml"
        })
    end
end

--Big Enemies
if g_big_enemies then

    for k=1,#towerclimb_enemies
    do enemy = towerclimb_enemies[k]
        table.insert(g_big_enemies,
        {
            prob           = 0.0005,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/" .. enemy .. ".xml"
        })
    end
end











--Props
if g_props then

    table.insert(g_props,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/props/crystal_lime.xml"
    })
  
    table.insert(g_props,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/props/crystal_opal.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })

end




--Lights
if g_lamp then
    local ambrosiaFairies = ModSettingGet( "Apotheosis.fairy_immortality" )

    if ambrosiaFairies == true then
        table.insert(g_lamp,
        {
            prob           = 0.04,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/cat_immortal/fairy_cheap.xml"
        })
    else
        table.insert(g_lamp,
        {
            prob           = 0.04,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/fairy_cheap.xml"
        })
    end

    table.insert(g_lamp,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/fairy_big.xml"
    })

    table.insert(g_lamp,
    {
        prob           = 0.02,
        min_count    = 5,
        max_count    = 10,    
        entity     = "data/entities/animals/whisp.xml"
    })
end

--Parallel World Bosses with amped up spawnrates
table.insert(g_small_enemies,
{
    prob           = 10,
    min_count    = 1,
    max_count    = 1,
    parallel     = true,
    entity     = "data/entities/animals/parallel/alchemist/parallel_alchemist.xml"
})

table.insert(g_small_enemies,
{
    prob           = 10,
    min_count    = 1,
    max_count    = 1,
    parallel     = true,
    entity     = "data/entities/animals/parallel/tentacles/parallel_tentacles.xml"
})

table.insert(g_small_enemies,
{
    prob           = 10,
    min_count    = 1,
    max_count    = 1,
    parallel     = true,
    entity     = "data/entities/animals/parallel_apotheosis/boss_toxic_worm/boss_toxic_worm.xml"
})