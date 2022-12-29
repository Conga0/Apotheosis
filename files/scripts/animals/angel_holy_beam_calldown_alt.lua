dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 300

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

for i,v in ipairs( targets ) do
	if ( v ~= entity_id ) then
		local target_x,target_y = EntityGetTransform( v )
		local eid = EntityLoad( "mods/Apotheosis/files/entities/projectiles/beam_holy_orb_warning.xml", target_x, target_y )
	end
end