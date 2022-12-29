dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local pos_x, pos_y = EntityGetTransform( entity_id )
local player = EntityGetInRadiusWithTag(pos_x, pos_y, 92, "player_unit")

for i,v in ipairs(player) do
	local enemy_x, enemy_y = EntityGetTransform(v)

	local vel_x, vel_y = vec_sub(enemy_x, enemy_y, pos_x, pos_y)
	vel_x,vel_y = vec_normalize(vel_x, vel_y)

	GameCreateParticle("blood", pos_x, pos_y, 10, vel_x * 10, vel_y * 10, true, true )
	GamePrint("player found, spray blood")
end
