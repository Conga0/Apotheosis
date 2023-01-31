ocarina_songs["portal"]  = { "a", "f", "d", "e", "a2" }
ocarina_songs["bomb"]    = { "f", "c", "d", "c" }
ocarina_songs["worm"]    = { "gsharp", "f", "e", "b", "d" }
ocarina_songs["alchemy"] = { "a2", "d", "dis", "e", "a" }

kantele_songs["portal"]  = { "a", "dis", "e", "g" }
kantele_songs["bomb"]    = { "g", "d", "e", "d" }
kantele_songs["worm"]    = { "d", "e", "a", "e", "dis" }
kantele_songs["alchemy"] = { "f", "g", "f", "a2", "c" }



ocarina_funcs["portal"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_00", -1, "data/entities/buildings/mystery_teleport_back.xml", x, y - 48, 0 )
end

ocarina_funcs["bomb"]    = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_01", -1, "data/entities/projectiles/bomb_holy.xml", x, y, 0 )
end

ocarina_funcs["worm"]    = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "ocarina", "_secret_02", -1, "data/entities/animals/worm_big.xml", x, y - 64, 0 )
end

kantele_funcs["portal"]  = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_00", -1, "data/entities/buildings/mystery_teleport_back.xml", x, y - 48, 0 )
end

kantele_funcs["bomb"]    = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_01", -1, "data/entities/projectiles/bomb_holy.xml", x, y, 0 )
end

kantele_funcs["worm"]    = function()
  local x, y = EntityGetTransform( entity_id )
  SongEntityLoad( "kantele", "_secret_02", -1, "data/entities/animals/worm_big.xml", x, y - 64, 0 )
end

ocarina_funcs["alchemy"] = function()
  -- slightly modified startup
  local already_done = GameHasFlagRun( "alchemy_ocarina" )
  local x, y = EntityGetTransform( player_id )
  local keys = EntityGetInRadiusWithTag( x, y, 48, "alchemist_key" )

  if ( already_done == false ) and ( #keys > 0 ) then
    for i,key_id in ipairs( keys ) do
      local variablestorages = EntityGetComponent( key_id, "VariableStorageComponent" )
      --copy starts here
      if ( variablestorages ~= nil ) then
        for j,storage_id in ipairs(variablestorages) do
          local var_name = ComponentGetValue( storage_id, "name" )
          if ( var_name == "status" ) then
            local status = ComponentGetValue( storage_id, "value_int" )
            
            status = status + 1
            
            ComponentSetValue2( storage_id, "value_int", status )
            GameAddFlagRun( "alchemy_ocarina" )
            EntityAddTag( key_id, "alchemy_ocarina" )
            
            print( tostring(status) )
            
            if ( status == 1 ) then
              GamePrintImportant( "$log_alchemist_key_first", "$logdesc_alchemist_key_first" )
              EntitySetComponentsWithTagEnabled( key_id, "first", true )
              EntityLoadToEntity( "data/entities/animals/boss_alchemist/key_particles_first.xml", key_id )
              
              edit_component( key_id, "ItemComponent", function(comp,vars)
                ComponentSetValue2( comp, "ui_description", "$itemdesc_key_1")
              end)
            elseif ( status == 2 ) then
              GamePrintImportant( "$log_alchemist_key_second", "$logdesc_alchemist_key_second" )
              EntitySetComponentsWithTagEnabled( key_id, "second", false )
              EntityLoadToEntity( "data/entities/animals/boss_alchemist/key_particles_second.xml", key_id )
              
              edit_component( key_id, "ItemComponent", function(comp,vars)
                ComponentSetValue2( comp, "ui_description", "$itemdesc_key_2")
              end)
            end
          end
        end
      end
    end
  else
    GamePrint( "$log_alchemist_key_invalid" )
  end
  --copy ends here
end

kantele_funcs["alchemy"] = function()
  -- slightly modified startup
  local already_done = GameHasFlagRun( "alchemy_kantele" )
  local x, y = EntityGetTransform( player_id )
  local keys = EntityGetInRadiusWithTag( x, y, 48, "alchemist_key" )

  if ( already_done == false ) and ( #keys > 0 ) then
    for i,key_id in ipairs( keys ) do
      local variablestorages = EntityGetComponent( key_id, "VariableStorageComponent" )
      --copy starts here
      if ( variablestorages ~= nil ) then
        for j,storage_id in ipairs(variablestorages) do
          local var_name = ComponentGetValue( storage_id, "name" )
          if ( var_name == "status" ) then
            local status = ComponentGetValue( storage_id, "value_int" )
            
            status = status + 1
            
            ComponentSetValue2( storage_id, "value_int", status )
            GameAddFlagRun( "alchemy_kantele" )
            EntityAddTag( key_id, "alchemy_kantele" )
            
            print( tostring(status) )
            
            if ( status == 1 ) then
              GamePrintImportant( "$log_alchemist_key_first", "$logdesc_alchemist_key_first" )
              EntitySetComponentsWithTagEnabled( key_id, "first", true )
              EntityLoadToEntity( "data/entities/animals/boss_alchemist/key_particles_first.xml", key_id )
              
              edit_component( key_id, "ItemComponent", function(comp,vars)
                ComponentSetValue2( comp, "ui_description", "$itemdesc_key_1")
              end)
            elseif ( status == 2 ) then
              GamePrintImportant( "$log_alchemist_key_second", "$logdesc_alchemist_key_second" )
              EntitySetComponentsWithTagEnabled( key_id, "second", false )
              EntityLoadToEntity( "data/entities/animals/boss_alchemist/key_particles_second.xml", key_id )
              
              edit_component( key_id, "ItemComponent", function(comp,vars)
                ComponentSetValue2( comp, "ui_description", "$itemdesc_key_2")
              end)
            end
          end
        end
      end
    end
  else
    GamePrint( "$log_alchemist_key_invalid" )
  end
  --copy ends here
end