dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")

function death( )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform( entity_id )
	local p = EntityGetWithTag( "player_unit" )
	
	local doit = false
	
	for i,v in ipairs( p ) do
		local c = EntityGetAllChildren( v )
		
		if ( c ~= nil ) then
			for a,b in ipairs( c ) do
				if EntityHasTag( b, "essence_effect" ) then
					EntityRemoveFromParent( b )
					EntityKill( b )
					doit = true
				end
			end
		end
	end
	
	local key1 = "ESSENCE_FUNGUS_PICKUP_COUNT"
	
	local pick1 = tonumber( GlobalsGetValue( key1, "0" ) )
	
	print( tostring( pick1 ) .. ", " )
	
	local loadlist = {}
	
	if ( pick1 > 0 ) then
		for i=1,pick1 do
			table.insert( loadlist, "mods/Apotheosis/files/entities/items/pickups/stone_fungus.xml" )
		end
		
		GlobalsSetValue( key1, "0" )
	end
	
	for i,v in ipairs( loadlist ) do
		EntityLoad( v, x, y - (i-1) * 12 )
	end
	
	GameRemoveFlagRun( "apotheosis_card_unlocked_essence_fungus" )
	
	if doit then
		EntityLoad( "data/entities/particles/image_emitters/perk_effect.xml", x, y )
		GamePrintImportant( "$log_curse_secret", "$logdesc_curse_fade" )
		GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )
	end
end