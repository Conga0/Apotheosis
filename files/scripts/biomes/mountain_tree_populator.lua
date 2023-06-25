
function spawn_pillars( x, y )

	local flags = 
	{
		{ { "misc_chest_rain", "crain" }, { "misc_worm_rain", "wrain" }, { "misc_greed_rain", "grain" }, { "misc_altar_tablet", "train" }, { "misc_monk_bots", "mbots" }, { "misc_sun_effect", "seffect" }, { "misc_darksun_effect", "dseffect" }, { "secret_tower", "secrett" }, { "player_status_ghostly", "pghost" }, { "player_status_ratty", "prat" }, { "player_status_funky", "pfungi" }, { "player_status_lukky", "plukki" }, { "player_status_halo", "phalo" } },
		{ { "essence_fire", "essencef" }, { "essence_water", "essencew" }, { "essence_laser", "essencee" }, { "essence_air", "essencea" }, { "essence_alcohol", "essenceal" }, { "secret_moon", "moon" }, { "secret_moon2", "moona" }, { "special_mood", "moong" }, { "secret_dmoon", "dmoon" }, { "dead_mood", "dmoong" }, { "secret_sun_collision", "sunmoon" }, { "secret_darksun_collision", "dsunmoon" } },
		{ { "progress_ending0", "end0" }, { "progress_ending1_toxic", "endt" }, { "progress_ending1_gold", "endb" }, { "progress_ending2", "endg" }, { "progress_newgameplusplus3", "endp" }, { "progress_nightmare", "endn" } },
		{ { "miniboss_dragon", "minid" }, { "miniboss_limbs", "minil" }, { "miniboss_ghost", "minigh" }, { "miniboss_pit", "minip" }, { "miniboss_alchemist", "minia" }, { "miniboss_robot", "minir" }, { "miniboss_wizard", "meme" }, { "miniboss_maggot", "maggot" }, { "miniboss_fish", "fish" }, { "miniboss_gate_monsters", "minigm" }, { "final_secret_orb3", "yeah3" }, { "boss_centipede", "boss" } },
		{ { "progress_orb_1", "orbf" }, { "progress_orb_evil", "orbe" }, { "progress_orb_all", "orba" }, { "progress_pacifist", "pacifist" }, { "progress_nogold", "nogold" }, { "progress_clock", "clock" }, { "progress_minit", "minit" }, { "progress_nohit", "nohit" }, { "progress_sun", "sun" }, { "progress_darksun", "dsun" }, { "progress_sunkill", "sunkill" }, { "secret_supernova", "col" } },
		{ { "secret_greed", "secretg" }, { "final_secret_orb", "yeah" }, { "final_secret_orb2", "yeah2" }, { "secret_chest_dark", "secretcd" }, { "secret_chest_light", "secretcl" }, { "card_unlocked_everything", "secretall" }, { "card_unlocked_divide", "secretten" }, { "secret_fruit", "secretf" }, { "secret_allessences", "secretae" }, { "secret_meditation", "secretme" }, { "secret_buried_eye", "secretbe" }, { "secret_hourglass", "secrethg" }, { "progress_hut_a", "huta" }, { "progress_hut_b", "hutb" }, { "secret_null", "null" } },
	
        --Apotheosis flags:
        --Bosses
        --Secrets
        --Pickups/Essences
        --[[
        ]]--
		{
            { "apotheosis_card_unlocked_boss_toxic_worm", "boss_toxic" }, { "apotheosis_card_unlocked_blob_boss", "boss_blob" }, { "apotheosis_card_unlocked_musical_boss", "boss_music" }, { "apotheosis_card_unlocked_boss_fire_lukki", "boss_fire_lukki" }, { "apotheosis_card_unlocked_boss_flesh_monster", "boss_heretic" },
            { "apotheosis_card_unlocked_cat_secret", "secret_cat" }, { "apotheosis_card_unlocked_donated_beggar", "secret_hobo" }, { "apotheosis_card_unlocked_sleep", "secret_sleep" }, { "apotheosis_card_unlocked_lost_alchemy", "secret_alchemy_ants" }, { "apotheosis_card_unlocked_rage_aura", "secret_trolling" }, { "apotheosis_misc_pandora_chest_rain", "secret_pandora" }, { "apotheosis_card_unlocked_omega_cross", "secret_omegadeath" }, { "apotheosis_card_unlocked_perk_creation", "secret_perk_creation" },
            { "apotheosis_essence_fungus", "essence_fungus" }, { "apotheosis_moon_fungus_unlock", "essence_fungus_moon" },
        },
	}

	local count = #flags
	local width = 660
	local inc = width / count
	local size = 48
	
	local under = 1
	local above = 3
	
	SetRandomSeed( x, y )
	
    --apotheosis_card_unlocked_

	for i=1,count do
		local px = x - (count) * inc * 0.5 + (i-1) * inc
		local py = y
		
		for j=1,under do
			LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/pillar_part.png", true )
			py = py + size
		end
		
		LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/pillar_part_fade.png", true )
		
		local data = flags[i] or {}
		
		local total = above + #data
		
		py = y
		
		for j=1,above do
			py = py - size
			LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/pillar_part.png", true )
		end
		
		for j,v in ipairs(data) do
			local valid = HasFlagPersistent( v[1] )

            --Debug data
			--local valid = true
			
			--print( "Checked for " .. tostring(v[1]) .. ", result: " .. tostring(valid) )

            local pillargfx = table.concat({"data/biome_impl/pillars/pillar_part_",v[2],".png"})
			
			if valid then
				py = py - size
				LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, pillargfx, true )
			end
		end
		
		py = py - size
		local opts = { "pillar_end_01", "pillar_end_03", "pillar_end_06", "pillar_end_02", "pillar_end_05", "pillar_end_04", }
		local opt = ((i-1) % #opts) + 1
		
		LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/" .. opts[opt] .. ".png", true )
	end
end