dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 96
local p = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

if ( #p > 0 ) then
	local pl = p[1]
	
	local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/psychotic_attack/debuff.xml" )
	EntityAddChild( pl, eid )
end

EntityKill( entity_id )