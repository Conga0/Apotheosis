local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 40

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	EntityAddRandomStains( v, CellFactory_GetType("apotheosis_radioactive_liquid_strong"), 5 )
end