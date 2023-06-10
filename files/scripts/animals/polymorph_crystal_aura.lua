
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

for k=1, #targets
do local v = targets[k];
	local valid = true

	if GameGetGameEffectCount( v, "POLYMORPH" ) > 0 then
		valid = false
		break
	end
	
	local children = EntityGetAllChildren(v)
	for z=1,#children
	do local c = children[z]
		if EntityGetName(c) == "creep_debuff_polycrystal" then
			valid = false
			break
		end
	end

	if valid then
		local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/poly_crystal_attack/debuff.xml", target_x, target_y )
		EntityAddChild( v, eid )
	end

end
