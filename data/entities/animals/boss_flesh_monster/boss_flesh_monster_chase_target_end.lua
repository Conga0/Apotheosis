--dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local portal_away = false

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") and currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
	--We're outside of home and got the stone, so let's not start pathfinding so we can teleport away easier
	--Start pathfinding? Uhhh I meant change limbboss state value!
	portal_away = true
end

local currently_chasing = false

local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance_end.lua" then
	currently_chasing = true
	break
    end
end

local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
local limbstate = ComponentGetValue2(limbbosscomp, "state")

if portal_away == false and currently_chasing == false and limbstate == 5 then
    ComponentSetValue2(limbbosscomp, "state", 1)

    --[[
    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )

    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_stone_target.lua" then
	    EntitySetComponentIsEnabled(entity_id, luacomps[i], true)
	end
    end
    ]]--

    local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
    ComponentSetValue2(cellcomp, "radius", 60)

    local audioloopcomps = EntityGetComponentIncludingDisabled(entity_id, "AudioLoopComponent") or {}
    for i = 1, #audioloopcomps do
	if ComponentGetValue2(audioloopcomps[i], "event_name") == "mocreeps_audio/animals/boss_flesh_monster/chase_movement_loop" then
	    EntityRemoveComponent(entity_id, audioloopcomps[i])
	end
    end

    local c = EntityGetAllChildren( entity_id )
    if c ~= nil then
    for a,b in ipairs( c ) do
    	if EntityHasTag( b, "acid" ) then
    	    local particlename = EntityGetName( b )
    	    if ( particlename == "chase_particles" ) then
        	EntityKill( b )
    	    end
        end
    end
    end

    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/deaggro", pos_x, pos_y )
end