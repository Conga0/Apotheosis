dofile_once("mods/Apotheosis/lib/apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local initframe = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"LifetimeComponent") ,"creation_frame")
local runtime = GameGetFrameNum() - initframe
--local pos_x, pos_y = (225 -700)
local pos_x, pos_y = EntityGetTransform(entity_id)
local player_id = EntityGetWithTag("player_unit")[1]

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

    --Kill mountain music & play intro music
    EntityKill(EntityGetWithName( "intro_start_music_trigger" ))
    EntityKill(EntityGetWithName( "intro_start_music_trigger_left" ))
    GamePlaySound( "data/audio/Desktop/music.bank", "music/intro/00", pos_x, pos_y )

    --Spawn intro brazier
    EntityLoad("data/entities/props/physics_torch_stand_intro.xml", 275, -90)

    local child = EntityLoad("mods/Apotheosis/files/entities/misc/effect_protection_all_intro.xml")
    EntityAddChild(player_id,child)

    --Disable the player's hud during the intro cutscene
    ToggleUI(player_id,false)

    --Clear ingame text log
    GamePrint("")
    GamePrint("")
    GamePrint("")
    GamePrint("")
    GamePrint("")
    GamePrint("")
end

if runtime == 10 then
    --Clear ingame text log again when the player selects their wand
    GamePrint("")
    GamePrint("")
    GamePrint("")
    GamePrint("")
    GamePrint("")
    GamePrint("")
end

--Pan camera downwards to the player
if runtime > 1260 then

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
    
    --Fast forward time to midday
    local worldEntity = GameGetWorldStateEntity()
    local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
    local time = ComponentGetValue2(comp,"time")
    ComponentSetValue2(comp,"time",time + 0.001)
end

--Make player stand up, timed so the animation ends perfectly with the player gaining control
if runtime == 1260 + 189 then
    GamePlayAnimation( player_id, "intro_stand_up", 51 )
end

--Exit cutscene mode, reenable hud, return control to player
--Else, update the camera position each frame
if runtime > 1260 + 420 then
    GameSetCameraFree(false)
    set_controls_enabled(true)
    PlayerCamControls(true)
    EntityKill(entity_id)
    --EntitySetTransform(player_id, 227, -85)
    refreshSprites(player_id)
    ToggleUI(player_id,true)

    local worldEntity = GameGetWorldStateEntity()
    local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
    ComponentSetValue2(comp,"time_dt",1)
    AddFlagPersistent( "apotheosis_intro_cutscene" )
else
    GameSetCameraPos(pos_x,pos_y)
end
