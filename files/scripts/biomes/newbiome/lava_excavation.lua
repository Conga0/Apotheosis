-- default biome functions that get called if we can't find a a specific biome that works for us
-- The level of action ids that are spawned from the chests
CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/biome_modifiers.lua")
dofile( "data/scripts/items/generate_shop_item.lua" )

RegisterSpawnFunction( 0xff0000ff, "spawn_nest" )
RegisterSpawnFunction( 0xffFF50FF, "spawn_hanger" )
RegisterSpawnFunction( 0xff00AC64, "load_pixel_scene4" )
RegisterSpawnFunction( 0xff00ac6e, "load_pixel_scene4_alt" )
RegisterSpawnFunction( 0xff0050FF, "spawn_wheel" )
RegisterSpawnFunction( 0xff0150FF, "spawn_wheel_small" )
RegisterSpawnFunction( 0xff0250FF, "spawn_wheel_tiny" )
RegisterSpawnFunction( 0xff2d2eac, "spawn_rock" )
RegisterSpawnFunction( 0xff0A50FF, "spawn_physicsstructure" )
RegisterSpawnFunction( 0xffc999ff, "spawn_hanging_prop" )
RegisterSpawnFunction( 0xff7868ff, "load_puzzleroom" )
RegisterSpawnFunction( 0xff70d79e, "load_gunpowderpool_01" )
RegisterSpawnFunction( 0xff70d79f, "load_gunpowderpool_02" )
RegisterSpawnFunction( 0xff70d7a0, "load_gunpowderpool_03" )
RegisterSpawnFunction( 0xff70d7a1, "load_gunpowderpool_04" )
RegisterSpawnFunction( 0xff33934c, "spawn_shopitem" )
RegisterSpawnFunction( 0xffb09016, "spawn_meditation_cube" )
RegisterSpawnFunction( 0xff4c11d4, "spawn_props_explosive" )
RegisterSpawnFunction( 0xff00855c, "spawn_receptacle" )

RegisterSpawnFunction( 0xffb1ff99, "spawn_tower_short" )
RegisterSpawnFunction( 0xff5c8550, "spawn_tower_tall" )
RegisterSpawnFunction( 0xff227fff, "spawn_beam_low" )
RegisterSpawnFunction( 0xff8228ff, "spawn_beam_low_flipped" )
RegisterSpawnFunction( 0xff0098ba, "spawn_beam_steep" )
RegisterSpawnFunction( 0xff7600a9, "spawn_beam_steep_flipped" )

RegisterSpawnFunction( 0xffe8892c, "spawn_miniboss" )

RegisterSpawnFunction( 0xff876544, "spawn_nest_egg" )
RegisterSpawnFunction( 0xffffeedd, "init" )

------------ small enemies -------------------------------

g_small_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.55,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 4,    
		entity 	= "data/entities/animals/lava_excavation/firebug.xml"
	},
	{
		prob   		= 0.02,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/lava_excavation/gazer.xml"
	},
	{
		prob   		= 0.08,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/lava_excavation/bigfirebug.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 2,
		entity 	= "data/entities/animals/goblin_bomb.xml"
	},
	{
		prob   		= 0.2,
		min_count	= 6,
		max_count	= 9,  
		entity 	= "data/entities/animals/whisp.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/lava_excavation/wizard_corrupt_hearty.xml"
	},
	{
		prob   		= 0.08,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/fireskull.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/lava_excavation/whisp_big.xml"
	},
}

