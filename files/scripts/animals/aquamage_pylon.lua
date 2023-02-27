local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 40

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	if EntityHasTag(v, "watermage") == false then
		EntityAddRandomStains( v, CellFactory_GetType("apotheosis_magic_liquid_suffocatium"), 5 )
	end
end