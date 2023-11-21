dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

if( GlobalsGetValue("MISC_PANDORA_CHEST_RAIN") ~= "1" ) then

	local chests_pandora = EntityGetWithTag( "effectable_prop" )
	for k=1,#chests_pandora
	do local v = chests_pandora[k]
		if EntityGetName(v) == "chest_pandora" then
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
				GamePrintImportant( "$log_altar_magic_worm", "" )
	
				-- Spawn Statue ------------------------------------------------------
		
				if HasFlagPersistent( "apotheosis_card_unlocked_pandora_chest_rain" ) == false then
					--EntityLoad( "mods/Apotheosis/files/entities/props/statue_pandora_rain.xml", 4351, 2150 )
					AddFlagPersistent( "apotheosis_card_unlocked_pandora_chest_rain" )
				end
			end
			break
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

--Conga 21/11/2023:
--Double Solution problem is present here, eye can be redeemed both at the altar and somewhere else, and is very easy to interpret as being corrupt
--$200 says someone gets mad when doing this doesn't count as "purifying corruption"
if not GameHasFlagRun("heretic_near_death") then
local heretic_eyes = EntityGetInRadiusWithTag(x,y,48,"apotheosis_heretic")
for k=1,#heretic_eyes
do local v = heretic_eyes[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/heretical_eye.png" and EntityGetParent(v) == 0 then
		EntityLoad("mods/apotheosis/files/entities/special/altar_heretic_lightning_destroyer.xml",x,y)
	end
end