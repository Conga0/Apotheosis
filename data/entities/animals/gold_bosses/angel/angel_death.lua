dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_divinebeing_goldmode" )

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

	-- do some kind of an effect? throw some particles into the air?


	EntityLoad( "data/entities/items/pickup/heart.xml", pos_x, pos_y )


	if ( Random( 1, 20 ) == 20 ) then
		EntityLoad( "data/entities/items/pickup/heart_fullhp.xml", pos_x, pos_y )
	end

	if ( Random( 1, 16 ) == 16 ) then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml", pos_x, pos_y )
	end

	local opts = { "apotheosis_NUKE_RAY", "apotheosis_ICEBALL_RAY", "apotheosis_DYNAMITE_RAY", "apotheosis_CURSED_ORB_RAY", "apotheosis_SAWBLADE_BIG_RAY", "apotheosis_NUKE_RAY_ENEMY", "apotheosis_ICEBALL_RAY_ENEMY", "apotheosis_DYNAMITE_RAY_ENEMY", "apotheosis_CURSED_ORB_RAY_ENEMY", "apotheosis_SAWBLADE_BIG_RAY_ENEMY", "apotheosis_NUKE_RAY_ENEMY_ENEMY" }
	local rnd = Random( 1, #opts )

	if flag_status then
		if ( Random( 1, 2 ) == 2 ) then
			for i=1,2 do
				rnd = Random( 1, #opts )
				CreateItemActionEntity( opts[rnd], pos_x - 8 * 4 + (i-1) * 16, pos_y )
				table.remove( opts, rnd )
			end
		end
	else
		for i=1,3 do
			rnd = Random( 1, #opts )
			CreateItemActionEntity( opts[rnd], pos_x - 8 * 4 + (i-1) * 16, pos_y )
			table.remove( opts, rnd )
		end
		EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x, pos_y )
		EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_divine_being.xml", 4152, 2115 )
	end
	
	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		GameAddFlagRun( "apotheosis_miniboss_divinebeing" )
		AddFlagPersistent( "apotheosis_card_unlocked_divinebeing" )
		AddFlagPersistent( "apotheosis_card_unlocked_divinebeing_spell" )
		AddFlagPersistent( "apotheosis_card_unlocked_divinebeing_goldmode" )
	end
	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )
end