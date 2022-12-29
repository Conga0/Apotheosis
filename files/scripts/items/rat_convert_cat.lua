dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/cat_wand.xml", pos_x, pos_y )
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", pos_x, pos_y)
	EntityLoad( "mods/Apotheosis/files/entities/particle_generators/smoke_cloud_generator_nolua.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/treble_eye/create", pos_x, pos_y)
	GamePlaySound( "data/audio/Desktop/animals.snd", "animals/rat/death", pos_x, pos_y)

	if ModIsEnabled("raksa") == false then
		AddFlagPersistent( "apotheosis_card_unlocked_cat_secret" )
		AddFlagPersistent( "apotheosis_card_unlocked_cat_secret_spell" )

		if (ModIsEnabled("nightmare") or ModIsEnabled("purgatory")) and HasFlagPersistent( "apotheosis_card_unlocked_cat_secret_goldmode") == false then
			EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_cat_secret.xml", 4288, 2049 )
		elseif HasFlagPersistent( "apotheosis_card_unlocked_cat_secret" ) == false then
			EntityLoad( "mods/Apotheosis/files/entities/props/statue_cat_secret.xml", 4288, 2049 )
		end

		if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
			AddFlagPersistent( "apotheosis_card_unlocked_cat_secret_goldmode" )
		end
	end

	EntityKill( entity_id )
end

