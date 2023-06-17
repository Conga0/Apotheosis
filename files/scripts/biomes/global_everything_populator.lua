

--Small enemies
if g_small_enemies then
    table.insert(g_small_enemies,
    {
        prob           = 0.075,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/star_child.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/coal_mines/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/goo_slug.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.01,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tesla_turret.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.10,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/cursed_liquid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 2,    
		entity  =  "data/entities/animals/crypt/tentacler_big.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/crypt/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/crypt/devourer_ghost.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/crypt/hideous_mass.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.11,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/crypt/triangle_gem.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_manaeater.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/fairy_big_discord.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.065,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/star_child.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/buildings/esoteric_being_asleep.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 2,
        max_count    = 2,    
        entity     = "data/entities/animals/wraith_weirdo_shield.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 2,
        max_count    = 2,    
        entity     = "data/entities/animals/wraith_returner_apotheosis.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 1.0,
        min_count    = 2,
        max_count    = 3,    
        entity     = "data/entities/animals/desert/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/locust_swarm.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 2,
        max_count    = 4,    
        entity     = "data/entities/animals/ccc_bat_psychic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/goo_slug.xml"
    })

	local ambrosiaFairies = ModSettingGet( "Apotheosis.fairy_immortality" )

    if ambrosiaFairies == true then
        table.insert(g_small_enemies,
        {
            prob           = 0.08,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/cat_immortal/fairy_cheap.xml"
        })
    else
        table.insert(g_small_enemies,
        {
            prob           = 0.08,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/fairy_cheap.xml"
        })
    end

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/buildings/hamis_nest.xml",
			},
			{
				min_count	= 2,
				max_count 	= 3,
				entity = "data/entities/animals/longleg.xml",
			},
		}
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.5,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/ceiling_fungus.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungus_smoking_creep.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/lukki_fungus.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/crypt/tentacler_big.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poisonmushroom.xml"
    })
        
    table.insert(g_small_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.5,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungiforest/ceiling_fungus.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungiforest/shaman_greater_apotheosis.xml"
    })
    
    if ModIsEnabled("worse_enemies") == false then
        table.insert(g_small_enemies,
        {
            prob           = 0.2,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/blob_big.xml"
        })
    end
    
    table.insert(g_small_enemies,
    {
        prob           = 0.25,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungiforest/fungus_smoking_creep.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.25,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_hobo.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.35,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_hobo.xml",
        ngpluslevel = 1
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/bubbles/water/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_manaeater.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_ghost.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.25,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hideous_mass.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/musical_being.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/locust_swarm.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poisonmushroom.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 2,
        max_count    = 7,    
        entity     = "data/entities/animals/fairy_big.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/hisii_rocketshotgun.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/jungle/locust_swarm.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poisonmushroom.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_lukki_fake.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 6,
        max_count    = 9,    
        entity     = "data/entities/animals/lukki_swarmling.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/power_plant/drone_mini.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gazer_robot.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/c_basebot_speeder_apotheosis.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/sandcave/poring.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/musical_being.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.11,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/triangle_gem.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 5,
        max_count    = 10,
        entity     = "data/entities/animals/sandcave/whisp.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 5,
        max_count    = 7,    
        entity     = "data/entities/animals/fairy_big_discord.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wraith_weirdo_shield.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_engineer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/drone_mini.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_hobo.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })

    table.insert(g_props,
    {
        prob           = 0.025,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.005,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/scavenger_heal.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/forsaken_eye.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.01,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/polymorph_crystal_chaotic.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/the_end/polymorph_crystal.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/the_end/wizard_firemage_greater.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_devil.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/the_end/gazer_greater.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })


    table.insert(g_small_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/tentacler_big.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/vault/hisii_engineer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.11,
        min_count    = 4,
        max_count    = 6,    
        entity     = "data/entities/animals/vault/drone_mini.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/blindgazer.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/hisii_rocketshotgun.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 3,
        max_count    = 6,    
        entity     = "data/entities/animals/vault/goo_slug.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.085,
        min_count    = 1,
        max_count    = 3,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_hobo.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/wraith_weirdo_shield.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/drone_status_ailment.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_ghost.xml"
    })
    
    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/ghost_bow.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.065,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/devourer_magic.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/forsaken_eye.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/musical_being_weak.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/coldgazer_greater.xml",
        ngpluslevel = 1
    })

    table.insert(g_props,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/mimic_explosive_box.xml"
    })

    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_ambrosia.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_den/forsaken_eye.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })
  
    table.insert(g_small_enemies,
    {
        prob           = 0.10,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/worm_mechanical.xml"
    })

end











