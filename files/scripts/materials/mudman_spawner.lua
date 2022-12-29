dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )


eid = EntityLoad( "data/entities/animals/mudman_friendly.xml", x, y )
local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
if( charm_component ~= nil ) then
	ComponentSetValue( charm_component, "frames", -1 )
end
EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_mud.xml", x, y )

EntityKill( entity_id )