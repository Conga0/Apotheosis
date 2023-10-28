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
    EntityLoad("mods/apotheosis/files/entities/buildings/ending/ending_particles_02.xml", pos_x, pos_y)

    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/midas/create", pos_x, pos_y )
    ConvertMaterialEverywhere(CellFactory_GetType( "spark_white_bright" ),CellFactory_GetType( "spark_red_bright" ))

    GamePlaySound( "data/audio/Desktop/music.bank", "music_reverb", pos_x, pos_y )
end

--Gradually turn the sky red
if runtime == 240 then
    local sky = EntityLoad("mods/apotheosis/files/entities/buildings/ending/big_fuckoff_red_texture.xml", pos_x, pos_y)
    EntityAddChild(player_id,sky)
end

--Shake the screen & accelerate time
if runtime < 420 then
    --Shake the screen
    GameScreenshake( 1, plyr_x, plyr_y )

    --Fast forward time
    --local worldEntity = GameGetWorldStateEntity()
    --local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
    --local time = ComponentGetValue2(comp,"time")
    --ComponentSetValue2(comp,"time",time + 0.0025)
end

if runtime > 420 then
    --local cam_x = tonumber(GlobalsGetValue("apotheosis_ending_cam_x"))
    --local cam_y = tonumber(GlobalsGetValue("apotheosis_ending_cam_y"))
    --GameSetCameraPos(cam_x,cam_y)

    GameScreenshake( 2, plyr_x, plyr_y )
end

--Spawn vanishing Particles
--Teleport player downwards
--Disable their need for oxygen incase it isn't already done
if runtime == 421 then
    --Vanish the Heretic
    local heretic_id = EntityGetWithTag("apotheosis_heretic")[1]
    local h_x, h_y = EntityGetTransform(heretic_id)
    EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/eye_vanish_emitter.xml", h_x, h_y)
    EntityKill(heretic_id)
    --GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use", pos_x, pos_y )
end

--Hide the God's contellations in the skybox (gradual)
if runtime < 700 and runtime > 400 then
    local opts = EntityGetWithTag("apotheosis_blob_boss")
    for k=1,#opts
    do local v = opts[k]
        if math.random(1,300) == 1 then
            local comp = EntityGetFirstComponentIncludingDisabled(v,"ParticleEmitterComponent")
            EntitySetComponentIsEnabled(v,comp,false)
            GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", pos_x, pos_y )
        end
    end
end

--Hide the God's contellations in the skybox (hard)
if runtime == 700 then
    local opts = EntityGetWithTag("apotheosis_blob_boss")
    for k=1,#opts
    do local v = opts[k]
        local comp = EntityGetFirstComponentIncludingDisabled(v,"ParticleEmitterComponent")
        EntitySetComponentIsEnabled(v,comp,false)
    end
    --GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", pos_x, pos_y )
end

--Convert the constellations into Heretic Symbols
if runtime == 820 then
    local opts = EntityGetWithTag("apotheosis_blob_boss")
    for k=1,#opts
    do local v = opts[k]
        local con_x, con_y = EntityGetTransform(v)
        EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/revenge_02.xml", con_x, con_y)
        EntityKill(v)
    end

    ConvertMaterialEverywhere(CellFactory_GetType( "apotheosis_templebrick_static_invincible" ),CellFactory_GetType( "apotheosis_corrupt_flesh_static" ))
    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/greed_curse/create", pos_x, pos_y )
end

if runtime == 1120 then
    local particle_id = EntityLoad("mods/apotheosis/files/entities/buildings/ending/ending_particles_02.xml", pos_x, pos_y)
    local comp = EntityGetFirstComponentIncludingDisabled(particle_id,"HomingComponent")
    ComponentSetValue2(comp,"target_tag","player_unit")
    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/midas/create", pos_x, pos_y )
end

if runtime == 1540 then
    --make the red sky no longer parent to the player just before teleporting them off-screen
    local children = EntityGetAllChildren(player_id)
    for k=1,#children
    do local v = children[k]
        if EntityGetName(v) == "apotheosis_ending_red_sky" then
            EntityRemoveFromParent(v)
            break
        end
    end

    --Vanish the player (teleport them downwards offscreen)
    EntityLoad("data/entities/particles/image_emitters/player_disappear_effect_right.xml", plyr_x, plyr_y)
    EntitySetTransform(player_id, plyr_x, plyr_y + 300)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent"),"air_needed",false)
    LoadRagdoll( "data/ragdolls/player/filenames.txt", plyr_x, plyr_y - 4, "meat", 1, 0, 0 )
    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/game_over/create", plyr_x, plyr_y )

    --Hide the player's UI
    ToggleUI(player_id,false)
end

if runtime == 1780 then
    --Begin playing music slightly beforehand as it starts muted
    --5 seconds to start up (300 frames)
    GameTriggerMusicFadeOutAndDequeueAll()
    GamePlaySound( "data/audio/Desktop/music.bank", "music/credits/02", pos_x, pos_y )
end

if runtime == 2080 then
    --Begin Apotheosis credits screen
    GameAddFlagRun("apotheosis_ending_heretic")
    EntityLoad("mods/apotheosis/files/entities/buildings/ending/credits_horscht.xml", pos_x, pos_y)
    GameAddFlagRun("ending_game_completed")
    AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03")
end