--Big Enemies
if g_big_enemies then
    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.025,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/longleg_pillar.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/buildings/hamis_nest.xml",
			},
			{
				min_count	= 2,
				max_count 	= 3,
				entity = "data/entities/animals/longleg.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_minecart.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_minecart_tnt.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/secret/hisii_minecart.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.01,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_giga_bomb.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/cursed_liquid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/buildings/esoteric_being_asleep.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fairy_esoteric.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
        offset_y 	= -3,
        entity     = "data/entities/animals/wizard_z_poly_miniboss.xml",
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.007,
        min_count    = 4,
        max_count    = 12,    
        entity     = "data/entities/animals/wraith_returner_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.001,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/buildings/hamis_nest.xml",
			},
			{
				min_count	= 2,
				max_count 	= 3,
				entity = "data/entities/animals/longleg.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.07,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/hisii_minecart.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.04,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/hisii_minecart_tnt.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/secret/hisii_minecart.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.007,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/excavationsite/poring_lukki_fake.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,
		entities 	= {
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/ccc_bat_psychic.xml",
			},
			{
				min_count	= 3,
				max_count 	= 4,
				entity = "data/entities/animals/fairy_big.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungicave/lukki_fungus.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.35,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tentacler_big.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.35,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/shaman_greater_apotheosis.xml"
    })

    if ModIsEnabled("worse_enemies") == false then
        table.insert(g_big_enemies,
        {
            prob           = 0.35,
            min_count    = 1,
            max_count    = 1,    
            entity     = "data/entities/animals/blob_big.xml"
        })
    end

    table.insert(g_big_enemies,
    {
        prob           = 0.025,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.35,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/lukki_fungus.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/crypt/tentacler_big.xml"
    })
        
    table.insert(g_big_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/fungiforest/shaman_greater_apotheosis.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/blob_huge.xml"
    })
    
    table.insert(g_big_enemies,
	{
		prob   		= 0.03,
		min_count	= 1,
		max_count	= 1,    
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/wizard_duck.xml",
			},
			{
				min_count	= 5,
				max_count 	= 7,
				entity = "data/entities/animals/enchanted_duck.xml",
			},
		}
	})
    
    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.005,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_firemage_greater.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_manaeater.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/wraith_returner_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/giant_centipede.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/power_plant/tesla_turret.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/gazer_robot.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/c_basebot_speeder_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/buildings/portal_stand.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.35,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/musical_being.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/hisii_engineer.xml",
			},
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/drone_lasership.xml",
			}
		}
	})

    table.insert(g_big_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tesla_turret.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.09,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/bubbles/freezing_liquid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/hisii_engineer.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.15,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tesla_turret.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entities     =  {
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/hisii_engineer.xml",
			},
			{
				min_count	= 2,
				max_count 	= 2,
				entity = "data/entities/animals/tank_flame_apotheosis.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/buildings/herobrine.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 2,
        max_count    = 3,    
        entity     = "data/entities/animals/bubbles/acid/bubble_liquid.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/sentry.xml"
    })
  
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/tank_flame_apotheosis.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/vault/drone_status_ailment.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
		entities 	= 
        {
            "data/entities/animals/vault/tentacler_big.xml",
            "data/entities/animals/vault/tentacler.xml",
            "data/entities/animals/vault/tentacler.xml"
        }
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 6,
        max_count    = 9,    
        entity     = "data/entities/animals/wraith_weirdo_shield.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.12,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_manaeater.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/buildings/esoteric_being_asleep.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.3,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/manadrain_crystal.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/musical_being.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.05,
        min_count    = 1,
        max_count    = 1,
        entities     =  {
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/secret/gazer_greater_cold.xml",
			},
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "mods/Apotheosis/files/entities/misc/remove_ground_small.xml",
			},
		}
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_duck.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_explosive.xml"
    })

    table.insert(g_big_enemies,
	{
		prob   		= 0.015,
		min_count	= 1,
		max_count	= 1,    
		entities 	= {
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/wizard_duck.xml",
			},
			{
				min_count	= 5,
				max_count 	= 7,
				entity = "data/entities/animals/enchanted_duck.xml",
			},
		}
	})


    
    table.insert(g_big_enemies,
    {
        prob           = 0.06,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_firemage_greater.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.06,
        min_count    = 2,
        max_count    = 3,    
        entity     = "data/entities/animals/poring_magic.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.02,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_copeseethmald.xml"
    })
  
    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_ambrosia.xml"
    })
  
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_jackofalltrades.xml"
    })
    
    table.insert(g_big_enemies,
    {
        prob           = 0.1,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/animals/wizard_transmutation.xml"
    })

    table.insert(g_big_enemies,
    {
        prob           = 0.08,
        min_count    = 1,
        max_count    = 1,
        offset_y 	= -3,
        entity     = "data/entities/animals/wizard_z_poly_miniboss.xml",
    })
    
    table.insert(g_big_enemies,
	{
		prob   		= 0.02,
		min_count	= 1,
		max_count	= 1,    
		entities 	= { "data/entities/animals/duck.xml", "data/entities/animals/wizard_ambrosia.xml", "data/entities/animals/wizard_ambrosia.xml", "data/entities/animals/wizard_ambrosia.xml", "data/entities/animals/wizard_jackofalltrades.xml", "data/entities/animals/wizard_jackofalltrades.xml", "data/entities/animals/wizard_transmutation.xml", "data/entities/animals/wizard_poly.xml", "data/entities/animals/wizard_swapper.xml", "data/entities/animals/wizard_homing.xml" },
	})

end



















--Props
if g_props then

    table.insert(g_props,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/props/crystal_lime.xml"
    })
  
    table.insert(g_props,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 1,    
        entity     = "data/entities/props/crystal_opal.xml"
    })
  
    table.insert(g_props,
    {
        prob           = 0.25, --Originally 0.2, increased to compensate for opal crystals being added
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/buildings/polymorph_crystal.xml"
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
            prob           = 0.4,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/cat_immortal/fairy_cheap.xml"
        })
    else
        table.insert(g_lamp,
        {
            prob           = 0.4,
            min_count    = 6,
            max_count    = 12,    
            entity     = "data/entities/animals/fairy_cheap.xml"
        })
    end

    table.insert(g_lamp,
    {
        prob           = 0.2,
        min_count    = 1,
        max_count    = 2,    
        entity     = "data/entities/animals/fairy_big.xml"
    })

    table.insert(g_lamp,
    {
        prob           = 0.2,
        min_count    = 5,
        max_count    = 10,    
        entity     = "data/entities/animals/whisp.xml"
    })
end