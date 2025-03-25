
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster" )
	dofile_once("data/scripts/perks/perk.lua")
	StatsLogPlayerKill( entity_id )

	-- do some kind of an effect? throw some particles into the air?

	EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x, pos_y )
	--EntityLoad( "data/entities/items/wand_unshuffle_07.xml", pos_x - 12, pos_y + 12 ) Don't wanna be too generous, like, seriously, I'm already giving you full hp, lava immunity and a ton of fast travel
	--EntityLoad( "data/entities/items/wand_unshuffle_10.xml", pos_x + 12, pos_y + 12 )
	--ConvertMaterialEverywhere( CellFactory_GetType( "fire" ), CellFactory_GetType( "smoke" ) ) --Shifts all fire out of the world permanently.
	--ConvertMaterialEverywhere( CellFactory_GetType( "liquid_fire" ), CellFactory_GetType( "smoke" ) ) --Shifts all "fire" out of the world permanently.

	--Not sure why this was here... -S
	--[[
	if flag_status then
		EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x + 16, pos_y )
	else
		EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x + 16, pos_y )
		--EntityLoad( "mods/Apotheosis/files/entities/props/statue_fire_lukki.xml", 4288, 2331 )
	end
	]]--
	EntityLoad( "data/entities/items/pickup/heart_fullhp.xml",  pos_x + 16, pos_y )

	
	EntityLoad( "data/entities/animals/boss_flesh_monster/boss_flesh_monster_explosion.xml", pos_x, pos_y )

	if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
		EntityLoad( "data/entities/animals/boss_flesh_monster/phase3/phase3_stone_portal_quiet.xml", pos_x, pos_y )
	else
		EntityLoad( "data/entities/animals/boss_flesh_monster/phase3/phase3_stone_portal_quiet_stoneless.xml", pos_x, pos_y )
	end
	--EntityLoad( "mods/Apotheosis/files/entities/items/pickups/stone_heretic.xml", pos_x, pos_y )

	--April Fools Print
	local year, month, day, hour, minute = GameGetDateAndTimeLocal()
	local seasonalForced_AprilFools = ModSettingGet("Apotheosis.seasonal_events_forced_april_fools")
	if ModSettingGet("Apotheosis.seasonal_events") and (((month == 4) and (day == 1)) or seasonalForced_AprilFools) then
		GamePrint("The ancient spirits of light and dark have been released.")
	end
	
	if not (ModIsEnabled("raksa") or ModIsEnabled("conjurer_reborn")) then
		GameAddFlagRun( "apotheosis_miniboss_boss_flesh_monster" )
		AddFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster" )
		AddFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster_spell" )
		if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_rage") then
			AddFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster_wrath" )
		end
		local children = EntityGetAllChildren( v )
		activated = true
		if ( children ~= nil ) then
		for a,b in ipairs( children ) do
			if ( EntityGetName(b) == "flesh_curse" ) then
				AddFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster_gourd_holy" )
				break
			end
		end
		end
		--local seed = string.lower(ModSettingGet( "Apotheosis.custom_seed" ))
		--if seed == "hardcore" or seed == "nightcore" then
		if GameHasFlagRun("apotheosis_hardmode") or GameHasFlagRun("apotheosis_everything") then
			AddFlagPersistent( "apotheosis_card_unlocked_boss_flesh_monster_goldmode" )
			EntityLoad( "mods/Apotheosis/files/entities/items/pickups/perk_copyspells.xml", pos_x, pos_y - 16)
		end
		if GameHasFlagRun("apotheosis_everything") then
			perk_spawn( pos_x, pos_y, "APOTHEOSIS_PLANE_RADAR" )
			GameAddFlagRun("apotheosis_stone_obsolete") 
		end
	end
	
	--StatsLogPlayerKill( entity_id )

	--EntityKill( entity_id )

	--drop eye
	--drop stone
end