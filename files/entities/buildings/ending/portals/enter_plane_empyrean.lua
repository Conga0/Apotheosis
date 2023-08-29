function do_newgame_plus()
	-- GameDoEnding2()
	-- BiomeMapLoad( "mods/nightmare/files/biome_map.lua" )

	local newgame_n = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") )
	-- print( newgame_n )
	newgame_n = newgame_n + 1
	SessionNumbersSetValue( "NEW_GAME_PLUS_COUNT", newgame_n )

	local players = EntityGetWithTag("player_unit")
	for k=1,#players
	do local v = players[k]
		EntitySetTransform(v,-940,-5600)
	end

	-- Load the actual biome map

	BiomeMapLoad_KeepPlayer( "mods/apotheosis/files/entities/buildings/ending/portals/enter_plane_empyrean_biome_map.lua", "mods/apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
	SessionNumbersSave()
	-- BiomeMapLoad( "data/biome_impl/biome_map.png" )

	-- clean up entrances to biomes
	--LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 1534, "", true, true )


	--"Entered blah blah blah" "You feel warped to another dimension" "blah blah blah"
	--local text = GameTextGetTranslatedOrNot("$new_game_for_newgame_plus")

	--GamePrintImportant( text, "" )
end


function item_pickup( entity_item, entity_who_picked, name )
	GamePrint("You feel you are no longer in the world you came from.")
	do_newgame_plus()
end
