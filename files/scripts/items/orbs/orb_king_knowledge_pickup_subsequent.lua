dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")

function item_pickup( entity_item, entity_who_picked, item_name )
	local pos_x, pos_y = EntityGetTransform( entity_item )
	GameAddFlagRun( "apotheosis_card_unlocked_secret_knowledge_of_kings_complete" )
	
	local message_title = "$secretmessage_apotheosis_divineorb_heart_name"
	local message_desc = "$itempickupdesc_orb_discovered"
	
	GamePrintImportant( message_title, message_desc )
	
	shoot_projectile( entity_who_picked, "data/entities/particles/image_emitters/orb_effect.xml", pos_x, pos_y, 0, 0 )
	CreateItemActionEntity( "apotheosis_KNOWLEDGE_OF_KINGS", pos_x, pos_y )

	EntityKill( entity_item )
end