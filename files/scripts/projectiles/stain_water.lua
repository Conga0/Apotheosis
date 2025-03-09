local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 15

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	EntityAddRandomStains( v, CellFactory_GetType("water"), 75 )
end