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
-- local hereticfound = false

function set_controls_enabled(enabled)
    local player = EntityGetWithTag("polymorphed_player")[1]
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
    local player = EntityGetWithTag("polymorphed_player")[1]
    local comp = EntityGetFirstComponentIncludingDisabled(player,"PlatformShooterPlayerComponent")
    ComponentSetValue2(comp,"center_camera_on_this_entity",enabled)
end

function permapolymorph_entity( entity_id )

    --Perma Poly the player
	local comp_poly = GameGetGameEffect( entity_id, "POLYMORPH" )
	if( comp_poly == 0 or comp_poly == nil ) then comp_poly = GameGetGameEffect( entity_id, "POLYMORPH_RANDOM" ) end
	if( comp_poly == 0 or comp_poly == nil ) then comp_poly = GameGetGameEffect( entity_id, "POLYMORPH_UNSTABLE" ) end
	
	-- forever polymorph!
	if( comp_poly ) then ComponentSetValue2( comp_poly, "frames", -1 ) end
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

    --Speed talking -Spoop
    local heretic_id = EntityGetWithTag("apotheosis_heretic")[1] or nil
    if heretic_id ~= nil then
    local h_x, h_y = EntityGetTransform(heretic_id)

    local luacomps = EntityGetComponent(heretic_id, "LuaComponent") or {}
    for i = 1, #luacomps do
        if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/heretical_eye_dialogue.lua" then
            ComponentSetValue2( luacomps[i], "execute_every_n_frame", 150 )
    	elseif ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua" then
    		EntityRemoveComponent( heretic_id, luacomps[i] )
    	end
    end
    EntityAddComponent2(heretic_id, "LuaComponent", {
	_tags= "enabled_in_world, enabled_in_hand, enabled_in_inventory, graham_speech_quiet",
	script_source_file="mods/Apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua",
	execute_every_n_frame=5,
    }) 
    end

    GameAddFlagRun("apotheosis_heretalk_end_sheep_1")
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


if runtime > 420 and runtime < 423 then
    --permanently polymorph the player, get laughed at nerd
    --print("found player, trying to polymorph")
    if player_id then
        --Conga: Make this a custom sheep with very high hp so the game stops with the red flashing, also would stop the player from killing themselves prematurely
        --EntityAddRandomStains(player_id,CellFactory_GetType("magic_liquid_polymorph"),1000)
        
        --Disable The player's Polymorph Immunity
        EntityRemoveTag(player_id, "polymorphable_NOT")
        EntityRemoveIngestionStatusEffect( player_id, "PROTECTION_POLYMORPH" )
        local PolyimTest = GameGetGameEffectCount( player_id, "PROTECTION_POLYMORPH" )
        if PolyimTest ~= 0 then
            local comp = GameGetGameEffect( player_id, "PROTECTION_POLYMORPH" )
            if comp ~= 0 then
                ComponentSetValue2( comp, "effect", "NONE")
            end
        end

        --Polymorph player into a sheep
        LoadGameEffectEntityTo(player_id,"mods/Apotheosis/files/entities/buildings/ending/effect_polymorph_sheep.xml")
    elseif sheep_plyr then
        permapolymorph_entity(sheep_plyr)
        set_controls_enabled(false)
        --PlayerCamControls(false)
    end
end

if runtime == 419 then
    local opts = EntityGetWithTag("apotheosis_blob_boss")
    for k=1,#opts
    do local v = opts[k]
        local con_x, con_y = EntityGetTransform(v)
        if EntityGetName(v) == "i_love_you" then
            CreateItemActionEntity( "MATERIAL_WATER", con_x, con_y )
        else
            CreateItemActionEntity( "AIR_BULLET", con_x, con_y )
        end
        if EntityGetName(v) == "i_love_you" then
            EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/spell_effect_divine.xml", con_x, con_y)
        elseif EntityGetName(v) == "i_love_myworld" then
            EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/spell_effect_nature.xml", con_x, con_y)
        elseif EntityGetName(v) == "i_love_magic" then
            EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/spell_effect_magic.xml", con_x, con_y)
        elseif EntityGetName(v) == "i_love_work" then
            EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/spell_effect_tech.xml", con_x, con_y)
        else
            EntityLoad("mods/Apotheosis/files/entities/buildings/ending/constellations/spell_effect_nature.xml", con_x, con_y)
        end
    end

    --If you dropped him out of your inventory then it would've spawned a new one, checks for parents now :thumbsup: -S
    local heretic_id = EntityGetWithTag("apotheosis_heretic")[1] or nil
    local heretic_parent = EntityGetRootEntity(heretic_id)
    local hereticfound = false
    if heretic_id ~= nil and EntityHasTag(heretic_parent,"player_unit") then
        hereticfound = true
    end

    if hereticfound == true then
        EntityLoad("mods/Apotheosis/files/entities/items/pickups/heretical_eye.xml", plyr_x+12, plyr_y)
    end
end


if runtime == 620 then
    --Begin playing music slightly beforehand as it starts muted
    --5 seconds to start up (300 frames)
    GameTriggerMusicFadeOutAndDequeueAll()
    GamePlaySound( "data/audio/Desktop/music.bank", "music/credits/02", pos_x, pos_y )
    GameAddFlagRun("apotheosis_heretalk_end_sheep_2")
end

if runtime == 740 then
    --Begin Apotheosis credits screen
    --Adds the sheep flag so the script knows which ending sequence to prepare for
    GameAddFlagRun("apotheosis_ending_sheep")
    EntityLoad("mods/Apotheosis/files/entities/buildings/ending/credits_horscht.xml", pos_x, pos_y)
    GameAddFlagRun("ending_game_completed")
    AddFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_01")
end

--[[
--Moved over to credits screen script
if runtime == 600 + 3600 then
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
]]--

