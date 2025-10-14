
spellbook_spells["dispell"]  = { "d", "i", "s", "p", "e", "l", "l" }
--spellbook_spells["dispell"]  = { "a", "a", "a", "a", }
spellbook_spells["night"]  = { "n", "i", "g", "h", "t" }
spellbook_spells["light"] = { "l", "i", "g", "h", "t" }
spellbook_spells["solbind"] = { "s", "o", "l", "b", "i", "n", "d" }

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
    GamePrintImportant("$log_apotheosis_spell_night_name","$log_apotheosis_spell_night_desc","data/ui_gfx/decorations_biome_modifier/ominous.png")
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
    GamePrintImportant("$log_apotheosis_spell_light_name","$log_apotheosis_spell_light_desc","data/ui_gfx/decorations_biome_modifier/sunlight.png")
  end

  GlobalsSetValue("apotheosis_spellbook_light","1")
  GlobalsSetValue("apotheosis_spellbook_night","0")
  add_script(player_id,"mods/Apotheosis/files/scripts/magic/spellbook/outcome_time_control.lua",5,-1)
end

spellbook_funcs["solbind"]  = function()
  local pos_x, pos_y = EntityGetTransform(entity_id)
  local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 128, "mortal") or {}
  local target_whisp = 0
  local shortest_distance = 9999
  for k=1,#targets do
    local genome_comp = EntityGetFirstComponentIncludingDisabled(targets[k],"GenomeDataComponent")
    if genome_comp ~= 0 and genome_comp ~= nil then
      if ComponentGetValue2(genome_comp,"herd_id") == StringToHerdId( "ghost_whisp" ) then
        local distance = getDistanceFromTarget(entity_id,targets[k])
        if distance < shortest_distance then
          shortest_distance = distance
          target_whisp = targets[k]
        end
      end
    end
  end

  if target_whisp ~= 0 then
    --Bind whisp

    local targ_x, targ_y = EntityGetTransform(target_whisp)
    local child = EntityLoad("mods/Apotheosis/files/entities/animators/solbind_fx.xml", targ_x, targ_y)
    local comp = EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent")
    ComponentSetValue2(comp, "mExPosition", pos_x, pos_y)

    local bind = EntityLoad("mods/Apotheosis/files/entities/misc/helpers/solbind_bind.xml",pos_x,pos_y)
    EntityAddChild(target_whisp,bind)

    GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/create", pos_x, pos_y )
    GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y )
  else
    --No whisp found to bind
    GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/game_effect_end", pos_x, pos_y )
    local proj_id = EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/fae_lantern_projectile_nodamage.xml", pos_x, pos_y)
    SetRandomSeed(pos_x,pos_y)
    GameShootProjectile( player_id, pos_x, pos_y, pos_x + Random(-50,50), pos_y + Random(-50,50), proj_id )
  end
end