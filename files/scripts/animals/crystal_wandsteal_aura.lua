dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

for k=1, #targets
do local v = targets[k];
	local c = EntityGetAllChildren( v )
	local valid = true
	
	if ( c ~= nil ) then
			for z=1,#c
			do local b = c[z]
			if ( EntityGetName( b ) == "creep_debuff_polycrystal" ) then
				valid = false
				break
			end
		end
	end
	
	if valid then
		local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/wand_crystal_attack/debuff.xml", target_x, target_y )
		EntityAddChild( v, eid )
	end
end

