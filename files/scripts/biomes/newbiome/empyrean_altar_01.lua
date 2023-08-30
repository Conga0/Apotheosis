CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xff2d59e7, "spawn_altar")
RegisterSpawnFunction( 0xffcf1046, "spawn_constellation_01")
RegisterSpawnFunction( 0xffff00de, "spawn_constellation_02")
RegisterSpawnFunction( 0xff00ff72, "spawn_constellation_03")
RegisterSpawnFunction( 0xffffbc06, "spawn_constellation_04")

function spawn_small_enemies( x, y ) end
function spawn_big_enemies( x, y ) end
function spawn_items( x, y ) end
function spawn_props( x, y ) end
function spawn_props2( x, y ) end
function spawn_props3( x, y ) end
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

function init( x, y, w, h )
	SetRandomSeed(444,777)
	local pw = GetParallelWorldPosition(x,y)
	if pw == 0 then
		LoadPixelScene( "mods/apotheosis/files/biome_impl/end_game_02/empyrean/01.png", "", x, y, "", true )
	end
end

function spawn_altar(x, y)
	--EntityLoad at this location
	--EntityLoad( "mods/Apotheosis/files/entities/projectiles/orb_poly_crystal_chaotic.xml", x, y )
	EntityLoad("mods/apotheosis/files/entities/buildings/ending/empyrean_altar.xml", x, y)
end

function spawn_constellation_01(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/weather_01.xml", x, y)
end

function spawn_constellation_02(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/sparks_01.xml", x, y)
end

function spawn_constellation_03(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/gears_01.xml", x, y - 20)
end

function spawn_constellation_04(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/feathers_01.xml", x, y - 30)
end
