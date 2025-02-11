dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/cat_wand.xml", pos_x, pos_y )
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", pos_x, pos_y)
	EntityLoad( "mods/Apotheosis/files/entities/particle_generators/smoke_cloud_generator_nolua.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/treble_eye/create", pos_x, pos_y)
	GamePlaySound( "data/audio/Desktop/animals.snd", "animals/rat/death", pos_x, pos_y)

	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		AddFlagPersistent( "apotheosis_card_unlocked_cat_secret" )
		AddFlagPersistent( "apotheosis_card_unlocked_cat_secret_spell" )

		if GameHasFlagRun("apotheosis_hardmode") then
			AddFlagPersistent( "apotheosis_card_unlocked_cat_secret_goldmode" )
		end
	end

	EntityKill( entity_id )
end

