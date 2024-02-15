
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	StatsLogPlayerKill( entity_id )

	if ModIsEnabled("raksa") == false then
		GameAddFlagRun( "apotheosis_miniboss_worm_end_big" )
		AddFlagPersistent( "apotheosis_card_unlocked_worm_end_big" )
		AddFlagPersistent( "apotheosis_card_unlocked_worm_end_big_spell" )
		if GameHasFlagRun("apotheosis_hardmode") then
			AddFlagPersistent( "apotheosis_card_unlocked_worm_end_big_goldmode" )
		end
	end

end