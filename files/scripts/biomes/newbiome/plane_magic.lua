-- default biome functions that get called if we can't find a a specific biome that works for us
-- The level of action ids that are spawned from the chests
CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/biome_modifiers.lua")
dofile( "data/scripts/items/generate_shop_item.lua" )

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xff00AC64, "load_background_panel_big" )
RegisterSpawnFunction( 0xff80FF5A, "spawn_vines" )
RegisterSpawnFunction( 0xff2FC6EC, "spawn_alchemy_secret_entry" )
RegisterSpawnFunction( 0xff8EF1B3, "spawn_alchemy_secret_entry_book" )
RegisterSpawnFunction( 0xffB0742E, "spawn_enemy_clear_256" )
RegisterSpawnFunction( 0xff15a43a, "spawn_potions" )
RegisterSpawnFunction( 0xffd9aa2d, "spawn_eggs" )

g_small_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.2,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add Aesthete of Heat after this step
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/planes/watermage_greater.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/planes/wizard_firemage_greater.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/planes/slime_teleporter.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 3,    
		entity 	= "data/entities/animals/planes/wizard_corrupt_wands.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/planes/whisp_big.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 2,
		max_count	= 4,    
		entity 	= "data/entities/animals/rat.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/planes/devourer_magic.xml"
	},
}

g_big_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.2,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add Aesthete of Heat after this step
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/failed_alchemist_b.xml"
	},
}

------------ items -------------------------------

g_items =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_unshuffle_02.xml"
	},
	{
		prob   		= 2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_level_02.xml"
	},
	{
		prob   		= 2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_level_03_better.xml"
	},
	{
		prob   		= 0.02,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_level_05_better.xml"
	},
}

g_lamp =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.5,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics/lantern_small.xml"
	},
}

g_props =
{
	total_prob = 0,
	{
		prob   		= 0.5,
		min_count	= 0,
		max_count	= 0,
		offset_y 	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.8,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 5,
		entity 	= "data/entities/props/physics_bed.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_crate.xml"
	},
}

g_props2 =
{
	total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 5,
		entity 	= "data/entities/props/banner.xml"
	},
}

g_bottle =
{
	total_prob = 0,
	{
		prob   		= 0.1,
		min_count	= 0,
		max_count	= 0,
		offset_y 	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -5,
		entity 	= "data/entities/props/physics_bottle_green.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -5,
		entity 	= "data/entities/props/physics_bottle_red.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -5,
		entity 	= "data/entities/props/physics_bottle_blue.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -5,
		entity 	= "data/entities/props/physics_bottle_yellow.xml"
	},
}

g_chest =
{
	total_prob = 0,
	{
		prob   		= 0.6,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/chest.xml"
	},
}

g_vines =
{
	total_prob = 0,
	{
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_long.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_short.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_shorter.xml"
	},
}

g_pixel_scene_01 =
{
	total_prob = 0,
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/container_01.png",
		visual_file		= "data/biome_impl/liquidcave/container_01_visual.png",
		background_file	= "",
		is_unique		= 0,
		color_material = { ["fff0bbee"] = { "oil", "alcohol", "lava", "magic_liquid_teleportation", "magic_liquid_protection_all", "material_confusion", "liquid_fire" } }
	},
}

g_background_panel_big =
{
	total_prob = 0,
	{
		prob   			= 0.2,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_01.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_02.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_03.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_04.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_05.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_06.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_07.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/liquidcave/background_panel_big_material.png",
		visual_file		= "",
		background_file	= "data/biome_impl/liquidcave/background_panel_big_08.png",
		is_unique		= 0
	},
}

-- this is a special function tweaked for spawning things in coal mines
function spawn_items( pos_x, pos_y )
	--[[
	local r = ProceduralRandom( pos_x, pos_y )
	-- 20% is air, nothing happens
	-- is this needed anymore?
	-- if( r < 0.47 ) then return end
	r = ProceduralRandom( pos_x-11.431, pos_y+10.5257 )

	if( r < 0.725 ) then
	else
		LoadPixelScene( "data/biome_impl/wand_altar.png", "data/biome_impl/wand_altar_visual.png", pos_x-10, pos_y-17, "", true )
		return
	end
	]]--
end

function spawn_small_enemies(x, y)
	spawn(g_small_enemies,x,y)
end

function spawn_big_enemies(x, y)
	spawn(g_big_enemies,x,y)
end

function spawn_lamp( x, y )
	spawn(g_lamp,x,y+4,0,0)
end
 
function spawn_props( x, y ) 
	spawn(g_props,x,y,0,0)
end
 
function spawn_props2( x, y ) 
	spawn(g_props2,x,y,0,0)
end

function spawn_bottle( x, y ) 
	spawn(g_bottle,x,y,0,0)
end

function spawn_shopkeeper(x, y)
end

function spawn_props3( x, y ) end
function spawn_blood( x, y ) end
function load_pixel_scene2( x, y ) end
function spawn_unique_enemy( x, y ) end
function spawn_unique_enemy2( x, y ) end
function spawn_unique_enemy3( x, y ) end
function spawn_save( x, y ) end
function spawn_ghostlamp( x, y ) end
function spawn_persistent_teleport( x, y ) end
function spawn_candles( x, y ) end

function init( x, y, w, h )
	--EntityLoad( "mods/apotheosis/files/entities/buildings/biome_status/debuff_magic.xml", x + 256, y + 256 )

	--Conga: Might be better to just parent particle effects to the player when they use the portal to enter this biome
	
	--EntityLoad( "mods/apotheosis/files/entities/buildings/biome_status/debuff_magic_small.xml", x + 128, y + 128 )
	--EntityLoad( "mods/apotheosis/files/entities/buildings/biome_status/debuff_magic_small.xml", x + 128, y + (128 * 3) )
	--EntityLoad( "mods/apotheosis/files/entities/buildings/biome_status/debuff_magic_small.xml", x + (128 * 3), y + 128 )
	--EntityLoad( "mods/apotheosis/files/entities/buildings/biome_status/debuff_magic_small.xml", x + (128 * 3), y + (128 * 3) )
end

function load_pixel_scene( x, y )
	load_random_pixel_scene( g_pixel_scene_01, x-5, y-3 )
end

function load_background_panel_big( x, y )
	load_random_pixel_scene( g_background_panel_big, x, y )
end

function spawn_vines(x, y)
	spawn(g_vines,x+5,y+5)
end

function spawn_potions(x, y)
	spawn_from_list( "potion_spawnlist_liquidcave", x, y )
end

function spawn_alchemy_secret_entry(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/teleport_alchemy_secret_entry.xml", x, y)
end

function spawn_alchemy_secret_entry_book(x, y)
	EntityLoad("mods/apotheosis/files/entities/items/books/book_material_spells.xml", x, y)
end

function spawn_enemy_clear_256(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/enemy_clear_256.xml", x, y)
end

function spawn_potions(x, y)
	EntityLoad("data/entities/items/pickup/potion.xml", x, y)
end

function spawn_eggs(x, y)
	SetRandomSeed(x+y, x*y)
	if Random(1,2) == 1 then
		EntityLoad("data/entities/buildings/apotheosis_ant_eggs.xml", x, y)
	end
end