function do_newgame_plus()
	-- GameDoEnding2()
	-- BiomeMapLoad( "mods/nightmare/files/biome_map.lua" )

	local newgame_n = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") )
	-- print( newgame_n )
	newgame_n = newgame_n + 1
	SessionNumbersSetValue( "NEW_GAME_PLUS_COUNT", newgame_n )

	-- Load the actual biome map

	BiomeMapLoad_KeepPlayer( "mods/apotheosis/files/entities/buildings/ending/portals/enter_plane_technology_biome_map.lua", "mods/apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
	SessionNumbersSave()
	-- BiomeMapLoad( "data/biome_impl/biome_map.png" )

	-- clean up entrances to biomes
	--LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 1534, "", true, true )


	--"Entered blah blah blah" "You feel warped to another dimension" "blah blah blah"
	--local text = GameTextGetTranslatedOrNot("$new_game_for_newgame_plus")

	--GamePrintImportant( text, "" )



	--Increase curse (& suffocation by relation) damage to match with the player's new HP stats

	local targets = EntityGetWithTag("player_unit")
	for k=1,#targets
	do local v = targets[k]
		local damagemodels = EntityGetComponent( v, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				
				local curse = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "curse" ) )

				curse = curse + 1

				ComponentObjectSetValue( damagemodel, "damage_multipliers", "curse", tostring(curse) )

			end
		end
	end
end


function item_pickup( entity_item, entity_who_picked, name )
	GamePrint("You feel you are no longer in the world you came from.")
	do_newgame_plus()
end
