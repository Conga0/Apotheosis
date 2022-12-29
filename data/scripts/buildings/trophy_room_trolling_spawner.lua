dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local eid = EntityLoad( "data/entities/animals/wizard_copeseethmald.xml", pos_x, pos_y )
	EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_small.xml", pos_x, pos_y )
	
    local hpcomp = EntityGetFirstComponent( eid, "DamageModelComponent" )
    if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
        if( hpcomp ~= nil ) then
            ComponentSetValue( hpcomp, "max_hp", 150 )
            ComponentSetValue( hpcomp, "hp", 150 )
        end
    else
        if( hpcomp ~= nil ) then
            ComponentSetValue( hpcomp, "max_hp", 30 )
            ComponentSetValue( hpcomp, "hp", 30 )
        end
    end
	
	EntityKill( entity_id )
end