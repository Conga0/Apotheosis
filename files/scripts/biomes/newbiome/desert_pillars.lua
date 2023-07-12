-- default biome functions that get called if we can't find a a specific biome that works for us
CHEST_LEVEL = 0
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xff30D14E, "spawn_secret_checker" )
RegisterSpawnFunction( 0xff3cfbf4, "spawn_essence_eater" )
RegisterSpawnFunction( 0xffffeedd, "init" )

local debug_mode = DebugGetIsDevBuild()

------------ SMALL ENEMIES ----------------------------------------------------

g_small_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 1.5,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_smg.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_smg.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_leader.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank.xml"
	},
	{
		prob   		= 0.001,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank_super.xml"
	},
}

g_big_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 1.5,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/firemage.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/firemage_weak.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/thundermage.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/wizard_tele.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/wizard_returner.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/wizard_dark.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/wizard_weaken.xml"
	},
	{
		prob   		= 0.001,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/enlightened_alchemist.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/buildings/hpcrystal.xml"
	},
}

g_unique_enemy =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.0,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/slimeshooter.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/acidshooter.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/giantshooter.xml"
	},
}

g_ghostlamp =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics_chain_torch_ghostly.xml"
	},
}

g_candles =
{
	total_prob = 0,
	{
		prob   		= 0.33,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_candle_1.xml"
	},
	{
		prob   		= 0.33,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_candle_2.xml"
	},
	{
		prob   		= 0.33,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_candle_3.xml"
	},
}

------------ MISC --------------------------------------

-- actual functions that get called from the wang generator

