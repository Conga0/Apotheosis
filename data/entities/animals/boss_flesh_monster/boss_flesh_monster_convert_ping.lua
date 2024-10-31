
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local lowest_ping = 1800 --Pings every 30 seconds at the very least

local flesh = false
local curse = false

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
    flesh = true
end

local timercomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
local player_minions = ComponentGetValue2( timercomp, "value_bool")
if player_minions == true then
    curse = true
end

if flesh == true or curse == true then

    local luacomp = nil
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_convert_ping_visual.lua" then
	    luacomp = luacomps[i]
	    break
	end
    end

    local heretic_time = 10800 --3 minutes
    --heretic_time = 1800 --half a minute debug

    local timer = ComponentGetValue2( timercomp, "value_float")
    local current_time = GameGetFrameNum()
    local old_time = ComponentGetValue2( timercomp, "value_int")
    local time = 0

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

    if ping <= 0 then
	ComponentSetValue2( timercomp, "value_float", 0)
	ComponentSetValue2( timercomp, "value_int", 0)
	ComponentSetValue2( luacomp, "execute_every_n_frame", lowest_ping )
	GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", pos_x, pos_y );
	EntityLoad( "data/entities/animals/boss_flesh_monster/particles/convert_flesh_wave.xml", pos_x, pos_y )
	if flesh == true then
	    EntityLoad( "data/entities/animals/boss_flesh_monster/convert_flesh.xml", pos_x, pos_y )
	end
	if curse == true then
	    local r = 250
	    local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "enemy" ) or {}
	    for k=1, #targets
	    do local v = targets[k]
		local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
		local faction = ComponentGetValue2( genome, "herd_id")
		if v ~= entity_id and genome ~= nil and faction == StringToHerdId("player") then
		    local child_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_flesh_curse_long.xml",pos_x,pos_y)
		    EntityAddChild(v,child_id)
		end
	    end
	end
    else
	ComponentSetValue2( luacomp, "execute_every_n_frame", ping )
    end

else
    local timercomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)

    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_convert_ping_visual.lua" then
	    if ComponentGetIsEnabled(luacomps[i]) == true then
		EntitySetComponentIsEnabled(entity_id, luacomps[i], false)
	    end
	    break
	end
    end
end
