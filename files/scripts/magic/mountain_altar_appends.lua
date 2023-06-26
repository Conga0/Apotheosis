dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

if( GlobalsGetValue("MISC_PANDORA_CHEST_RAIN") ~= "1" ) then

	local chests_pandora = EntityGetWithTag( "chest_pandora" )
	if ( #chests_pandora > 0 ) then
		local collected = false
		local players = EntityGetWithTag( "player_unit" )
		--GamePrint("Pandora's Chest Detected")
		
		if ( #players > 0 ) then
			local player_id = players[1]
			local px, py = EntityGetTransform( player_id )
			--GamePrint("Player Chest Detected")
			
			for i,chest_id in ipairs(chests_pandora) do
				local cx, cy = EntityGetTransform( chest_id )
				
				local distance = math.abs( x - cx ) + math.abs( y - cy )
			
				if ( distance < 48 ) then
					local eid = EntityLoad("mods/Apotheosis/files/entities/misc/chest_rain_pandora.xml", px, py)
					EntityAddChild( player_id, eid )
					EntityLoad("data/entities/particles/image_emitters/altar_tablet_curse_symbol.xml", cx, cy)
					--EntityLoad("data/entities/projectiles/deck/meteor_rain.xml", cx, cy)
					collected = true
					EntityKill( chest_id )
				end
			end
		end
		
		if collected then
			GlobalsSetValue("MISC_PANDORA_CHEST_RAIN", "1" )
			GamePrintImportant( "$log_altar_magic_monster", "" )

			-- Spawn Statue ------------------------------------------------------
	
			if (ModIsEnabled("nightmare") or ModIsEnabled("purgatory")) and HasFlagPersistent( "apotheosis_misc_pandora_chest_rain_goldmode" ) == false then
				EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_pandora_rain.xml", 4351, 2150 )
				AddFlagPersistent( "apotheosis_misc_pandora_chest_rain_goldmode" )
				AddFlagPersistent( "apotheosis_misc_pandora_chest_rain" )
			elseif HasFlagPersistent( "apotheosis_misc_pandora_chest_rain" ) == false then
				EntityLoad( "mods/Apotheosis/files/entities/props/statue_pandora_rain.xml", 4351, 2150 )
				AddFlagPersistent( "apotheosis_misc_pandora_chest_rain" )
			end
		end
	end
end

local heretic_stones = EntityGetInRadiusWithTag(x,y,48,"poopstone")
for k=1,#heretic_stones
do local v = heretic_stones[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
		EntityLoad("mods/apotheosis/files/entities/special/altar_radar_lightning_spawner.xml",x,y)
	end
end