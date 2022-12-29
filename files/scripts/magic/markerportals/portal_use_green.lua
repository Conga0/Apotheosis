dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger( player_id )
    
    local entity_id = GetUpdatedEntityID()
    EntityGetTransform(entity_id)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", pos_x, pos_y );

    local pos_x = tonumber( GlobalsGetValue( "apotheosis_markerportal_green_x", "0" ) )
    local pos_y = tonumber( GlobalsGetValue( "apotheosis_markerportal_green_y", "0" ) )
	
    if pos_x == 0 and pos_y == 0 then
        GamePrint("You feel the portal lacks focus")
	else
	    EntitySetTransform( player_id, pos_x, pos_y )
        EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_green_fx.xml", pos_x, pos_y)
    end

	EntityKill( entity_id )
end