g_big_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.98,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/bubbles/acid/bubble_liquid.xml"
	},
	{
		prob   		= 0.06,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/miner_fire.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/lava_excavation/gazer.xml"
	},
	{
		prob   		= 0.10,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/lava_excavation/whisp_big.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/triangle_gem.xml"
	},
	{
		prob   		= 0.09,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/fireskull.xml"
	},
	{
		prob   		= 0.07,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_mine.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/miner_santa.xml",
		spawn_check = function() 
			local year, month, day = GameGetDateAndTimeLocal()
			
			if ( month == 12 ) and ( day >= 24 ) and ( day <= 26 ) then
				return true
			else
				return false 
			end
		end
	},
	{
		prob   		= 0.2,
		min_count	= 2,
		max_count	= 4,    
		entity 	= "data/entities/animals/lava_excavation/firebug.xml"
	},
	{
		prob   		= 0.08,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/poring_lukki.xml"
	},
	{
		prob   		= 0.08,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/alchemist.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 2,
		max_count	= 2,    
		entity 	= "data/entities/animals/tank_super.xml",
		ngpluslevel = 1,
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank_flame_apotheosis.xml"
	},
	{
		prob   		= 0.01,
		min_count	= 7,
		max_count	= 10,
		entity 	= "data/entities/animals/goblin_bomb.xml"
	},
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
    },
    {
        prob           = 0.03,
        min_count    = 1,
        max_count    = 1,
        entity     = "data/entities/animals/sentry.xml"
    },
}
g_miniboss_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.1
	{
		prob   		= 0.1,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/secret/lukki_fire_miniboss.xml"
	},
}

g_lamp =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 0.7,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics/lantern_small.xml"
	},
}

---------- UNIQUE ENCOUNTERS ---------------

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

g_unique_enemy2 =
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
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/miner_santa.xml",
		spawn_check = function() 
			local year, month, day = GameGetDateAndTimeLocal()
			
			if ( month == 12 ) and ( day >= 24 ) and ( day <= 26 ) then
				return true
			else
				return false 
			end
		end

	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/shotgunner.xml"
	},
}

g_unique_enemy3 =
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
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/coal_mines/wizard_firemage_greater.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/thundermage_big.xml"
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

--- barrels ---

g_props =
{
	total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 0,
		max_count	= 0,
		offset_y 	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_box_explosive.xml"
	},
	{
		prob   		= 0.25,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= -3,
		entity 	= "data/entities/props/physics/minecart.xml"
	},
	{
		prob   		= 0.25,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= -5,    
		entity 	= "data/entities/props/physics_cart.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_barrel_radioactive.xml"
	},
	{
		prob   		= 0.07,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_barrel_oil.xml"
	},
	{
		prob   		= 0.03,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= -8,    
		entity 	= "data/entities/props/physics_seamine.xml"
	},
}

--- barrels ---
--- only explosive props here ---

g_props_explosive =
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
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_box_explosive.xml"
	},
	{
		prob   		= 0.50,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_barrel_radioactive.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,    
		entity 	= "data/entities/props/physics_barrel_oil.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= -8,    
		entity 	= "data/entities/props/physics_seamine.xml"
	},
}

g_props2 =
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
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -3,
		entity 	= "data/entities/props/physics/minecart.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -5,
		entity 	= "data/entities/props/physics_brewing_stand.xml"
	},
}

g_props3 =
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

--- pixelscenes ---

g_cranes =
{
	total_prob = 0,
	{
		prob   		= 2.2,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics_wheel_stand_01.xml",
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics_wheel_stand_02.xml",
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics_wheel_stand_03.xml",
	},
}

g_mechanism_background =
{
	total_prob = 0,
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/mechanism_background.png",
		z_index			= 50,
	},
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/mechanism_background2.png",
		z_index			= 50,
	},
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/mechanism_background3.png",
		z_index			= 50,
	},
}