function init(x, y, w, h)
	x = x + 512
	y = y + 100
	local count = 6
	local width = 660
	local inc = width / count
	local size = 48

	--Count if player has 45 orbs
	if (GameGetOrbCountAllTime() > 44) then
		AddFlagPersistent("apotheosis_card_unlocked_45_orbs")
	end

	local new_orb_count = 0
	--Count how many of the new orbs the player has attained
	for k=13,16 do
	if k == 13 then k = 13 end
		if HasFlagPersistent(table.concat({"apotheosis_card_unlocked_orb_",v})) then
			new_orb_count = new_orb_count + 1
		end
	end

	if new_orb_count > 3 then
		AddFlagPersistent("apotheosis_card_unlocked_foundallneworbs")
	elseif new_orb_count > 0 then
		AddFlagPersistent("apotheosis_card_unlocked_foundneworb")
	end
	
	local under = 2
	local above = 2

	--{flag required, statue png filename}
	
	SetRandomSeed( x, y )
	local flags = 
	{
		{ { "pandora_chest_rain", "p_secret_pandora" }, { "musical_magic_played", "p_secret_musical_magic" }, },
		{ { "perkforged_protection_fire", "p_perk_fire" }, { "perkforged_breath_underwater", "p_perk_breathless" }, { "perkforged_protection_electricity", "p_perk_electricity" }, { "perkforged_telekinesis", "p_perk_telekinesis" }, { "perkforged_edit_wands_everywhere", "p_perk_twwe" }, { "perkforged_remove_fog_of_war", "p_perk_ase" }, { "perkforged_apotheosis_alcohol_immunity", "p_perk_drunk" }, { "perkforged_apotheosis_trip_immunity", "p_perk_trip" }, { "perkforged_mega_beam_stone", "p_perk_beamstone" }, {"perkforged_global_gore", "p_perk_moreblood"}, { "perkforged_apotheosis_plane_radar", "p_perk_radar" }, { "essence_fungus", "p_essence_fungus" }, { "moon_fungus_unlock", "p_essence_fungus_moon" }, },
		{ { "dev_test_889", "p_ending_01" }, },
		{ { "boss_toxic_worm", "p_boss_toxic" }, { "blob_boss", "p_boss_blob" }, { "musical_boss", "p_boss_music" }, {"boss_monolith", "p_boss_monolith"}, { "boss_fire_lukki", "p_boss_fire_lukki" }, { "boss_flesh_monster", "p_boss_heretic" }, },
		{ { "foundneworb", "p_orb_1" }, { "foundallneworbs", "p_orb_4" }, { "45_orbs", "p_orb_45" }, },
		{ { "divine_red_fish_unlocked", "p_secret_red_fish" }, { "cat_secret", "p_secret_cat" }, { "donated_beggar", "p_secret_hobo" }, { "sleep", "p_secret_sleep" }, { "lost_alchemy", "p_secret_alchemy_ants" }, { "perk_creation", "p_secret_perk_creation" }, { "omega_cross", "p_secret_omegadeath" }, { "rage_aura", "p_secret_trolling" }, },
	}
	
	for i=1,count do
		local px = x - (count) * inc * 0.5 + (i-1) * inc
		local py = y
		
		for j=1,under do
			LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/desert/pillar_part.png", true )
			py = py + size
		end
		
		LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/desert/pillar_part_fade.png", true )
		
		local data = flags[i] or {}
		
		local total = above + #data
		
		py = y
		
		for j=1,above do
			py = py - size
			LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/desert/pillar_part.png", true )
		end
		
		for j,v in ipairs(data) do
			local valid = HasFlagPersistent( table.concat({"apotheosis_card_unlocked_",v[1]}) ) or debug_mode
			
			--print( "Checked for " .. tostring(v[1]) .. ", result: " .. tostring(valid) )
			
			if valid then
				py = py - size
				LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/desert/pillar_part_" .. v[2] .. ".png", true )
			end
		end
		
		py = py - size
		local opts = { "pillar_end_01", "pillar_end_03", "pillar_end_06", "pillar_end_02", "pillar_end_05", "pillar_end_04", }
		local opt = ((i-1) % #opts) + 1
		
		LoadPixelScene( "data/biome_impl/pillars/pillar_part_material.png", "", px, py, "data/biome_impl/pillars/desert/" .. opts[opt] .. ".png", true )
	end

	SetRandomSeed(111,222)
	local world = GetParallelWorldPosition(x,y)
	if (Random(1,10000) == 1 and world == 0) then
		AddFlagPersistent(table.concat({"apothe","osis_card","_unlocked_div","ine_red_fi","sh_unl","ocked"}))
		local data = ModTextFileGetContent(table.concat({"data/entities","/animals/fi","sh_re","d.xml"}))
		ModTextFileSetContent(table.concat({"data/entities/animals/","mini","bos","s_pi","t.xml"}),data)
		EntityLoad("data/entities/animals/miniboss_pit.xml",6900,-105)
		print("$log_apotheosis_fish")
	end
end

function spawn_essence_eater(x, y)
	EntityLoad( "data/entities/buildings/essence_eater.xml", x, y )
end

function spawn_small_enemies(x, y)
	if ( y < 1000 ) then
		spawn(g_small_enemies,x,y)
	else
		spawn(g_big_enemies,x,y)
	end
end

function spawn_big_enemies(x, y)
	-- print("spawn_small_enemies")
	spawn(g_big_enemies,x,y)
end

function spawn_items(x, y)
	return
end

function spawn_unique_enemy(x, y)
	spawn(g_unique_enemy,x,y)
end

----------------------------------------------------

function spawn_secret_checker( x, y )

	local entity = EntityLoad( "data/entities/buildings/orb_room_materialchecker.xml", x, y )

	local material1 = CellFactory_GetType( "water" )
	local material2 = -1
	
	local comp_mat = EntityGetFirstComponent( entity, "MaterialAreaCheckerComponent" )
	if comp_mat ~= nil then
		ComponentSetValue( comp_mat, "material", tostring(material1) )
		ComponentSetValue( comp_mat, "material2", tostring(material2) )
	end

	local comp_lua = EntityGetFirstComponent( entity, "LuaComponent" )
	if comp_lua ~= nil then
		ComponentSetValue( comp_lua, "script_material_area_checker_success", "data/scripts/biomes/desert.lua" )
	end

end

------------------------------------------------------------------------

function material_area_checker_success( x, y )
	GameScreenshake( 100 )
	EntityLoad( "data/entities/buildings/teleport_lake.xml", x, y - 200 )
	
	GamePrintImportant( "$log_fasttravel", "$logdesc_fasttravel" )
end