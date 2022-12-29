dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_musical_boss_goldmode" )

	-- do some kind of an effect? throw some particles into the air?


		EntityLoad( "data/entities/items/pickup/heart.xml", pos_x + 8, pos_y )
		perk_spawn( pos_x, pos_y, "apotheosis_GHOSTLY_VISION" )
		EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x - 24, pos_y )
		EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x + 24, pos_y )

	if (flag_status ~= 1) then
		CreateItemActionEntity( "apotheosis_MUSICAL_STRIKE", pos_x - 16, pos_y )
		CreateItemActionEntity( "apotheosis_REVERBERATION", pos_x + 16, pos_y )
		EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x - 8, pos_y )
		EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_music_boss.xml", 4262, 2115 )
	end
	
	if ModIsEnabled("raksa") == false then
		GameAddFlagRun( "apotheosis_miniboss_musical_boss" )
		AddFlagPersistent( "apotheosis_card_unlocked_musical_boss" )
		AddFlagPersistent( "apotheosis_card_unlocked_musical_boss_spell" )
		AddFlagPersistent( "apotheosis_card_unlocked_musical_boss_goldmode" )
	end
	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )
end
