dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	EntityLoad( "data/entities/particles/image_emitters/magical_symbol_fast_toxic.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/greed_curse/create", spawn_x, spawn_y)

	if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
		EntityLoad( "data/entities/animals/gold_bosses/boss_musical_ghost.xml", pos_x, pos_y )
	else
		EntityLoad( "data/entities/animals/boss_musical_ghost/boss_musical_ghost.xml", pos_x, pos_y )
	end
	
	EntityKill( entity_id )
end