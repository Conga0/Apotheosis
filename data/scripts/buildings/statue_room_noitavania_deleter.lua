dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 192

function collision_trigger()
	local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

	for i,v in ipairs( targets ) do
		if (EntityHasTag( v, "player_unit" ) == false) and ( (EntityGetName( v ) == "Keiju") == false ) then
			EntityKill ( v )
		end
	end

	EntityKill( entity_id )
end