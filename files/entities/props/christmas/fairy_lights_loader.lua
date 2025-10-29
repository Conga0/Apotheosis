
function player_nearby(x,y)
	local players = EntityGetWithTag( "player_unit" ) or {}
	if ( #players > 0 ) then
		local player_id = players[1]
		local px,py = EntityGetTransform( player_id )
		local distance = math.abs(py - y) + math.abs(px - x)
		
		if (distance < 256) then
			return true
		end
	end
    return false
end

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
if player_nearby(pos_x,pos_y) == true then
    EntityLoad("mods/Apotheosis/files/entities/props/christmas/fairy_lights.xml",pos_x,pos_y)
	EntityKill(entity_id)
end

