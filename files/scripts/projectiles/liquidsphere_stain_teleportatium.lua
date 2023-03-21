local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( x, y, 18, "hittable" )

for k=1,#targets
do v = targets[k]
	EntityAddRandomStains( v, CellFactory_GetType("magic_liquid_teleportation"), 400 )
end