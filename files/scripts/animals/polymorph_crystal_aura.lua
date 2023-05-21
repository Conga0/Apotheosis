dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

for k=1, #targets
do local v = targets[k];
	
	local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/poly_crystal_attack/debuff.xml", target_x, target_y )
	EntityAddChild( v, eid )

end

