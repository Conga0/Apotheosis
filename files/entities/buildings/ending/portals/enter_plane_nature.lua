function do_newgame_plus()
	-- GameDoEnding2()
	-- BiomeMapLoad( "mods/nightmare/files/biome_map.lua" )

	local newgame_n = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") )
	-- print( newgame_n )
	newgame_n = newgame_n + 1
	SessionNumbersSetValue( "NEW_GAME_PLUS_COUNT", newgame_n )

	local players = EntityGetWithTag("player_unit") or {}
	for k=1,#players
	do local v = players[k]
		EntitySetTransform(v,746,4981 - (512 * 7))

		--18/02/2024 Conga: Temp Fix until Nolla fixes the CompLoadOrder bug
		local children = EntityGetAllChildren(v) or {}
		for l=1,#children do
			local comps = EntityGetComponentIncludingDisabled(children[l],"BiomeTrackerComponent") or {}
			for i=1,#comps do
				EntitySetComponentIsEnabled(children[l],i,false)
			end
		end

		local biome_rebooter = EntityLoad("mods/Apotheosis/files/entities/special/biome_rebooter.xml",746,4981 - (512 * 7))
		EntityAddChild(v,biome_rebooter)
	end

	--EntityLoad("mods/Apotheosis/files/entities/buildings/ending/portals/saviour_portal_nature.xml",0,0)

	--Reset RGB portal locations
	GlobalsSetValue( "apotheosis_markerportal_red_x", "0" )
	GlobalsSetValue( "apotheosis_markerportal_red_y", "0" )
	GlobalsSetValue( "apotheosis_markerportal_green_x", "0" )
	GlobalsSetValue( "apotheosis_markerportal_green_y", "0" )
	GlobalsSetValue( "apotheosis_markerportal_blue_x", "0" )
	GlobalsSetValue( "apotheosis_markerportal_blue_y", "0" )

	--Makes it so Heretic can no longer teleport away to his now non-existant house, he should've seen the stone anyway by now
	GameAddFlagRun("apotheosis_heretalk_cynical")

	--Planes check for Heretic to lock off certain dialogue
	GameAddFlagRun("apotheosis_planes_entered")

	--Deque & Fadeout current music so the new biome music can take over
    GameTriggerMusicFadeOutAndDequeueAll()

	-- Load the actual biome map

	BiomeMapLoad_KeepPlayer( "mods/Apotheosis/files/entities/buildings/ending/portals/enter_plane_nature_biome_map.lua", "mods/Apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
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

				ComponentObjectSetValue( damagemodel, "damage_multipliers", "curse", curse )

			end
		end

		--Update Radars to point to the correct location inside of planes
		--Disable no longer relevent ones & change the direction of plane radar to the exit portal
		local comps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
		for k=1,#comps do
			if ComponentGetValue2(comps[k],"script_source_file") == "mods/Apotheosis/files/scripts/perks/plane_radar.lua" then
				ComponentSetValue2(comps[k],"script_source_file","mods/Apotheosis/files/scripts/perks/plane_radar_inside.lua")
			--elseif ComponentGetValue2(comps[k],"script_source_file") == "data/scripts/perks/radar_moon.lua" then
			--	EntitySetComponentIsEnabled(v,comps[k],false)
			end
		end

		--Disables Spatial Awareness
		local children = EntityGetAllChildren(v)
		for m=1,#children do
			local lcomp = EntityGetFirstComponentIncludingDisabled(children[m],"LuaComponent")
			if lcomp ~= nil and ComponentGetValue2(lcomp,"script_source_file") == "data/scripts/perks/map.lua" then
				ComponentSetValue2(lcomp,"script_source_file","")
			end
		end

		--Disable Spatial Awareness
		--[[
		local children = EntityGetAllChildren(v) or {}
		for z=1,#children do
			local comps = EntityGetComponentIncludingDisabled(children[z],"LuaComponent")
			for k=1,#comps do
				if comps[k] ~= nil and ComponentGetValue2(comps[k],"script_source_file") == "data/scripts/perks/map.lua" then
					EntitySetComponentIsEnabled(children[z],comps[k],false)
					break
				end
			end
		end
		]]--
	end

	local targets = EntityGetWithTag("poopstone")
	for r=1,#targets
	do local v = targets[r]
	    if (EntityGetName(v) == "$item_apotheosis_stone_radar_name") then
		--Update Radars to point to the correct location inside of planes
		--Disable no longer relevent ones & change the direction of plane radar to the exit portal
		local comps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
		for k=1,#comps do
			if comps[k] ~= nil and ComponentGetValue2(comps[k],"script_source_file") == "mods/Apotheosis/files/scripts/items/radar_stone_ping.lua" then
				ComponentSetValue2(comps[k],"script_source_file","mods/Apotheosis/files/scripts/items/radar_stone_ping_inside.lua")
			end
		end
	    end
	end

	--Heretic's yell echoes through the planes when you first enter
	--This was originally a bug since the guiding stone is destroyed and reconstructed each time you travel to a new world
	--I thought it was cool though so here it is here :p
	if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
	    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster_distant", pos_x, pos_y );
	    GameScreenshake( 100 )
	end
end

GamePrint("$building_portal_use")
do_newgame_plus()
EntityKill(GetUpdatedEntityID())
