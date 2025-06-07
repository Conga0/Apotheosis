local worldEntity = GameGetWorldStateEntity()
local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
local time = ComponentGetValue2(comp,"time")

function player_nearby(x,y)
	local player_nearby = false
	
	local players = EntityGetWithTag( "player_unit" )
	if ( #players > 0 ) then
		local player_id = players[1]
		local px,py = EntityGetTransform( player_id )
		local distance = math.abs(py - y) * 0.5 + math.abs(px - x)
		
		if (distance < 400) then
			player_nearby = true
		end
	end
    return player_nearby
end

if time > 0.55 and time < 0.70 then
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	if player_nearby(pos_x,pos_y) == false then
		EntityLoad("data/entities/animals/wolf.xml",pos_x,pos_y)
		EntityKill(entity_id)
	end
end

