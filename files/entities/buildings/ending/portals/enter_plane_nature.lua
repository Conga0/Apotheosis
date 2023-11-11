function do_newgame_plus()
	-- GameDoEnding2()
	-- BiomeMapLoad( "mods/nightmare/files/biome_map.lua" )

	local players = EntityGetWithTag("player_unit")
	for k=1,#players
	do local v = players[k]
		EntitySetTransform(v,746,4981)
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

	BiomeMapLoad_KeepPlayer( "mods/apotheosis/files/entities/buildings/ending/portals/enter_plane_nature_biome_map.lua", "mods/apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
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

		--Update Radars to point to the correct location inside of planes
		--Disable no longer relevent ones & change the direction of plane radar to the exit portal
		local comps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
		for k=1,#comps do
			if ComponentGetValue2(comps[k],"script_source_file") == "mods/apotheosis/files/scripts/perks/plane_radar.lua" then
				ComponentSetValue2(comps[k],"script_source_file","mods/apotheosis/files/scripts/perks/plane_radar_inside.lua")
			--elseif ComponentGetValue2(comps[k],"script_source_file") == "data/scripts/perks/radar_moon.lua" then
			--	EntitySetComponentIsEnabled(v,comps[k],false)
			end
		end

		--Disables Spatial Awareness
		local children = EntityGetAllChildren(v)
		for m=1,#children do
			local lcomp = EntityGetFirstComponentIncludingDisabled(children[m],"LuaComponent")
			if ComponentGetValue2(lcomp,"script_source_file") == "data/scripts/perks/map.lua" then
				ComponentSetValue2(lcomp,"script_source_file","")
			end
		end

		--Disable Spatial Awareness
		--[[
		local children = EntityGetAllChildren(v) or {}
		for z=1,#children do
			local comps = EntityGetComponentIncludingDisabled(children[z],"LuaComponent")
			for k=1,#comps do
				if ComponentGetValue2(comps[k],"script_source_file") == "data/scripts/perks/map.lua" then
					EntitySetComponentIsEnabled(children[z],comps[k],false)
					break
				end
			end
		end
		]]--
	end
end


function item_pickup( entity_item, entity_who_picked, name )
	--GamePrint("You feel you are no longer in the world you came from.")
	EntityKill(GetUpdatedEntityID())
	do_newgame_plus()
end
