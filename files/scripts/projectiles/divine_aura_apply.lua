
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 32

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for i,v in ipairs( targets ) do
	if ( v ~= entity_id ) then
		local c = EntityGetAllChildren( v ) or {}
		local valid = true

		for k=1,#c do
			if EntityGetName(c[k]) == "divine_protection" then
			valid = false
			break
		end
		
		if valid then
			local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_divine_protection_long.xml", x, y )
			EntityAddChild( v, eid )
		end
	end
end