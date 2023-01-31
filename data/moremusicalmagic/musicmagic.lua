function get_player()
  return (EntityGetWithTag( "player_unit" ) or {})[1]
end
entity_id = GetUpdatedEntityID();
player_id = get_player();

function SongEntityLoad( sInstrument, sFlag, sFTimeWait, sEnt, sEntX, sEntY, sFTimeKill )
  gFlag = sInstrument..sFlag
  local InstLogName = "$log_ocarina"
  local InstLogDesc = "$logdesc_ocarina"
  local InstLogDone = "$log_ocarina_done"
  if ( sInstrument=="kantele" ) then
    InstLogName = "$log_kantele"
    InstLogDesc = "$logdesc_kantele"
    InstLogDone = "$log_kantele_done"
  end

  local newgame_gFlag = "LAST_NG_PLUS_"..gFlag
  local newgame_plus_c = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") )
  local newgame_plus_c_last = tonumber( GlobalsGetValue(newgame_gFlag) )
  local lastFlagFrameNum = tonumber( GlobalsGetValue( gFlag, 0 ) ) -- 0 = first time used in run
  local newgame = false
  if( newgame_plus_c_last ~= nil ) and ( newgame_plus_c ~= nil ) and ( newgame_plus_c_last ~= newgame_plus_c ) then
    newgame = true -- bypasses for when going to NG+
    lastFlagFrameNum = -1
  end

  local shouldLoad = 0
  if( lastFlagFrameNum <= 0 ) or ( sFTimeWait < GameGetFrameNum() - lastFlagFrameNum ) then
    shouldLoad = 1
  end
  if( ( sFTimeWait == -1 ) and EntityHasTag( player_id, gFlag ) ) -- post1.0, only usable once per run
  or( ( sFTimeWait == -2 ) and not newgame and GameHasFlagRun( gFlag ) ) -- pre1.0, resets every NG+, no longer functional
  then
    shouldLoad = 0 ;--GamePrint("blocked")
  end
  -- GamePrint("stat: "..tostring(sFTimeWait).."  "..tostring(GameGetFrameNum()).."  "..tostring(lastFlagFrameNum).."  "..tostring(EntityHasTag( player_id, gFlag )).."  "..tostring(newgame).."  "..tostring(GameHasFlagRun( gFlag )))
  if( shouldLoad == 1 ) then
    if( sEnt ~= 0 ) then
      local SongEntity = EntityLoad( sEnt, sEntX, sEntY )
      if ( 0 < sFTimeKill ) then
        EntityAddComponent( SongEntity, "LifetimeComponent", {
          lifetime=tostring( sFTimeKill )
        } )
      end
    end
    if( GameHasFlagRun( gFlag ) == false ) then
      GamePrintImportant( InstLogName, InstLogDesc )
      GameAddFlagRun( gFlag )
      EntityAddTag( player_id, gFlag )
    else
      GamePrint( InstLogName )
      GamePrint( InstLogDesc )
    end
    GlobalsSetValue( newgame_gFlag, tostring(newgame_plus_c) )
    GlobalsSetValue( gFlag, tostring(GameGetFrameNum()) )
  else
    GamePrint( InstLogDone )
  end
end

function SongNotePlayed()
  local song = nil
  local instrument = nil
  local instrument_songs = nil
  local instrument_funcs = nil
  local note = nil
  local variables = EntityGetComponent( entity_id, "VariableStorageComponent" )
  if ( variables ~= nil ) then
    for i,comp in ipairs(variables) do
      if ( ComponentGetValue( comp, "name" ) == "ocarina_note" ) then
        song = "ocarina_song"
        instrument_songs = ocarina_songs
        instrument_funcs = ocarina_funcs
        note = ComponentGetValue( comp, "value_string" )
      end
      if ( ComponentGetValue( comp, "name" ) == "kantele_note" ) then
        song = "kantele_song"
        instrument_songs = kantele_songs
        instrument_funcs = kantele_funcs
        note = ComponentGetValue( comp, "value_string" )
      end
    end
  end

  for song,b in pairs( instrument_songs ) do
    if( song == "alchemy" ) then
      for i=0,#b do
        b[i]=alt_notes[b[i]]
      end
    end
  end

  if ( string.len(note) > 0 ) then
    variables = EntityGetComponent( player_id, "VariableStorageComponent" )
    if ( variables ~= nil ) then
      for i,comp in ipairs(variables) do
        if ( ComponentGetValue( comp, "name" ) == song ) then
          local notesstr = ComponentGetValue( comp, "value_string" ) -- player oca storage string
          local matches = {}
          if ( notesstr ~= "" ) then -- string to table if not empty
            for match in string.gmatch( notesstr, "[^,]+" ) do
              table.insert( matches, match )
            end
          end
          -- GamePrint("loaded: "..notesstr.."  new: "..note)
          table.insert(matches, note) --new note
          local maxlen = 0
          for song,b in pairs( instrument_songs ) do
            if (#b > maxlen) then --get longest song length
              maxlen = #b
            end
            if (#b <= #matches) then
              local notec = #b-1
              for i=0,notec do --check notes in reverse
                if (b[#b-i] == matches[#matches-i]) then
                  if (i == notec) then
                    ComponentSetValue( comp, "value_string", "" )
                    -- GamePrint( "Song: "..song)
                    instrument_funcs[song]()
                    return
                  end
                else
                  break
                end
              end
            end
          end
          if (maxlen <= #matches) then
            local count = 1+#matches-maxlen
            for i=1,count do --remove oldest elements that do not find max song length
              table.remove(matches, i)
            end
          end
          notesstr = table.concat(matches,",")
          ComponentSetValue( comp, "value_string", notesstr )
        end
      end
    end
  end
end

ocarina_songs = {}
ocarina_funcs = {}

kantele_songs = {}
kantele_funcs = {}