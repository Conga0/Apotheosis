local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 16

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k]
	if v ~= entity_id then
		local t_x, t_y = EntityGetTransform(v)
		EntityLoad("mods/apotheosis/files/entities/projectiles/hexshot_bloodcurse_nohome_nodmg.xml",t_x,t_y)
	end
end
