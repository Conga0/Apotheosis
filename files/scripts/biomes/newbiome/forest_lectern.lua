-- default biome functions that get called if we can't find a a specific biome that works for us
-- The level of action ids that are spawned from the chests
CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xff55AF8C, "spawn_skulls" )
RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffb0742e, "spawn_book" )
RegisterSpawnFunction( 0xff2fc6ec, "spawn_quest_point" )

-----------------------------------2fc6ec---

g_items =
{
	total_prob = 0,
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_level_03.xml"
	},
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_unshuffle_02.xml"
	},
}

--------------------------------------

g_skulls =
{
	total_prob = 0,
	{
		prob   		= 6,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= ""
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_skull_01.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_skull_02.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_skull_03.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_01.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_02.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_03.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_04.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_05.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_06.xml"
	},
}

g_stones =
{
	total_prob = 0,
	{
		prob   		= 2,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/stonepile.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_01.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_02.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_03.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_04.xml"
	},
	{
		prob   		= 4,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= ""
	},
}

g_lamp =
{
	total_prob = 0,
	{
		prob   		= 0.25,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics/temple_lantern.xml"
	},
}

--------------------------------------

function init(x, y, w, h)
	local parallel = GetParallelWorldPosition( x, y )
	if parallel == 0 then
		--LoadPixelScene( "mods/Apotheosis/files/biome_impl/forest/lectern.png", "mods/Apotheosis/files/biome_impl/forest/lectern_visual.png", x, y+340, "mods/Apotheosis/files/biome_impl/ant_hell/alchemy_hidden_background.png", true )
		EntityLoad("mods/Apotheosis/files/entities/buildings/wiseguy_taunt_spawner.xml",x+256,y)
	end
end

function spawn_lamp(x, y)
	spawn(g_lamp,x,y,0,20)
end

function spawn_skulls(x, y)
	spawn(g_skulls,x,y,0,0)
end

function spawn_book(x, y)
	EntityLoad("mods/Apotheosis/files/entities/items/books/book_wiseguy_taunt.xml", x, y)
end

function spawn_quest_point(x, y)
	EntityLoad("mods/Apotheosis/files/entities/buildings/wiseguy_taunt_questcheck.xml", x, y)
end

function spawn_shopitem( x, y ) end
function spawn_small_enemies(x, y) end
function spawn_big_enemies(x, y) end
function spawn_unique_enemy(x, y) end
function spawn_props(x, y) end
function load_pixel_scene( x, y ) end
function load_pixel_scene2( x, y ) end
function spawn_items(x, y) end
