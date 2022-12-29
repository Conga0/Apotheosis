dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "enemy" )

for i,v in ipairs( targets ) do
	if ( v ~= entity_id ) then
		local target_x,target_y = EntityGetTransform( v )
		local eid = EntityLoad( "data/entities/projectiles/healshot.xml", target_x, target_y )
		local eid = EntityLoad( "data/entities/projectiles/healshot.xml", target_x, target_y )
	end
end