dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 256

function collision_trigger()
	local targets = EntityGetInRadius( x, y, r )

	for i,v in ipairs( targets ) do
		if ( EntityGetName( v ) == "Polymorph Crystal" ) or ( EntityGetName( v ) == "Chaotic Polymorph Crystal" ) then
			EntityKill ( v )
		end
	end

	EntityKill( entity_id )
end