local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( x, y, 18, "hittable" )

for k=1,#targets
do v = targets[k]
	EntityAddRandomStains( v, CellFactory_GetType("radioactive_liquid"), 50 )
	EntityInflictDamage( v, 0.10, "DAMAGE_RADIOACTIVE", "$damage_apotheosis_toxic_sphere", "NONE", 0, 0, entity_id )
end