g_pixel_scene_04 =
{
	total_prob = 0,
	{
		prob   			= 0.1,
        material_file 	= "mods/Apotheosis/files/biome_impl/excavationsite/shop_01.png",
        visual_file		= "mods/Apotheosis/files/biome_impl/excavationsite/shop_01_visual.png",
		background_file	= "",
		is_unique		= 0
	},
	{
		prob   			= 0.1,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/receptacle_lava.png",
		visual_file		= "",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/receptacle_lava_background.png",
		is_unique		= 0
	},
	{
		prob   			= 1.0,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena.png",
		visual_file		= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_visual.png",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_background.png",
		is_unique		= 0
	},
	{
		prob   			= 1.0,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena.png",
		visual_file		= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_visual.png",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_background.png",
		is_unique		= 0
	},
	{
		prob   			= 1.0,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena.png",
		visual_file		= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_visual.png",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_background.png",
		is_unique		= 0
	},
	{
		prob   			= 1.0,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena.png",
		visual_file		= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_visual.png",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_background.png",
		is_unique		= 0
	},
}

g_pixel_scene_04_alt =
{
	total_prob = 0,
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/excavationsite/machine_1_alt.png",
		visual_file		= "data/biome_impl/excavationsite/machine_1_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_1_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/excavationsite/machine_2_alt.png",
		visual_file		= "data/biome_impl/excavationsite/machine_2_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_2_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/excavationsite/machine_3b_alt.png",
		visual_file		= "data/biome_impl/excavationsite/machine_3b_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_3b_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/excavationsite/machine_4_alt.png",
		visual_file		= "data/biome_impl/excavationsite/machine_4_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_4_background.png",
		is_unique		= 0
	},
	{
		prob   			= 0.5,
		material_file 	= "data/biome_impl/excavationsite/machine_5_alt.png",
		visual_file		= "data/biome_impl/excavationsite/machine_5_visual.png",
		background_file	= "data/biome_impl/excavationsite/machine_5_background.png",
		is_unique		= 0
	},
	{
		prob   			= 3.5,
		material_file 	= "data/biome_impl/excavationsite/shop_alt.png",
		visual_file		= "data/biome_impl/excavationsite/shop_visual.png",
		background_file	= "",
		is_unique		= 0
	},
	{
		prob   			= 3.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/receptacle_lava.png",
		visual_file		= "",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/receptacle_lava_background.png",
		is_unique		= 0
	},
	{
		prob   			= 5.0,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena.png",
		visual_file		= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_visual.png",
		background_file	= "mods/Apotheosis/files/biome_impl/lava_excavation/miniboss_arena_background.png",
		is_unique		= 0
	},
	{
		prob   			= 1.1,
		material_file 	= "data/biome_impl/excavationsite/lake_alt.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0
	},
}

g_puzzleroom =
{
	total_prob = 0,
	{
		prob   			= 1.5,
		material_file 	= "data/biome_impl/excavationsite/puzzleroom_01.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0
	},
	{
		prob   			= 1.5,
		material_file 	= "data/biome_impl/excavationsite/puzzleroom_02.png",
		visual_file		= "data/biome_impl/excavationsite/puzzleroom_02_visual.png",
		background_file	= "",
		is_unique		= 0
	},
	{
		prob   			= 1.5,
		material_file 	= "mods/Apotheosis/files/biome_impl/lava_excavation/puzzleroom_dipper.png",
		visual_file		= "",
		background_file	= "",
		is_unique		= 0
	},
}

g_gunpowderpool_01 =
{
	total_prob = 0,
	{
		prob   			= 1.5,
		material_file 	= "data/biome_impl/excavationsite/gunpowderpool_01.png",
		visual_file		= "data/biome_impl/excavationsite/gunpowderpool_01_visual.png",
		background_file	= "",
		is_unique		= 0
	},
}

g_gunpowderpool_02 =
{
	total_prob = 0,
	{
		prob   			= 1.5,
		material_file 	= "data/biome_impl/excavationsite/gunpowderpool_02.png",
		visual_file		= "data/biome_impl/excavationsite/gunpowderpool_02_visual.png",
		background_file	= "",
		is_unique		= 0
	},
}

