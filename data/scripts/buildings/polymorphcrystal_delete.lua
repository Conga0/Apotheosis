dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 256

function collision_trigger()
	local targets = EntityGetInRadiusWithTag( x, y, r, "hittable" )

	for k=1,#targets
	do v= targets[k]
		if ( EntityGetName( v ) == "Polymorph Crystal" ) or ( EntityGetName( v ) == "Chaotic Polymorph Crystal" ) then
			EntityKill ( v )
		end
	end

	EntityKill( entity_id )
end