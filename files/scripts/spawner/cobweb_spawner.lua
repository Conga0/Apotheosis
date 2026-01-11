function player_nearby(x,y)
	local player_nearby = false
	
	local players = EntityGetWithTag( "player_unit" )
	if ( #players > 0 ) then
		local player_id = players[1]
		local px,py = EntityGetTransform( player_id )
		local distance = math.abs(py - y) * 0.5 + math.abs(px - x)
		
		if (distance < 200) then
			player_nearby = true
		end
	end
    return player_nearby
end

local entity_id = GetUpdatedEntityID()
local cam_x, cam_y = GameGetCameraPos()

if player_nearby(cam_x,cam_y) then
    EntityKill(entity_id)
end