g_gunpowderpool_03 =
{
	total_prob = 0,
	{
		prob   			= 1.5,
		material_file 	= "data/biome_impl/excavationsite/gunpowderpool_03.png",
		visual_file		= "data/biome_impl/excavationsite/gunpowderpool_03_visual.png",
		background_file	= "",
		is_unique		= 0
	},
}

g_gunpowderpool_04 =
{
	total_prob = 0,
	{
		prob   			= 1.5,
		material_file 	= "data/biome_impl/excavationsite/gunpowderpool_04.png",
		visual_file		= "data/biome_impl/excavationsite/gunpowderpool_04_visual.png",
		background_file	= "",
		is_unique		= 0
	},
}

g_nest =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/lava_excavation/firebugnest.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
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

g_hanger =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics_bucket.xml"
	},
}

g_physicsstructure =
{
	total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/excavationsite_machine_3b.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/excavationsite_machine_3c.xml"
	},
}

g_rock =
{
	total_prob = 0,
	{
		prob   		= 1.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "",
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_01.xml",
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_02.xml",
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_03.xml",
	},
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1, 
		entity 	= "data/entities/props/physics_stone_04.xml",
	},
}


g_hanging_props =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 0.8,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "mods/Apotheosis/files/entities/props/suspended_tank_lava.xml"
	},
	{
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/suspended_seamine.xml"
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

-- backgrounds
g_tower_mids =
{
	total_prob = 0,
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_mid_1.png",
		z_index			= 40,
	},
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_mid_2.png",
		z_index			= 40,
	},
	{
		prob   			= 0.5,
		sprite_file 	= "data/biome_impl/excavationsite/tower_mid_3.png",
		z_index			= 40,
	},
	{
		prob   			= 0.5,
		sprite_file 	= "data/biome_impl/excavationsite/tower_mid_4.png",
		z_index			= 40,
	},
}
g_tower_tops =
{
	total_prob = 0,
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_top_1.png",
		z_index			= 20,
	},
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_top_2.png",
		z_index			= 20,
	},
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_top_3.png",
		z_index			= 20,
	},
	{
		prob   			= 2.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_top_4.png",
		z_index			= 20,
	},
	{
		prob   			= 1.0,
		sprite_file 	= "data/biome_impl/excavationsite/tower_top_5.png",
		z_index			= 20,
	},
}


-- this is a special function tweaked for spawning things in coal mines
function spawn_items( pos_x, pos_y )
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
end

-- actual functions that get called from the wang generator


function spawn_small_enemies(x, y)
	local r = ProceduralRandom( x, y )
	local spawn_percent = BiomeMapGetVerticalPositionInsideBiome( x, y )
	spawn_percent = ( 2.5 * spawn_percent ) + 0.35
	if( r > spawn_percent ) then return end

	spawn(g_small_enemies,x,y)
end

function spawn_big_enemies(x, y)
	local r = ProceduralRandom( x, y )
	local spawn_percent = BiomeMapGetVerticalPositionInsideBiome( x, y )
	spawn_percent = ( 2.1 * spawn_percent )
	if( r > spawn_percent ) then return end

	spawn(g_big_enemies,x,y)
end

function spawn_lamp(x, y)
	spawn(g_lamp,x,y+2,0,0)
end

function spawn_props(x, y)
	spawn(g_props,x,y-3,0,0)
end

function spawn_props_explosive(x, y)
	spawn(g_props_explosive,x,y,0,0)
end

function spawn_props2(x, y)
	spawn(g_props2,x,y-3,0,0)
end

function spawn_props3(x, y)
	spawn(g_props3,x,y,0,0)
end

function spawn_unique_enemy(x, y)
	spawn(g_unique_enemy,x,y)
end

function spawn_unique_enemy2(x, y)
	spawn(g_unique_enemy2,x,y)
end

function spawn_unique_enemy3(x, y)
	spawn(g_unique_enemy3,x,y)
end

function load_pixel_scene( x, y )
	--spawn(g_cranes,x+35,y+35,0,0)
end

