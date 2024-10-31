CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

function load_random_background_sprite_with_entity( what, x, y, x2, y2 )
    if( what.total_prob == 0 ) then
        init_total_prob( what, x )
    end

    local r = ProceduralRandom(x,y) * what.total_prob
    for i,v in ipairs(what) do
        if( v.prob ~= nil ) then
            if( v.prob ~= 0 and r <= v.prob ) then
                if( is_empty( v.sprite_file) ) then
                    -- loading empty sprite, don't do anything
                    return
                else
                    -- LoadBackgroundSprite( string background_file, x, y, int background_z_index = 40 )
                    local z_index = 40
                    if( v.z_index ) then z_index = v.z_index end

                    LoadBackgroundSprite( v.sprite_file, x, y, z_index, true )
                    EntityLoad(v.entity_file, x2, y2)
                    return
                end
            else
                r = r - v.prob
            end
        end
    end
end

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffff1967, "spawn_stone" )
RegisterSpawnFunction( 0xffff5900, "spawn_trigger" )
RegisterSpawnFunction( 0xffaf1717, "load_background_window" )
RegisterSpawnFunction( 0xffa61414, "load_background_window_round" )
RegisterSpawnFunction( 0xff9d1212, "load_background_window_small" )
RegisterSpawnFunction( 0xff4cacab, "spawn_forge_check" )
RegisterSpawnFunction( 0xff4e3322, "spawn_room1_check" )
RegisterSpawnFunction( 0xff442a1a, "spawn_room2_check" )

function spawn_small_enemies( x, y ) end
function spawn_big_enemies( x, y ) end
function spawn_items( x, y ) end
function spawn_props( x, y ) end
function spawn_props2( x, y ) end
function spawn_lamp( x, y ) end
function load_pixel_scene( x, y ) end
function load_pixel_scene2( x, y ) end
function spawn_unique_enemy( x, y ) end
function spawn_unique_enemy2( x, y ) end
function spawn_unique_enemy3( x, y ) end
function spawn_ghostlamp( x, y ) end
function spawn_candles( x, y ) end
function spawn_potions( x, y ) end
function spawn_wands( x, y ) end

g_background_windows =
{
	total_prob = 0,
	{
		prob   			= 0.0,
		sprite_file		= "",
	},
	{
		prob   			= 1.0,
		sprite_file		= "mods/apotheosis/files/biome_impl/evil_temple/alcove_window_background.png",
		entity_file 	= "mods/apotheosis/files/entities/buildings/alcove_window_glow_less.xml"
	},
}

g_background_windows_round =
{
	total_prob = 0,
	{
		prob   			= 0.0,
		sprite_file		= "",
	},
	{
		prob   			= 1.0,
		sprite_file		= "mods/apotheosis/files/biome_impl/evil_temple/alcove_window_round_background.png",
		entity_file 	= "mods/apotheosis/files/entities/buildings/alcove_window_glow_small.xml"
	},
}

g_background_windows_small =
{
	total_prob = 0,
	{
		prob   			= 0.0,
		sprite_file		= "",
	},
	{
		prob   			= 1.0,
		sprite_file		= "mods/apotheosis/files/biome_impl/evil_temple/alcove_window_small_background.png",
		entity_file 	= "mods/apotheosis/files/entities/buildings/alcove_window_glow_small_less.xml"
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
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= -5,
		entity 	= "mods/Apotheosis/files/entities/items/pickups/potion_corrupted.xml"
	},
}

function init( x, y, w, h )
end

function spawn_stone(x, y)
	local parallel = GetParallelWorldPosition(x, y)
	if parallel == 0 and GameHasFlagRun("apotheosis_flesh_boss_stone_initiated") == false and GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") == false and GameHasFlagRun("apotheosis_flesh_boss_stone_converted") == false then
		EntityLoad( "mods/Apotheosis/files/entities/items/pickups/stone_heretic.xml", x, y )
		EntityLoad( "data/entities/misc/music_energy_000.xml", x, y - 10 )
	end
end

function load_background_window( x, y )
	load_random_background_sprite_with_entity( g_background_windows, x - 90 + 5, y - 57.5, x + 5, y )
end

function load_background_window_round( x, y )
	load_random_background_sprite_with_entity( g_background_windows_round, x - 26, y - 26, x, y )
end

function load_background_window_small( x, y )
	load_random_background_sprite_with_entity( g_background_windows_small, x - 18, y - 28, x, y )
end

function spawn_trigger(x, y)
	EntityLoad( "mods/apotheosis/files/entities/buildings/flesh_boss_summon_den.xml", x, y )
end

function spawn_props3(x, y)
	spawn(g_props3,x,y,0,0)
end

function spawn_forge_check(x, y)
	EntityLoad( "mods/apotheosis/files/entities/buildings/evil_forge_item_check.xml", x, y )
end

function spawn_room1_check(x, y)
	EntityLoad( "mods/apotheosis/files/entities/buildings/evil_room1_check.xml", x, y )
end

function spawn_room2_check(x, y)
	EntityLoad( "mods/apotheosis/files/entities/buildings/evil_room2_check.xml", x, y )
end