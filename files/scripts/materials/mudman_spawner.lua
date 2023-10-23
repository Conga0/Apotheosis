
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local filepath = GlobalsGetValue( "apotheosis_mudman_filepath", "data/entities/animals/mudman_friendly.xml" )
local eid = EntityLoad( filepath, x, y )

--Fix to not remove charm effect
if filepath ~= "data/entities/animals/mudman_friendly.xml" then
	EntityAddTag(eid,"c_shifted")
end

local charm_component = GetGameEffectLoadTo( eid, "CHARM", true )
if( charm_component ~= nil ) then
	ComponentSetValue( charm_component, "frames", -1 )
end
EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_mud.xml", x, y )

EntityKill( entity_id )