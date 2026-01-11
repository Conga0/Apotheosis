function do_newgame_plus()

	local artifical_ngplus = tonumber(GlobalsGetValue( "apotheosis_artifical_ngplus", "0" )) + 1
	GlobalsSetValue( "apotheosis_artifical_ngplus", tostring(artifical_ngplus) )

	local players = EntityGetWithTag("player_unit") or {}
	for k=1,#players
	do local v = players[k]
		EntitySetTransform(v,-1120,-5545)

		--Hide the Plane Radar as it's no longer needed.
		local comps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
		for k=1,#comps do
			if ComponentGetValue2(comps[k],"script_source_file") == "mods/Apotheosis/files/scripts/perks/plane_radar_inside.lua" then
				EntitySetComponentIsEnabled(v,comps[k],false)
				break
			end
		end

		--[[
		--18/02/2024 Conga: Temp Fix until Nolla fixes the CompLoadOrder bug
		--09/11/2025 Conga: I'm pretty sure Nolla fixed this bug and it's safe to comment this out, I really hope so because this code breaks the WorldStateComponent for god knows what reason
		local children = EntityGetAllChildren(v) or {}
		for l=1,#children do
			local comps = EntityGetComponentIncludingDisabled(children[l],"BiomeTrackerComponent") or {}
			for i=1,#comps do
				EntitySetComponentIsEnabled(children[l],i,false)
			end
		end

		local biome_rebooter = EntityLoad("mods/Apotheosis/files/entities/special/biome_rebooter.xml",-5910,2421)
		EntityAddChild(v,biome_rebooter)
		]]--
	end

	local targets = EntityGetWithTag("poopstone")
	for r=1,#targets
	do local v = targets[r]
	    if (EntityGetName(v) == "$item_apotheosis_stone_radar_name") then
		--Disable Guiding Stone pulse as it has served its purpose in life
		local comps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
		for k=1,#comps do
			if comps[k] ~= nil and ComponentGetValue2(comps[k],"script_source_file") == "mods/Apotheosis/files/scripts/items/radar_stone_ping_visual.lua" then
				EntitySetComponentIsEnabled(v,comps[k],false)
				break
			end
		end
	    end
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

	BiomeMapLoad_KeepPlayer( "mods/Apotheosis/files/entities/buildings/ending/portals/enter_plane_empyrean_biome_map.lua", "mods/Apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
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