function load_pixel_scene2( x, y )
	load_random_background_sprite( g_mechanism_background, x, y )
end

function load_pixel_scene4( x, y )
	load_random_pixel_scene( g_pixel_scene_04, x, y )
end

function load_pixel_scene4_alt( x, y )
	load_random_pixel_scene( g_pixel_scene_04_alt, x, y )
end

function load_puzzleroom( x, y )
	load_random_pixel_scene( g_puzzleroom, x, y )
end

function load_gunpowderpool_01( x, y )
	load_random_pixel_scene( g_gunpowderpool_01, x, y )
end

function load_gunpowderpool_02( x, y )
	load_random_pixel_scene( g_gunpowderpool_02, x, y )
end

function load_gunpowderpool_03( x, y )
	load_random_pixel_scene( g_gunpowderpool_03, x-3, y+3 )
end

function load_gunpowderpool_04( x, y )
	load_random_pixel_scene( g_gunpowderpool_04, x, y )
end

function spawn_physicsstructure(x, y)
	spawn(g_physicsstructure,x-5,y-5,0,0)
end

function spawn_wheel(x, y)
	EntityLoad( "data/entities/props/physics_wheel.xml", x, y )
end

function spawn_wheel_small(x, y)
	EntityLoad( "data/entities/props/physics_wheel_small.xml", x, y )
end

function spawn_wheel_tiny(x, y)
	EntityLoad( "data/entities/props/physics_wheel_tiny.xml", x, y )
end

function spawn_hanger(x, y)
	spawn(g_hanger,x,y,0,0)
end

function spawn_rock(x, y)
	spawn(g_rock,x,y)
end

function spawn_hanging_prop(x, y)
	spawn(g_hanging_props,x,y)
end

function spawn_nest(x, y)
	spawn(g_nest,x+4,y+8,0,0)
end

function spawn_ladder(x, y)
	--spawn(g_ladder,x,y-80,0,0)
end

function spawn_shopitem( x, y )
	generate_shop_item( x, y, false, 2 )
end

function spawn_meditation_cube( x, y )
	SetRandomSeed( x, y )
	local rnd = Random( 1, 100 )
	if( rnd > 96 and not ModIsEnabled("nightmare") ) then
		--LoadPixelScene( "data/biome_impl/excavationsite/meditation_cube.png", "data/biome_impl/excavationsite/meditation_cube_visual.png", x-20, y-29, "", true )
		--EntityLoad( "data/entities/buildings/teleport_meditation_cube.xml", x, y-70 )
	end
end

function spawn_receptacle( x, y )
	EntityLoad( "mods/Apotheosis/files/entities/buildings/puzzle_check_lava.xml", x, y )
end

function spawn_miniboss(x, y)
	spawn(g_miniboss_enemies,x,y)
end

-- Background sprites
function spawn_tower_short(x,y)
	generate_tower(x,y,ProceduralRandomi(x-4,y+3,0,2))
end

function spawn_tower_tall(x,y)
	generate_tower(x,y,ProceduralRandomi(x+7,y-1,2,3))
end

function generate_tower( x, y, height )
	if ProceduralRandom(x,y) > 0.5 then
		return
	end

	y = y + 15

	-- bottom
	LoadBackgroundSprite("data/biome_impl/excavationsite/tower_bottom_1.png", x, y, 40, true )
	y = y - 60
	
	-- middle parts
	for i=1, height do
		if y > 1600 then -- build up when not near the top of the biome
			load_random_background_sprite( g_tower_mids, x, y )
			y = y - 60
		end
	end

	-- top
	x = x - 50
	load_random_background_sprite( g_tower_tops, x, y )
end

function spawn_beam_low(x,y)
	LoadBackgroundSprite("data/biome_impl/excavationsite/beam_low.png", x-60, y-35, 60, true )
end

function spawn_beam_low_flipped(x,y)
	LoadBackgroundSprite("data/biome_impl/excavationsite/beam_low_flipped.png", x-60, y-35, 60, true)
