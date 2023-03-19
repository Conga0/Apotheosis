dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm" )



	-- do some kind of an effect? throw some particles into the air?

		EntityLoad( "data/entities/items/pickup/heart.xml", pos_x, pos_y )
		EntityLoad( "data/entities/items/wand_unshuffle_05.xml", pos_x + 16, pos_y )

        if flag_status then
            CreateItemActionEntity( "apotheosis_BUNGAL_SHIFT", pos_x - 16, pos_y )
            CreateItemActionEntity( "apotheosis_MASS_MATERIA_CONVERSION", pos_x + 16, pos_y )
        else
            CreateItemActionEntity( "apotheosis_BUNGAL_SHIFT", pos_x - 16, pos_y )
            CreateItemActionEntity( "apotheosis_MASS_MATERIA_CONVERSION", pos_x + 16, pos_y )
            EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x + 8, pos_y )
			EntityLoad( "mods/Apotheosis/files/entities/props/statue_toxic_worm.xml", 4202, 2115 )
        end
	
	if ModIsEnabled("raksa") == false then
		GameAddFlagRun( "apotheosis_miniboss_boss_toxic_worm" )
		AddFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm" )
		AddFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm_spell" )
		if GameHasFlagRun("apotheosis_hardmode") then
			AddFlagPersistent( "apotheosis_card_unlocked_boss_toxic_worm_goldmode" )
		end
	end
	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )
end