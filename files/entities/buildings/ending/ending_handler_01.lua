dofile_once("mods/Apotheosis/lib/apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local initframe = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"LifetimeComponent") ,"creation_frame")
local runtime = GameGetFrameNum() - initframe
--local pos_x, pos_y = (225 -700)
local pos_x, pos_y = EntityGetTransform(entity_id)
local player_id = EntityGetWithTag("player_unit")[1]
local plyr_x, plyr_y = EntityGetTransform(player_id)
local sheep_plyr = EntityGetWithTag("polymorphed_player")[1]

function set_controls_enabled(enabled)
    local player = EntityGetWithTag("player_unit")[1]
    if player then
        local controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
        ComponentSetValue2(controls_component, "enabled", enabled)
        for prop, val in pairs(ComponentGetMembers(controls_component) or {}) do
            if prop:sub(1, 11) == "mButtonDown" then
                ComponentSetValue2(controls_component, prop, false)
            end
        end
    end
end

function PlayerCamControls(enabled)   --Disables camera locking onto player
    local player = EntityGetWithTag("player_unit")[1]
    local comp = EntityGetFirstComponentIncludingDisabled(player,"PlatformShooterPlayerComponent")
    ComponentSetValue2(comp,"center_camera_on_this_entity",enabled)
end

function permapolymorph_entity( entity_id )
	local comp_poly = GameGetGameEffect( entity_id, "POLYMORPH" )
	if( comp_poly == 0 or comp_poly == nil ) then comp_poly = GameGetGameEffect( entity_id, "POLYMORPH_RANDOM" ) end
	if( comp_poly == 0 or comp_poly == nil ) then comp_poly = GameGetGameEffect( entity_id, "POLYMORPH_UNSTABLE" ) end
	
	-- forever polymorph!
	if( comp_poly ) then ComponentSetValue2( comp_poly, "frames", -1 ) end
end

--[[
local entityEvents = {
    --{lifetime_to_run_at,entity_filepath_to_load,frame_runtime (leave at 0 if default of 60)},
    {0,"mods/apotheosis/files/entities/intro/1_1.xml"},
    {60,"mods/apotheosis/files/entities/intro/1_2.xml"},
    {120,"mods/apotheosis/files/entities/intro/1_1.xml"},
    {180,"mods/apotheosis/files/entities/intro/1_2.xml"},
    {240,"mods/apotheosis/files/entities/intro/1_3.xml"},
    {300,"mods/apotheosis/files/entities/intro/1_4.xml"},
    {360,"mods/apotheosis/files/entities/intro/1_5.xml"},
    {420,"mods/apotheosis/files/entities/intro/1_6.xml"},
    {480,"mods/apotheosis/files/entities/intro/2_1.xml"},
    {540,"mods/apotheosis/files/entities/intro/2_2.xml"},
    {600,"mods/apotheosis/files/entities/intro/2_3.xml"},
    {660,"mods/apotheosis/files/entities/intro/2_4.xml"},
    {720,"mods/apotheosis/files/entities/intro/2_5.xml"},
    {780,"mods/apotheosis/files/entities/intro/2_6.xml"},
    {840,"mods/apotheosis/files/entities/intro/2_7.xml"},
    {900,"mods/apotheosis/files/entities/intro/3_1.xml"},
    {960,"mods/apotheosis/files/entities/intro/3_2.xml"},
    {1020,"mods/apotheosis/files/entities/intro/3_2.xml"},
    {1080,"mods/apotheosis/files/entities/intro/3_3.xml"},
    {1140,"mods/apotheosis/files/entities/intro/3_3.xml"},
    {1200,"mods/apotheosis/files/entities/intro/3_3.xml"},
    --{1260,"mods/apotheosis/files/entities/intro/pan_down.xml"},
}

for k=1,#entityEvents
do local v = entityEvents[k]
    if v[1] == runtime then 
        local scene = EntityLoad(v[2],pos_x,pos_y)
        if v[3] ~= nil then
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(scene,"LifetimeComponent") ,"lifetime",v[3])
        end
        break
    end
end
]]--

--Cutscene Initialization
if runtime == 0 then
    EntityLoad("mods/apotheosis/files/entities/buildings/ending/ending_particles_01.xml", pos_x, pos_y)
end

--Shake the screen & accelerate time
if runtime < 420 then
    --Shake the screen
    GameScreenshake( 1, plyr_x, plyr_y )

    --Fast forward time
    local worldEntity = GameGetWorldStateEntity()
    local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
    local time = ComponentGetValue2(comp,"time")
    ComponentSetValue2(comp,"time",time + 0.001)
end


if runtime > 420 and runtime < 430 then
    --permanently polymorph the player, get laughed at nerd
    --print("found player, trying to polymorph")
    if player_id then
        --Conga: Make this a custom sheep with very high hp so the game stops with the red flashing, also would stop the player from killing themselves prematurely
        EntityAddRandomStains(player_id,CellFactory_GetType("magic_liquid_polymorph"),1000)
    elseif sheep_plyr then
        permapolymorph_entity(sheep_plyr)
    end
end


if runtime == 600 then
    --Begin Apotheosis credits screen
    EntityLoad("mods/apotheosis/files/entities/buildings/ending/credits_horscht.xml", pos_x, pos_y)
    GameAddFlagRun("ending_game_completed")
end

if runtime == 600 + 3800 then
    --Declare run as victorious, begin Noita credits screen
    GameOnCompleted()
    local plyr_x, plyr_y = EntityGetTransform(sheep_plyr)
    EntityLoad("data/entities/animals/sheep.xml", plyr_x, plyr_y)
    EntityKill(sheep_plyr)
    GameAddFlagRun("ending_game_completed")
    --EntityKill(player_id)
    --EntityAddRandomStains(player_id,CellFactory_GetType("magic_liquid_polymorph"),1000)
    --permapolymorph_entity(player_id)
end


