
--Why can't you just be normal, tower?... well, let's get to it
--Acidshooter is where normal vanilla enemies start

--New enemies compatibility

--Conga: This is no longer used, tower integration has been moved to vanilla_appends.lua for cross mod compatibility
--Please don't use this method if you're an up and coming enemy modder

local apotheosis_appends = { "boss_toxic_worm", "boss_toxic_worm_minion", "bubble_liquid", "bubbles/ambrosia/bubble_liquid", "blindgazer", "blob_big", "blob_huge", "forsaken_eye", "fungus_smoking_creep", "gazer_cold_apotheosis", "gazer_greater", "gazer_greater_cold", "gazer_greater_sky", "gazer_robot", "ghost_bow", "giant_centipede", "vault/goo_slug", "ccc_bat_psychic", "fungiforest/ceiling_fungus", "devourer_ghost", "devourer_magic", "drone_mini", "drone_status_ailment", "esoteric_being", "fairy_big", "fairy_big_discord", "fairy_esoteric", "crypt/hideous_mass", "vault/hisii_engineer", "hisii_giga_bomb", "hisii_minecart", "hisii_minecart_tnt", "hisii_rocketshotgun", "locust_swarm", "lukki_fungus", "lukki_swarmling", "mimic_explosive_box", "poisonmushroom", "poring", "poring_holy", "poring_lukki", "poring_magic", "rat_birthday", "sentry", "star_child", "sunken_creature", "slime_leaker", "slime_leaker_weak", "slime_warping", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_big", "tesla_turret", "triangle_gem", "watermage", "whisp", "whisp_big", "witch_miniboss/witch_variants/arcane/witch_miniboss.xml", "wizard_ambrosia", "wizard_copeseethmald", "wizard_duck", "wizard_explosive", "wizard_manaeater", "wizard_transmutation", "wizard_firemage_greater", "wizard_z_poly_miniboss", "wraith_returner_apotheosis", "wraith_weirdo_shield", }

for k=1,#apotheosis_appends do
    table.insert(enemy_list,apotheosis_appends[k])
end


function spawn_any_enemy( x, y )
    SetRandomSeed( x, y )
    if safe( x, y ) then
        local rnd = Random( 1, #enemy_list )
        local target = enemy_list[rnd]
        
        local eid = EntityLoad( "data/entities/animals/" .. target .. ".xml", x, y )
        
        if ( target ~= "scavenger_heal" ) and ( target ~= "healerdrone_physics" ) and ( target ~= "boss_toxic_worm" ) then
            local damagemodels = EntityGetComponent( eid, "DamageModelComponent" )
            if( damagemodels ~= nil ) then
                for k=1,#damagemodels
                do damagemodel = damagemodels[k]
                    local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) ) * 4
                    
                    ComponentSetValue( damagemodel, "max_hp", hp )
                    ComponentSetValue( damagemodel, "hp", hp )
                end
            end
        end
    end
end
