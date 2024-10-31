--dofile_once("data/scripts/lib/utilities.lua")
--Approaching

function vec_normalize(x, y)
	local m = math.sqrt( x ^ 2 + y ^ 2 )
	if m == 0 then return 0,0 end
	x = x / m
	y = y / m
	return x,y
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local heretic_found = false
local boss = EntityGetWithTag( "miniboss" ) or {}
for bp=1,#boss do
    if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
	heretic_found = true
	break
    end
end

if (heretic_found == false) then
    local prison_x = 21247
    local prison_y = 5892

    local heretic_x = tonumber(GlobalsGetValue("HERETIC_X",tostring(prison_x)))
    local heretic_y = tonumber(GlobalsGetValue("HERETIC_Y",tostring(prison_y)))

    local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
    local distance = math.floor((cam_w / 4) * 3)

    local dir_x = heretic_x - pos_x
    local dir_y = heretic_y - pos_y
    local dir_x,dir_y = vec_normalize(dir_x,dir_y)

    local spawn_x = pos_x + dir_x * distance
    local spawn_y = pos_y + dir_y * distance

    EntityLoad( "mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster.xml", spawn_x, spawn_y - 20 )
end