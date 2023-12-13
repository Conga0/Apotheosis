
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 600

-- check that we're only shooting every 10 frames
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

for k=1,#targets do
	local v = targets[k]
	local targ_x, targ_y = EntityGetTransform( v )
	for z=1,10 do
		GameShootProjectile( entity_id, pos_x, pos_y, targ_x + math.random(-30,30), targ_y + math.random(-30,30), EntityLoad("mods/apotheosis/files/entities/projectiles/aquamage_bomb_long.xml",pos_x,pos_y) )
	end
end
