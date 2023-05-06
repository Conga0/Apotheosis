dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	if v ~= entity_id then
		local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_teleport_cancel.xml", x, y )
		EntityAddChild( v, eid )
	end
end