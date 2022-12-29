dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local year, month, day, hour = GameGetDateAndTimeLocal()
	EntityLoad( "data/entities/particles/image_emitters/magical_symbol_fast_toxic.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/greed_curse/create", pos_x, pos_y)
	

	if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
		local eid = EntityLoad( "data/entities/animals/gold_bosses/toxic_worm/boss_toxic_worm.xml", pos_x, pos_y )
		EntityAddComponent( eid, "LuaComponent", 
		{ 
			script_death = "data/entities/animals/gold_bosses/toxic_worm/boss_toxic_worm_death.lua",
			execute_every_n_frame = "-1",
		} )
	else
		local eid = EntityLoad( "data/entities/animals/boss_toxic_worm/boss_toxic_worm.xml", pos_x, pos_y )
		EntityAddComponent( eid, "LuaComponent", 
		{ 
			script_death = "data/entities/animals/boss_toxic_worm/boss_toxic_worm_death.lua",
			execute_every_n_frame = "-1",
		} )
	end

	if ModSettingGet( "Apotheosis.motd_setting" ) == true and (day == 31 or day == 1) and hour == 3 then
		GamePrintImportant( "$log_apotheosis_toxicnest_secret_name", "$logdesc_apotheosis_moon_altar_fungus", "mods/Apotheosis/files/ui_gfx/decorations/3piece_creature_shift.png" )
		local wormcount = 9

		repeat
			if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
				local eid = EntityLoad( "data/entities/animals/gold_bosses/toxic_worm/boss_toxic_worm.xml", pos_x, pos_y )
				EntityAddComponent( eid, "LuaComponent", 
				{ 
					script_death = "data/entities/animals/gold_bosses/toxic_worm/boss_toxic_worm_death.lua",
					execute_every_n_frame = "-1",
				} )
			else
				local eid = EntityLoad( "data/entities/animals/boss_toxic_worm/boss_toxic_worm.xml", pos_x, pos_y )
				EntityAddComponent( eid, "LuaComponent", 
				{ 
					script_death = "data/entities/animals/boss_toxic_worm/boss_toxic_worm_death.lua",
					execute_every_n_frame = "-1",
				} )
			end
			wormcount = wormcount - 1
		until wormcount == 0
	end
	
	EntityKill( entity_id )
end