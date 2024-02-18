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
		EntitySetTransform(v,-1120,-5545)

		--Hide the Plane Radar as it's no longer needed.
		local comps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
		for k=1,#comps do
			if ComponentGetValue2(comps[k],"script_source_file") == "mods/apotheosis/files/scripts/perks/plane_radar_inside.lua" then
				EntitySetComponentIsEnabled(v,comps[k],false)
				break
			end
		end

		--18/02/2024 Conga: Temp Fix until Nolla fixes the CompLoadOrder bug
		local children = EntityGetAllChildren(v) or {}
		for l=1,#children do
			local comps = EntityGetComponentIncludingDisabled(children[l],"BiomeTrackerComponent") or {}
			for i=1,#comps do
				EntitySetComponentIsEnabled(children[l],i,false)
			end
		end

		local biome_rebooter = EntityLoad("mods/apotheosis/files/entities/special/biome_rebooter.xml",-1120,-5545)
		EntityAddChild(v,biome_rebooter)
	end

	--Reset RGB portal locations
	GlobalsSetValue( "apotheosis_markerportal_red_x", "0" )
	GlobalsSetValue( "apotheosis_markerportal_red_y", "0" )
	GlobalsSetValue( "apotheosis_markerportal_green_x", "0" )
	GlobalsSetValue( "apotheosis_markerportal_green_y", "0" )
	GlobalsSetValue( "apotheosis_markerportal_blue_x", "0" )
	GlobalsSetValue( "apotheosis_markerportal_blue_y", "0" )

	--Deque & Fadeout current music so the new biome music can take over
    GameTriggerMusicFadeOutAndDequeueAll()

	-- Load the actual biome map

	BiomeMapLoad_KeepPlayer( "mods/apotheosis/files/entities/buildings/ending/portals/enter_plane_empyrean_biome_map.lua", "mods/apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
	SessionNumbersSave()
	-- BiomeMapLoad( "data/biome_impl/biome_map.png" )

	-- clean up entrances to biomes
	--LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 1534, "", true, true )


	--"Entered blah blah blah" "You feel warped to another dimension" "blah blah blah"
	--local text = GameTextGetTranslatedOrNot("$new_game_for_newgame_plus")

	--GamePrintImportant( text, "" )

    local worldEntity = GameGetWorldStateEntity()
    local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")

    --Set weather up to be nice
    ComponentSetValue2(comp,"intro_weather",true)
    ComponentSetValue2(comp,"time",0.55)
    ComponentSetValue2(comp,"time_dt",0.5)
    ComponentSetValue2(comp,"fog",0)
    ComponentSetValue2(comp,"fog_target",0)
    ComponentSetValue2(comp,"rain",0)

end


function item_pickup( entity_item, entity_who_picked, name )
	--GamePrint("You feel you are no longer in the world you came from.")
	EntityKill(GetUpdatedEntityID())
	do_newgame_plus()
end
