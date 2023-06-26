

function item_pickup( entity_item, entity_who_picked, name )
	local entity_id = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(entity_id)

    
	CreateItemActionEntity( "APOTHEOSIS_DEATH_CROSS_OMEGA", pos_x, pos_y )

    EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_purple.xml", pos_x, pos_y)
	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", pos_x, pos_y)
	
	--GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/chest/create", x, y )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/chest_dark_open", pos_x, pos_y )
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	GameTriggerMusicEvent( "music/oneshot/dark_03", true, pos_x, pos_y )
	AddFlagPersistent("apotheosis_card_unlocked_omega_cross")
	AddFlagPersistent("apotheosis_card_unlocked_omega_cross_spell")
    EntityKill( entity_item )

end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
end