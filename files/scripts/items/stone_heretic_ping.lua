
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local heretic_found = false
local converting = false

--If heretic dead dead or game ended then destroy this script and the other stuff
if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") or GameHasFlagRun("ending_game_completed") then
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/stone_heretic_initiate.lua" then
	    EntityRemoveComponent(entity_id,luacomps[i])
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/stone_heretic_ping_visual.lua" then
	    EntityRemoveComponent(entity_id,luacomps[i])
	end
    end

    --Thought to have the stone ping the mountain altar after heretic dies, but seems too handholdy
    --[[
    EntityAddComponent( entity_id, "LuaComponent",
    {
	script_death="mods/Apotheosis/files/scripts/items/stone_heretic_altar_ping.lua",
	execute_every_n_frame="1",
    })
    ]]--

    --local particlecomp = EntityGetComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")[2]
    --EntityRemoveComponent(entity_id,particlecomp)

    if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
	local player_id = EntityGetClosestWithTag( pos_x, pos_y, "player_unit" ) or EntityGetClosestWithTag( pos_x, pos_y, "polymorphed_player" )
	if player_id ~= nil then
	    local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
	    local rad_x = math.floor((cam_w / 4) * 3.5)
	    local rad_y = math.floor((cam_h / 4) * 3.5)
	    local cam_x = cam_x + (cam_w / 2)
	    local cam_y = cam_y + (cam_h / 2)

	    local dist_x = math.abs(cam_x - pos_x)
	    local dist_y = math.abs(cam_y - pos_y)
	    if (dist_x <= rad_x) or (dist_y <= rad_y) then
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/disperse", pos_x, pos_y );
	    end
	end

	EntityLoad( "mods/Apotheosis/files/entities/particles/stone_heretic_disperse.xml", pos_x, pos_y )

	if not HasFlagPersistent("apotheosis_stone_heretic_purified") then
	    AddFlagPersistent("apotheosis_stone_heretic_purified")
	    --Lil uncertain on including something like "$log_apotheosis_stone_heretic_disperse_desc"...
	    GamePrintImportant("$log_apotheosis_stone_heretic_disperse_name")
	    GamePrint("$log_apotheosis_stone_heretic_disperse_name")
	end
    end

    local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
    ComponentSetValue2( itemcomp, "ui_sprite", "mods/Apotheosis/files/ui_gfx/items/stone_heretic.png")
    ComponentSetValue2( itemcomp, "ui_description", "$item_apotheosis_stone_heretic_desc")

    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id,comp_id)

return
end

local boss = EntityGetInRadiusWithTag(pos_x,pos_y,1536,"miniboss") or {}
for bp=1,#boss do
    if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_flesh_monster" then
	heretic_found = true
    end
end

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( pos_x, pos_y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "stone_converter" ) ~= 0 and EntityGetParent(entity_id) == 0 then
    converting = true
end

local lowest_ping = 600
local no_ping = 1200

if (heretic_found == false) and (converting == false) then

    local luacomp = nil
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/stone_heretic_ping_visual.lua" then
	    luacomp = luacomps[i]
	    break
	end
    end

    if ComponentGetIsEnabled( luacomp ) == false then
	EntitySetComponentIsEnabled( entity_id, luacomp, true)
    end

    --local particlecomp = EntityGetComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")[2]

    local heretic_time = 14400 --4 minutes
    if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_armor") then
	--In phase 2 he appears faster
	heretic_time = 7200 --1.5 minutes
    end
    --debug timer
    --heretic_time = 3600

    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    local timer = ComponentGetValue2( timercomp, "value_float")
    local current_time = GameGetFrameNum()
    local old_time = ComponentGetValue2( timercomp, "value_int")
    local warning = ComponentGetValue2( timercomp, "value_bool")
    local mode = ComponentGetValue2( timercomp, "value_string")
    local time = 0

    if mode == "rapid" then
	heretic_time = 600 --10 seconds
	lowest_ping = 60 --1 second
    end

    if old_time <= 0 then
	ComponentSetValue2( timercomp, "value_int", current_time)
	old_time = current_time
    end
    if old_time > 0 then
	time = ( old_time + heretic_time ) - current_time
    end

    ComponentSetValue2( timercomp, "value_float", time)

    local divider = time / heretic_time

    local ping = math.ceil((lowest_ping * divider) - 0.5)

    if time == 300 and warning == false then
	GamePrint("$log_apotheosis_flesh_boss_warning")
	ComponentSetValue2( timercomp, "value_bool", true)
    end
    if ping <= 0 then
	ComponentSetValue2( timercomp, "value_float", 0)
	ComponentSetValue2( timercomp, "value_int", 0)
	ComponentSetValue2( timercomp, "value_string", "")
	--ComponentSetValue2( particlecomp, "emission_interval_min_frames", no_ping )
	--ComponentSetValue2( particlecomp, "emission_interval_max_frames", no_ping )
	ComponentSetValue2( luacomp, "execute_every_n_frame", no_ping )

	local ngplus_count = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) + tonumber(GlobalsGetValue( "apotheosis_artifical_ngplus", "0" ))

	if ngplus_count > 0 then
	    EntityLoad( "mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster_newgame_plus_short.xml", pos_x, pos_y - 20 )
	else
	    EntityLoad( "mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster.xml", pos_x, pos_y - 20 )
	end
    else
	--ComponentSetValue2( particlecomp, "emission_interval_min_frames", ping )
	--ComponentSetValue2( particlecomp, "emission_interval_max_frames", ping )
	ComponentSetValue2( luacomp, "execute_every_n_frame", ping )
    end

else
    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)

    --local particlecomp = EntityGetComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")[2]
    --[[
    local emission_check = ComponentGetValue2( particlecomp, "emission_interval_min_frames" )
    if (emission_check ~= 0) then
	local luacomp = nil
	local luacomps = EntityGetComponent(entity_id, "LuaComponent") or {}
	for i = 1, #luacomps do
	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/stone_heretic_ping_sound.lua" then
		luacomp = luacomps[i]
		break
	    end
	end
	--ComponentSetValue2( particlecomp, "emission_interval_min_frames", no_ping )
	--ComponentSetValue2( particlecomp, "emission_interval_max_frames", no_ping )
	ComponentSetValue2( luacomp, "execute_every_n_frame", lowest_ping )
    end
    ]]--
    local luacomp = nil
    local luacomps = EntityGetComponent(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/stone_heretic_ping_visual.lua" then
	    luacomp = luacomps[i]
	    break
	end
    end
    if luacomp ~= nil then
	--ComponentSetValue2( luacomp, "execute_every_n_frame", no_ping )
	--Not sure why I didn't think of this sooner...
	EntitySetComponentIsEnabled( entity_id, luacomp, false)
    end
end
