dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki" )
	StatsLogPlayerKill( entity_id )

	-- do some kind of an effect? throw some particles into the air?

		EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x, pos_y )
		--EntityLoad( "data/entities/items/wand_unshuffle_07.xml", pos_x - 12, pos_y + 12 ) Don't wanna be too generous, like, seriously, I'm already giving you full hp, lava immunity and a ton of fast travel
		--EntityLoad( "data/entities/items/wand_unshuffle_10.xml", pos_x + 12, pos_y + 12 )
		--ConvertMaterialEverywhere( CellFactory_GetType( "fire" ), CellFactory_GetType( "smoke" ) ) --Shifts all fire out of the world permanently.
		--ConvertMaterialEverywhere( CellFactory_GetType( "liquid_fire" ), CellFactory_GetType( "smoke" ) ) --Shifts all "fire" out of the world permanently.

        if flag_status then
            EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x + 16, pos_y )
        else
            EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x + 16, pos_y )
			--EntityLoad( "mods/Apotheosis/files/entities/props/statue_fire_lukki.xml", 4288, 2331 )
        end

		
		EntityLoad( "mods/Apotheosis/files/entities/buildings/portal_fire_lukki_input.xml",  pos_x, pos_y - 32 )
		EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_portals.xml",  pos_x, pos_y - 32 )
		EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_portals.xml",  pos_x + 50, pos_y - 32 )
		EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_portals.xml",  pos_x - 50, pos_y - 32 )
	
	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		GameAddFlagRun( "apotheosis_miniboss_boss_fire_lukki" )
		AddFlagPersistent( "apotheosis_card_unlocked_fire_lukki" )
		AddFlagPersistent( "apotheosis_card_unlocked_fire_lukki_spell" )
		if GameHasFlagRun("apotheosis_hardmode") then
			AddFlagPersistent( "apotheosis_card_unlocked_fire_lukki_goldmode" )
		end
	end
	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )
end