-- default biome functions that get called if we can't find a a specific biome that works for us
CHEST_LEVEL = 0
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xff5ade45, "spawn_ice_wand" )

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
}


------------ BIG ENEMIES ------------------------------------------------------

------------ ITEMS ------------------------------------------------------------

g_lamp =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 0.2,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 0.8,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics/lantern_small.xml"
	},
}

g_items =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 1.2,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
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
}

g_ghostlamp =
{
	total_prob = 0,
	-- add skullflys after this step
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics/chain_torch_ghostly.xml"
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


-- actual functions that get called from the wang generator

function init(x, y, w, h)
	-- only load the pixel scene in one of the possible locations
	local location = ProceduralRandomi(1240,-750, 3)
	if GameHasFlagRun("apotheosis_downunder") or GameHasFlagRun("apotheosis_everything") then
		local spawn = (location == 0 and y > 8700 and y < 8900)
			or (location == 1 and y > 5100 and y < 5300)
			or (location == 2 and y > 3000 and y < 3200)
			or (location == 3 and y > 2000 and y < 2200)
	
		if spawn then
			if location == 2 then
				LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/solid_wall_ice_wand_flipped.png", "", x+30, y, "", true )
			else
				LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/solid_wall_ice_wand.png", "", x-30, y, "", true )
			end
		end
	else
		local spawn = (location == 0 and y > 3900 and y < 4100)
			or (location == 1 and y > 7600 and y < 7800)
			or (location == 2 and y > 9700 and y < 9900)
			or (location == 3 and y > 10700 and y < 10900)
	
		if spawn then
			if location == 2 then
				LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/solid_wall_ice_wand_flipped.png", "", x+30, y, "", true )
			else
				LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/solid_wall_ice_wand.png", "", x-30, y, "", true )
			end
		end
	end
	
	--print("cavern spawn location id: " .. location .. ", y: " .. y)
	--GamePrint("cavern spawn location id: " .. location .. ", y: " .. y)
end

function spawn_ice_wand(x, y)
	EntityLoad("mods/Apotheosis/files/entities/items/wands/custom/ice_wand.xml",x,y)
end

function spawn_small_enemies(x, y) end

function spawn_big_enemies(x, y) end

function spawn_items(x, y) end

function spawn_unique_enemy(x, y) end

function spawn_lamp(x, y)
	spawn(g_lamp,x,y+6,0,0)
end

function spawn_props(x, y) end

function spawn_potions( x, y ) end