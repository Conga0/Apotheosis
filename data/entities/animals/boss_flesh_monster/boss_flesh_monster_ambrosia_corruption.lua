dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 96
local p = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

if ( #p > 0 ) then
	for k=1, #p
	do local pl = p[k];
		local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/ambrosia_dullification/debuff.xml" )
		EntityAddChild( pl, eid )
	end
end