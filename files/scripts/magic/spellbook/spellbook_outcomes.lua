
spellbook_spells["dispell"]  = { "d", "i", "s", "p", "e", "l", "l" }
--spellbook_spells["dispell"]  = { "a", "a", "a", "a", }
spellbook_spells["night"]  = { "n", "i", "g", "h", "t" }
spellbook_spells["light"] = { "l", "i", "g", "h", "t" }

function add_script(entity_id,filepath,every_n_frame,execute_times)
  local lua_comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent","spellbook_spell") or {}
  local found = false
  for k=1,#lua_comps do
    if ComponentGetValue2(lua_comps[k],"script_source_file") == filepath then
      found = true
      break
    end
  end

  if found == false then
        --Enables the time manipulation script
        EntityAddComponent2(
            entity_id,
            "LuaComponent",
            {
                _tags="spellbook_spell",
                execute_on_added = false,
                script_source_file = filepath,
                execute_every_n_frame = every_n_frame,
                remove_after_executed = false,
                execute_times=execute_times
            }
        )
    end
end

spellbook_funcs["dispell"]  = function()
  local x, y = EntityGetTransform( entity_id )
  GlobalsSetValue("apotheosis_spellbook_dispell","1")
  local lua_comps = EntityGetComponentIncludingDisabled(player_id,"LuaComponent","spellbook_spell") or {}
  local found = false
  for k=1,#lua_comps do
    EntityRemoveComponent( player_id, lua_comps[k] )
  end
  local globals_to_remove = {"night","light"}
  for k=1,#globals_to_remove do
    GlobalsSetValue("apotheosis_spellbook_" .. globals_to_remove[k],"0")
  end
  --AddFlagPersistent("apotheosis_card_unlocked_musical_magic_played")
end

spellbook_funcs["night"]  = function()
  if GlobalsGetValue("apotheosis_spellbook_night","0") == "0" then
    --play thematic spell casting flair
    local pos_x, pos_y = EntityGetTransform(entity_id)
		GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb/create", pos_x, pos_y )
    GamePrintImportant("An eternal night befalls the world","The stars have come out to play","data/ui_gfx/decorations_biome_modifier/ominous.png")
  end

  GlobalsSetValue("apotheosis_spellbook_night","1")
  GlobalsSetValue("apotheosis_spellbook_light","0")
  add_script(player_id,"mods/Apotheosis/files/scripts/magic/spellbook/outcome_time_control.lua",5,-1)
end

spellbook_funcs["light"]  = function()
  if GlobalsGetValue("apotheosis_spellbook_light","0") == "0" then
    --play thematic spell casting flair
    local pos_x, pos_y = EntityGetTransform(entity_id)
		GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb/create", pos_x, pos_y )
    GamePrintImportant("The world is bathed in eternal sunlight","It's radiance is beautiful","data/ui_gfx/decorations_biome_modifier/sunlight.png")
  end

  GlobalsSetValue("apotheosis_spellbook_light","1")
  GlobalsSetValue("apotheosis_spellbook_night","0")
  add_script(player_id,"mods/Apotheosis/files/scripts/magic/spellbook/outcome_time_control.lua",5,-1)
end