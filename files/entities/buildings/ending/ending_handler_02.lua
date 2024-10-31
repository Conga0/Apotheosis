dofile_once("mods/Apotheosis/lib/apotheosis/apotheosis_utils.lua")
GameAddFlagRun("apotheosis_ending_cutscene")

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

--[[
local entityEvents = {
    --{lifetime_to_run_at,entity_filepath_to_load,frame_runtime (leave at 0 if default of 60)},
    {0,"mods/Apotheosis/files/entities/intro/1_1.xml"},
    {60,"mods/Apotheosis/files/entities/intro/1_2.xml"},
    {120,"mods/Apotheosis/files/entities/intro/1_1.xml"},
    {180,"mods/Apotheosis/files/entities/intro/1_2.xml"},
    {240,"mods/Apotheosis/files/entities/intro/1_3.xml"},
    {300,"mods/Apotheosis/files/entities/intro/1_4.xml"},
    {360,"mods/Apotheosis/files/entities/intro/1_5.xml"},
    {420,"mods/Apotheosis/files/entities/intro/1_6.xml"},
    {480,"mods/Apotheosis/files/entities/intro/2_1.xml"},
    {540,"mods/Apotheosis/files/entities/intro/2_2.xml"},
    {600,"mods/Apotheosis/files/entities/intro/2_3.xml"},
    {660,"mods/Apotheosis/files/entities/intro/2_4.xml"},
    {720,"mods/Apotheosis/files/entities/intro/2_5.xml"},
    {780,"mods/Apotheosis/files/entities/intro/2_6.xml"},
    {840,"mods/Apotheosis/files/entities/intro/2_7.xml"},
    {900,"mods/Apotheosis/files/entities/intro/3_1.xml"},
    {960,"mods/Apotheosis/files/entities/intro/3_2.xml"},
    {1020,"mods/Apotheosis/files/entities/intro/3_2.xml"},
    {1080,"mods/Apotheosis/files/entities/intro/3_3.xml"},
    {1140,"mods/Apotheosis/files/entities/intro/3_3.xml"},
    {1200,"mods/Apotheosis/files/entities/intro/3_3.xml"},
    --{1260,"mods/Apotheosis/files/entities/intro/pan_down.xml"},
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
    EntityLoad("mods/Apotheosis/files/entities/buildings/ending/ending_particles_01.xml", pos_x, pos_y)

    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/midas/create", pos_x, pos_y )
end

--Shake the screen & accelerate time
if runtime < 420 then
    --Shake the screen
    GameScreenshake( 1, plyr_x, plyr_y )

    --Fast forward time
    local worldEntity = GameGetWorldStateEntity()
    local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
    local time = ComponentGetValue2(comp,"time")
    ComponentSetValue2(comp,"time",time + 0.0025)
end

--Prepare for player to be teleported offscreen by removing their control ability & power to control the camera
if runtime == 420 then
    set_controls_enabled(false)
    PlayerCamControls(false)
    local cam_x, cam_y = GameGetCameraPos()
    GlobalsSetValue("apotheosis_ending_cam_x",tostring(cam_x))
    GlobalsSetValue("apotheosis_ending_cam_y",tostring(cam_y))
end

if runtime > 420 then
    local cam_x = tonumber(GlobalsGetValue("apotheosis_ending_cam_x"))
    local cam_y = tonumber(GlobalsGetValue("apotheosis_ending_cam_y"))
    GameSetCameraPos(cam_x,cam_y)
end

--Spawn vanishing Particles
--Teleport player downwards
--Disable their need for oxygen incase it isn't already done
if runtime == 421 then
    --Vanish the player (teleport them downwards offscreen)
    EntityLoad("data/entities/particles/image_emitters/player_disappear_effect_right.xml", plyr_x, plyr_y)
    EntitySetTransform(player_id, plyr_x, plyr_y + 300)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent"),"air_needed",false)

    --Hide the player's UI
    ToggleUI(player_id,false)

    --Play sound effect
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use", pos_x, pos_y )
end

--Enable Mina's symbols in the skybox
if runtime == 840 then
    --Do Mina's Symbols
    EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/mina_02.xml", pos_x, pos_y - 90)

    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/new_biome/create", pos_x, pos_y )
end

if runtime == 960 then
    --Begin playing music slightly beforehand as it starts muted
    --5 seconds to start up (300 frames)
    GameTriggerMusicFadeOutAndDequeueAll()
    GamePlaySound( "data/audio/Desktop/music.bank", "music/credits/02", pos_x, pos_y )
end

if runtime == 1260 then
    --Begin Apotheosis credits screen
    EntityLoad("mods/Apotheosis/files/entities/buildings/ending/credits_horscht.xml", pos_x, pos_y)
    GameAddFlagRun("ending_game_completed")
    AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_02")
end

