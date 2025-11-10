function do_newgame_plus()

	local players = EntityGetWithTag("player_unit")
	for k=1,#players
	do local v = players[k]
		local pos_x,pos_y = EntityGetTransform(v)
		EntitySetTransform(v,-5910,2421)

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

	BiomeMapLoad_KeepPlayer( "mods/Apotheosis/files/entities/buildings/ending/portals/enter_plane_magic_biome_map.lua", "mods/Apotheosis/files/scripts/newgame/_pixel_scenes_empty.xml" )
	SessionNumbersSave()
end


function item_pickup( entity_item, entity_who_picked, name )
	--GamePrint("You feel you are no longer in the world you came from.")
	EntityKill(GetUpdatedEntityID())
	do_newgame_plus()
end
