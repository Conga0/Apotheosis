--dofile_once("data/scripts/lib/utilities.lua")

function vec_normalize(x, y)
	local m = math.sqrt( x ^ 2 + y ^ 2 )
	if m == 0 then return 0,0 end
	x = x / m
	y = y / m
	return x,y
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_y = pos_y - 4 -- offset to middle of character

local plane_x = 5866
local plane_y = 6005

--local plane_x = -4858
--local plane_y = 1837

--If the player is closer than 300 pixels to the location, remove the radar to avoid ui clutter
if (math.abs(pos_y - plane_y) + math.abs(pos_x - plane_x)) > 300 then

    local indicator_distance = 32

    local dir_x = plane_x - pos_x
    local dir_y = plane_y - pos_y

    -- sprite positions around character
    dir_x,dir_y = vec_normalize(dir_x,dir_y)
    local indicator_x = pos_x + dir_x * indicator_distance
    local indicator_y = pos_y + dir_y * indicator_distance

    GameCreateSpriteForXFrames( "mods/apotheosis/files/particles/radar_plane.png", indicator_x, indicator_y, true, 0, 0, 1, true )


    --In the initial world, this will search for the location of the random plane spawn location, could be 1 of 6 places
    --in the elemental planes yggdrasil, magic & technology, this will point towards the exit portal to the next plane which spawns at guaranteed x,y coordinates
    --In the final biome, the Empyrean, it'll vanish; all you have to do at that point is walk up to the altar

    --Also, hide the spatial awareness & moon radar perks while inside the planes
    --They won't be compatiable, or provide useful data

end

