local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 25

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	local found = false

	local children = EntityGetAllChildren(v) or {}
	for z=1,#children
	do local c = children[z]
		if EntityGetName(c) == "apotheosis_hex_water" then
			found = true
		end
	end

	if found ~= true then
		local status = EntityLoad("mods/apotheosis/files/entities/misc/effect_hex_water_short.xml",x,y)
		EntityAddChild(v,status)
	end
end