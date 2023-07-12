local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( x, y, 64, "hittable" )

for i,eid in pairs( targets ) do
	EntityAddRandomStains( eid, CellFactory_GetType("apotheosis_blood_infectious"), 400 )
end