
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k]
	if ( v ~= entity_id ) then
		local dcomp = EntityGetFirstComponentIncludingDisabled(v,"DamageModelComponent")
		if ComponentGetValue2(dcomp,"hp") < ComponentGetValue2(dcomp,"max_hp") then
			local tx,ty = EntityGetTransform(v)
			EntityLoad("data/entities/projectiles/deck/heal_bullet.xml",tx,ty)
		end
	end
end
