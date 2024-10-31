--dofile_once("data/scripts/lib/utilities.lua")

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local players = EntityGetWithTag( "player_unit" )
local player_id = players[1]

local portal_away = false

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") and currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
	--We're outside of home and got the stone, so let's not give chase so we can teleport away easier
	portal_away = true
end

--[[
local currently_chasing = false

local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_end.lua" then
	currently_chasing = true
    end
end
]]--

local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
local no_stone = ComponentGetIsEnabled(pathfindcomp)

local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
local limbstate = ComponentGetValue2(limbbosscomp, "state")

if player_id ~= nil and portal_away == false and limbstate == 1 and no_stone == true then

    local player_x, player_y = EntityGetTransform(player_id)

    ComponentSetValue2(limbbosscomp, "state", 5)

    --[[
    ComponentSetValue2(limbbosscomp, "mMoveToPositionX", player_x)
    ComponentSetValue2(limbbosscomp, "mMoveToPositionY", player_y)

    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, false )

    local physaicomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent" )
    ComponentSetValue2(physaicomp, "mLastPositionWhenHadPath", player_x, player_y)

    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_stone_target.lua" then
	    EntitySetComponentIsEnabled(entity_id, luacomps[i], false)
	end
    end
    ]]--

    local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
    ComponentSetValue2(cellcomp, "radius", 80)

    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_yell", pos_x, pos_y );
    GameScreenshake( 100 )

    EntityAddComponent(entity_id, "AudioLoopComponent", {
	file="mods/Apotheosis/mocreeps_audio.bank",
	event_name="mocreeps_audio/animals/boss_flesh_monster/chase_movement_loop",
	set_speed_parameter=1,
	auto_play=true,
    }) 

    --Conga sadly can't hear sound cues, it's like streamer blindness but for sounds
    --So we're adding in a particle effect to better show the chase sequence
    local particle_id = EntityLoad("data/entities/animals/boss_flesh_monster/particles/chase_particles.xml", pos_x, pos_y)
    EntityAddChild( entity_id, particle_id)

    local dis_x = player_x - pos_x
    local dis_y = player_y - pos_y

    local distance = get_magnitude(dis_x, dis_y)

    --Chases down the player for 7 seconds
    local time = 420

    if distance >= 700 or GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
	--Chases down the player for 12 seconds
	time = 720
    end

    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_end.lua",
	execute_every_n_frame=time,
	execute_on_added=0,
	remove_after_executed=1
    }) 

    --No longer needed due to newfound LimbBoss sorcery
    --[[
    local continue_time = 5
    local continuations = math.floor(time / continue_time)

    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_continue.lua",
	execute_every_n_frame=continue_time,
	execute_on_added=0,
	execute_times=continuations
    }) 
    ]]--

    local storages = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
    local phase = ComponentGetValue2( storages, "value_int")

    --Sort of have to hope Heretic sees the player as the pathfinding is firing
    --Otherwise Heretic sort of just shows up and then immediately skedaddles away back to where he started the chase
    --No longer the case thanks to LimbBoss sorcery as stated above :)

    local cooldown = 3000

    if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
	--GAAAHHHH I HATE THE PLAYER!!! THEY DESTROYED MY SHINY ROCK!
	cooldown = 1500
    elseif phase == 3 or phase == 4 then
	--We're panicking, so chase often
	cooldown = 1800
    elseif distance <= 100 then
	--We're a bit close, maybe chill out a little?
	cooldown = 3600
    elseif distance >= 900 then
	--We're a bit far, let's close that distance
	cooldown = 1800
    else
	--We're a bit fine, act as usual
	cooldown = 3000
    end

	local comp_id = GetUpdatedComponentID()
	ComponentSetValue2(comp_id, "execute_every_n_frame", cooldown)
end