end

function spawn_beam_steep(x,y)
	LoadBackgroundSprite("data/biome_impl/excavationsite/beam_steep.png", x-35, y-60, 60, true)
end

function spawn_beam_steep_flipped(x,y)
	LoadBackgroundSprite("data/biome_impl/excavationsite/beam_steep_flipped.png", x-35, y-60, 60, true)
end

-- spawning in the egg traps around the biome
function init(x, y, w, h)
    if previousinit ~= nil then
        previousinit(x, y, w, h)
    end
    -- figure out positions for 4* fire lukki egg traps within the biome
    -- and spawn them if a position is within the bounds of this function call
    local egg_amount = tonumber(GlobalsGetValue("APOTHEOSIS_EGG_VOLCANIC_TRAP_AMOUNT","3")) + math.floor(0.5 * tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")))
    if GameHasFlagRun("apotheosis_everything") then
        egg_amount = egg_amount * 2
    elseif GameHasFlagRun("apotheosis_hardmode") then
        egg_amount = math.floor(egg_amount * 1.5)
    end
    local hatched_egg_amount = math.floor(egg_amount / 10)
    egg_amount = egg_amount % 10

    local biome_x_min = -24042
    local biome_x_max = -19036
    local biome_y_min = 3261
    local biome_y_max = 4490
    if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 then
        biome_x_min = -24042
        biome_x_max = -19036
        biome_y_min = 2562
        biome_y_max = 4490
    elseif GameHasFlagRun("apotheosis_downunder") or GameHasFlagRun("apotheosis_everything") then
        biome_x_min = -24042
        biome_x_max = -19036
        biome_y_min = 8718
        biome_y_max = 10223
    end
    for i=1,egg_amount do
        local pos_x = ProceduralRandomi(109,i*53,biome_x_min,biome_x_max)
        local pos_y = ProceduralRandomi(111,i*2.9,biome_y_min,biome_y_max)

        if pos_x >= x and pos_x <= x+w
        and pos_y >= y and pos_y <= y+h then
            -- Generate Fire Lukki Nests
            LoadPixelScene( "mods/Apotheosis/files/biome_impl/excavationsite/fire_lukki_egg.png", "mods/Apotheosis/files/biome_impl/excavationsite/fire_lukki_egg_visual.png", pos_x-22, pos_y-22, "mods/Apotheosis/files/biome_impl/excavationsite/fire_lukki_egg_background.png", true )
            
            --Debug Data
            --GamePrint("Spawning nest at X: " .. pos_x .. ", Y: " .. pos_y)
            --print("Spawning nest at X: " .. pos_x .. ", Y: " .. pos_y)
        end	
    end
    for i=1,hatched_egg_amount do
        local pos_x = ProceduralRandomi(109,i*53,biome_x_min,biome_x_max)
        local pos_y = ProceduralRandomi(111,i*2.9,biome_y_min,biome_y_max)

        if pos_x >= x and pos_x <= x+w
        and pos_y >= y and pos_y <= y+h then
            -- Generate Hatched Fire Lukki Nests
            LoadPixelScene( "mods/Apotheosis/files/biome_impl/lava_excavation/fire_lukki_egg_hatched.png", "mods/Apotheosis/files/biome_impl/lava_excavation/fire_lukki_egg_hatched_visual.png", pos_x-22, pos_y-22, "mods/Apotheosis/files/biome_impl/lava_excavation/fire_lukki_egg_hatched_background.png", true )
            
            --Debug Data
            --GamePrint("Spawning nest at X: " .. pos_x .. ", Y: " .. pos_y)
            --print("Spawning nest at X: " .. pos_x .. ", Y: " .. pos_y)
        end	
    end
end

function spawn_nest_egg(x, y)
	EntityLoad("mods/Apotheosis/files/entities/props/egg_volcanic_lukki_trap.xml", x, y)
end
