--dofile_once("data/scripts/lib/utilities.lua")
--When Heretic's enraged he can be unloaded by exiting and coming back
--This script makes it so you're never truly safe...

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

--The flag is activated upon Heretic being removed, an entity isn't considered removed when unloaded through save and exiting
if (heretic_found == false) and GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_removed" ) == false then
    local incoming = false
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/player_find_boss_cue.lua" then
	    incoming = true
	    break
	elseif ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/player_find_boss_incoming.lua" then
	    incoming = true
	    break
	end
    end

    if incoming then return end

    local time = 7200 --2 minutes

    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/player_find_boss_cue.lua",
	execute_every_n_frame=time,
	remove_after_executed=true,
    }) 

elseif (heretic_found == true) then
    GameRemoveFlagRun( "apotheosis_miniboss_boss_flesh_monster_removed" )
end