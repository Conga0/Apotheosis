local entity_id = GetUpdatedEntityID()

local targets = EntityGetWithTag( "watermage" )

for k=1, #targets
do local v = targets[k];
	local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_charm_veryshort.xml", x, y )
	EntityAddChild( v, eid )
end