-- default biome functions that get called if we can't find a a specific biome that works for us
-- The level of action ids that are spawned from the chests
CHEST_LEVEL = 4
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/director_helpers_design.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffC8C800, "spawn_lamp2" )
RegisterSpawnFunction( 0xff00AC64, "load_pixel_scene4" )
RegisterSpawnFunction( 0xff80FF5A, "spawn_vines" )
RegisterSpawnFunction( 0xff943030, "spawn_dragonspot" )

------------ SMALL ENEMIES ----------------------------------------------------

g_small_enemies =
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
		prob   		= 0.3,
		min_count	= 2,
		max_count	= 4,    
		entity 	= "data/entities/animals/fly.xml"
	},
}


------------ BIG ENEMIES ------------------------------------------------------

g_big_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.6,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.1,
		min_count	= 2,
		max_count	= 3,    
		entity 	= "data/entities/animals/fungus.xml"
	},
}

g_unique_enemy =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 1.0,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/buildings/physics_cocoon.xml"
	},
}

------------ ITEMS ------------------------------------------------------------

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
		prob   		= 5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_level_04.xml"
	},
}

------------ MISC --------------------------------------

g_nest =
{
	total_prob = 0,
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/buildings/flynest.xml"
	},
}

-- actual functions that get called from the wang generator

function init( x, y, w, h )
	LoadPixelScene( "mods/Apotheosis/files/pixel_scenes/toxic_worm_nest_old/toxic_worm_nest.png", "mods/Apotheosis/files/pixel_scenes/toxic_worm_nest_old/toxic_worm_nest_visual.png", x - 50, y, "mods/Apotheosis/files/pixel_scenes/toxic_worm_nest_old/toxic_worm_nest_background.png", true )
end

function spawn_small_enemies(x, y)
	-- spawn(g_small_enemies,x,y)
	spawn_hp_mult(g_small_enemies,x,y,0,0,2,"rainforest")
end

function spawn_big_enemies(x, y)
	-- spawn(g_big_enemies,x,y)
	spawn_hp_mult(g_big_enemies,x,y,0,0,2,"rainforest")
end

function spawn_unique_enemy(x, y)
	-- spawn(g_unique_enemy,x,y)
	spawn_hp_mult(g_unique_enemy,x,y,0,0,2,"rainforest")
end

function spawn_items(x, y)
	local r = ProceduralRandom( x-11.631, y+10.2257 )
	
	if (r > 0.27) then
		LoadPixelScene( "data/biome_impl/wand_altar.png", "data/biome_impl/wand_altar_visual.png", x-10, y-17, "", true )
	end
end

function spawn_nest(x, y)
	spawn(g_nest,x,y)
end

function spawn_props(x, y)
	spawn(g_props,x,y)
end

function spawn_lamp(x, y)
	spawn(g_lamp,x,y-10)
end

function spawn_lamp2(x, y)
	spawn(g_lamp2,x,y)
end

function load_pixel_scene( x, y )
	load_random_pixel_scene( g_pixel_scene_01, x, y )
end

function load_pixel_scene2( x, y )
	load_random_pixel_scene( g_pixel_scene_02, x, y )
end

function load_pixel_scene4( x, y )
	load_random_pixel_scene( g_pixel_scene_04, x, y )
end

function spawn_vines(x, y)
	spawn(g_vines,x+5,y+5)
end

function spawn_dragonspot(x, y)
	EntityLoad( "data/entities/buildings/toxic_worm_nest_populator.xml", x, y + 50 )
end