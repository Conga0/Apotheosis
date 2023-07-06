local nxml = dofile_once("mods/Apotheosis/lib/apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local initframe = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"LifetimeComponent") ,"creation_frame")
local runtime = GameGetFrameNum() - initframe
--local pos_x, pos_y = (225 -700)
local pos_x, pos_y = EntityGetTransform(entity_id)
local player_id = EntityGetWithTag("player_unit")[1]

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

--Cutscene Initialization
if runtime == 0 then
    --Gather world entity data
    local worldEntity = GameGetWorldStateEntity()
    local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")

    --Set weather up to be nice
    ComponentSetValue2(comp,"intro_weather",true)
    ComponentSetValue2(comp,"time",0.55)
    ComponentSetValue2(comp,"time_dt",0.5)
    ComponentSetValue2(comp,"fog",0)
    ComponentSetValue2(comp,"rain",0)

    --Prepare camera for cutscene
    GameSetCameraFree(true)
    set_controls_enabled(false)
    EntitySetTransform(entity_id, 225, -700)
    PlayerCamControls(false)
    pos_x, pos_y = (225 -700)

    --GamePlayAnimation( player_id, "intro_sleep", 50 )

    --Kill mountain music & play intro music
    EntityKill(EntityGetWithName( "intro_start_music_trigger" ))
    EntityKill(EntityGetWithName( "intro_start_music_trigger_left" ))
    GamePlaySound( "data/audio/Desktop/music.bank", "music/intro/00", pos_x, pos_y )

    --Spawn intro brazier
    EntityLoad("data/entities/props/physics_torch_stand_intro.xml", 275, -90)

    local child = EntityLoad("mods/apotheosis/files/entities/misc/effect_protection_all_intro.xml")
    EntityAddChild(player_id,child)

    --Lower the player into the ground for cutscene mina to take their place
    --EntitySetTransform(player_id, 227, 0)
    --local actor_id = EntityLoad("mods/apotheosis/files/entities/intro/player_actor_lay.xml", 227, -85)
    --GamePlayAnimation( actor_id, "intro_sleep", 99 )

    ToggleUI(player_id,false)
end

if runtime == 1260 then
    --Disable the Camera Light
    --Note: Causes a weird glitching effect
    --GameSetCameraFree(false)
end

if runtime > 1260 then
    --pos_y = pos_y + 2
    --EntitySetTransform(entity_id, pos_x, pos_y)

    local lerp_amount = 0.993

    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform( entity_id )
        
    -- lerp towards target
    local target_x, target_y = EntityGetTransform(player_id)
    --local target_x, target_y = (227 -85)
    if target_x == nil then return end
    
    -- move towards target
    pos_x,pos_y = lerpVec(pos_x, pos_y, target_x, target_y + 30, lerp_amount)
    EntitySetTransform( entity_id, pos_x, pos_y, 0, 1, 1)

end

if runtime == 1260 + 189 then
    --refreshSprites(player_id)
    GamePlayAnimation( player_id, "intro_stand_up", 51, "stand", 52 )

    --EntityKill(EntityGetWithName( "intro_actor_laydown" ))
    --local actor_id = EntityLoad("mods/apotheosis/files/entities/intro/player_actor_lay.xml", 227, -85)
    --GamePlayAnimation( actor_id, "intro_stand_up", 99, "stand", 1 )
end

if runtime > 1260 + 420 then
    GameSetCameraFree(false)
    set_controls_enabled(true)
    PlayerCamControls(true)
    EntityKill(entity_id)
    --EntitySetTransform(player_id, 227, -85)
    refreshSprites(player_id)
    ToggleUI(player_id,true)
else
    GameSetCameraPos(pos_x,pos_y)
end
