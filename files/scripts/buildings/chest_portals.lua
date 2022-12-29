dofile_once("data/scripts/lib/utilities.lua")

function item_pickup( entity_item, entity_who_picked, name )
	local entity_id = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(entity_id)

    
	CreateItemActionEntity( "apotheosis_PORTAL_LUKKI_RED_PORTAL", pos_x - 16, pos_y )
	CreateItemActionEntity( "apotheosis_PORTAL_LUKKI_GREEN_PORTAL", pos_x, pos_y )
	CreateItemActionEntity( "apotheosis_PORTAL_LUKKI_BLUE_PORTAL", pos_x + 16, pos_y )

    EntityLoad("data/entities/particles/image_emitters/magical_symbol_materia_fire.xml", pos_x, pos_y)
    GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
    EntityKill( entity_item )

end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
end