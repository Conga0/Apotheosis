dofile_once("data/scripts/lib/utilities.lua")

local kantele_songs = { 
	portal = { "g", "d", "e", "d" }, --Bomb
	worm = { "d", "e", "a", "d" }, --Fullhp
}

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local players = EntityGetInRadiusWithTag( x, y, 24, "player_unit" )

if ( #players > 0 ) then
	local player_id = players[1]
	
	local variables = EntityGetComponent( entity_id, "VariableStorageComponent" )
	local note = ""

	if ( variables ~= nil ) then
		for i,comp in ipairs(variables) do
			local name = ComponentGetValue( comp, "name" )
			
			if ( name == "kantele_note" ) then
				note = ComponentGetValue( comp, "value_string" )
			end
		end
	end
	
	if ( string.len(note) > 0 ) then
		local song_state = -1
		local do_portal_magic = false
		local do_worm_magic = false
		local found = false
		local currsong = 0
		local songcomp = 0
		local casting_spell = false
		
		variables = EntityGetComponent( player_id, "VariableStorageComponent" )
		
		if ( variables ~= nil ) then
			for i,comp in ipairs(variables) do
				local name = ComponentGetValue( comp, "name" )
				
				if ( name == "kantele_song" ) then
					currsong = ComponentGetValue2( comp, "value_string" )
					songcomp = comp
					break
				end
			end
			
			if ( songcomp ~= 0 ) then
				for i,comp in ipairs(variables) do
					local name = ComponentGetValue( comp, "name" )
					
					if ( name == "kantele_song_pos" ) then
						song_state = ComponentGetValueInt( comp, "value_int" )
						
						local b = kantele_songs[currsong] or {}
						
						if ( #b > 0 ) then
							local current_note_pos = song_state + 1
							local song_length = #b
							local current_note = b[current_note_pos] or "none"
							
							if ( currsong == "alchemy" ) then
								current_note = alt_notes[current_note]
							end
							
							if ( current_note_pos < song_length ) and ( note == current_note ) then
								song_state = song_state + 1
								found = true
							elseif ( current_note_pos == song_length ) and ( note == current_note ) then
								casting_spell = true
								
								if ( currsong == "portal" ) then
									do_portal_magic = true
								elseif ( currsong == "worm" ) then
									do_worm_magic = true
								end
								
								song_state = 0
								currsong = ""
							end
						end
						
						if ( found == false ) then
							currsong = ""
							song_state = 0
						end
						
						if ( #currsong == 0 ) and ( casting_spell == false ) then
							for song,d in pairs( kantele_songs ) do
								local fnote = d[1]
								
								if ( song == "alchemy" ) then
									fnote = alt_notes[fnote]
								end
								
								if ( note == fnote ) then
									found = true
									currsong = song
									song_state = 1
									ComponentSetValue2( songcomp, "value_string", currsong )
									ComponentSetValue2( comp, "value_int", 1 )
									break
								end
							end
						end
						
						ComponentSetValue2( songcomp, "value_string", currsong )
						ComponentSetValue2( comp, "value_int", song_state )
					end
				end
			end
		end
		
		if ( do_portal_magic ) then
			local already_done = EntityHasTag( player_id, "kantele_secret_01" )
			
			if ( already_done == false ) then
				EntityLoad( "data/entities/projectiles/bomb_holy.xml", x, y )
				GamePrintImportant( "$log_kantele", "$logdesc_kantele" )
				GameAddFlagRun( "kantele_secret_01" )
				EntityAddTag( player_id, "kantele_secret_01" )
			else
				GamePrint( "$log_kantele_done" )
			end
		end
		
		if ( do_worm_magic ) then
			local already_done = GameHasFlagRun("apotheosis_ocarina_secret_fullhp")
			
			if ( already_done == false ) then
				EntityLoad( "data/entities/items/pickup/heart_fullhp.xml", x, y )
				GamePrintImportant( "$log_ocarina", "$logdesc_ocarina" )
				GameAddFlagRun( "apotheosis_ocarina_secret_fullhp" )
			else
				GamePrint( "$log_ocarina_done" )
			end
		end
	end	
end		