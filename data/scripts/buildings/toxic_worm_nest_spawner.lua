dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local year, month, day, hour = GameGetDateAndTimeLocal()
	EntityLoad( "data/entities/particles/image_emitters/magical_symbol_fast_toxic.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/greed_curse/create", pos_x, pos_y)

	local worm_count = 1
	if ModSettingGet( "Apotheosis.motd_setting" ) == true and (day == 31 or day == 1) and hour == 3 then worm_count = 10 end
	
	for k=1,worm_count do
		local eid = EntityLoad( "data/entities/animals/boss_toxic_worm/boss_toxic_worm.xml", pos_x, pos_y )
		EntityAddComponent( eid, "LuaComponent", 
		{ 
			script_death = "data/entities/animals/boss_toxic_worm/boss_toxic_worm_death.lua",
			execute_every_n_frame = "-1",
		} )
	end

	GameAddFlagRun("apotheosis_boss_toxic_worm_summoned")
	
	EntityKill( entity_id )
end