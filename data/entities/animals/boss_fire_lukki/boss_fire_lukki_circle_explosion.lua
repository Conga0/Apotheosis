dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 600
local trishot = true

-- check that we're only shooting every 10 frames
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

for i,v in ipairs( targets ) do
	if ( v ~= entity_id ) then
		local targ_x, targ_y = EntityGetTransform( v )
		local distance = math.abs(targ_y - pos_y) * 0.5 + math.abs(targ_x - pos_x)
		if distance > 256 then
			EntityLoad( "data/entities/animals/boss_fire_lukki/projectiles/circle_explosion.xml", targ_x, targ_y )
		end
	end
end