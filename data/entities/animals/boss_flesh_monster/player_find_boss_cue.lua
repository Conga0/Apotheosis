--dofile_once("data/scripts/lib/utilities.lua")
--Warning

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
    local incoming = false
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/player_find_boss_incoming.lua" then
	    incoming = true
	    break
	end
    end

    if incoming then return end

    local prison_x = 21247
    local prison_y = 5892

    local heretic_x = tonumber(GlobalsGetValue("HERETIC_X",tostring(prison_x)))
    local heretic_y = tonumber(GlobalsGetValue("HERETIC_Y",tostring(prison_y)))

    local sound_distance = 50

    local dir_x = heretic_x - pos_x
    local dir_y = heretic_y - pos_y
    local dir_x,dir_y = vec_normalize(dir_x,dir_y)

    local cue_x = pos_x + dir_x * sound_distance
    local cue_y = pos_y + dir_y * sound_distance

    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster_distant_directional", cue_x, cue_y );
    GameScreenshake( 100 )

    local time = 3600/2 --half a minute

    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/player_find_boss_incoming.lua",
	execute_every_n_frame=time,
	remove_after_executed=true,
    }) 

end