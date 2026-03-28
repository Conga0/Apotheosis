dofile_once("mods/Apotheosis/files/scripts/magic/markerportals/portal_use_common.lua")

function collision_trigger( player_id )
    
    local entity_id = GetUpdatedEntityID()
    local old_x, old_y = EntityGetTransform(entity_id)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", pos_x, pos_y );

    local pos_x = tonumber( GlobalsGetValue( "apotheosis_markerportal_green_x", "0" ) )
    local pos_y = tonumber( GlobalsGetValue( "apotheosis_markerportal_green_y", "0" ) )

    --For stopping Heretic baiting
    hereticCheck(player_id, old_x, old_y, pos_x, pos_y)
	
    if pos_x == 0 and pos_y == 0 then
        GamePrint("$log_apotheosis_lukki_portal_notarget")
	else
	    EntitySetTransform( player_id, pos_x, pos_y )
        EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_green_fx.xml", pos_x, pos_y)
    end

    --If the player has Portalic Rideshare, teleport nearby entities
    portaliumCheck(player_id, old_x, old_y, pos_x, pos_y)
    manaInfiniteCheck(player_id)

	EntityKill( entity_id )
end