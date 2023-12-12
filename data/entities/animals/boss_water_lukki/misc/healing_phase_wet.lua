local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 130

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k]
	EntityInflictDamage( v, 0.2, table.concat({"DAMAGE_HOLY"}), "$creep_apotheosis_boss_water_lukki_name", "NONE", 0, 0, shooter_id )
end