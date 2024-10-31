--dofile_once("data/scripts/lib/utilities.lua")

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local players = EntityGetWithTag( "player_unit" )
local player_id = players[1]

local currently_chasing = false

local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance_end.lua" then
	currently_chasing = true
    end
end

local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
local limbstate = ComponentGetValue2(limbbosscomp, "state")

if player_id ~= nil and currently_chasing == false then
    local p_x, p_y = EntityGetTransform(player_id)
    local dis_x = p_x - pos_x
    local dis_y = p_y - pos_y

    local distance = get_magnitude(dis_x, dis_y)
if distance >= 1400 then

    local player_x, player_y = EntityGetTransform(player_id)

    ComponentSetValue2(limbbosscomp, "state", 5)

    --Why did I put this here, chase target is already tied to the invincible tag?
    --Going to assume just I added the invincible tag disable thing later since I commented about performance stuff...
    --Ohhhh I seeee it was because when enraged it didn't have the invincible tag on the first phase
    --Since it has to add the component in, alright I'll just add the invincible tag there then...
    --[[
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua" then
	    EntitySetComponentIsEnabled(entity_id, luacomps[i], false)
	end
    end
    ]]--

    local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
    ComponentSetValue2(cellcomp, "radius", 80)

    --Stop Heretic from lagging stuff with unneeded attacks while the player's far away
    EntitySetComponentsWithTagEnabled(entity_id, "invincible", false)

    local frame = GameGetFrameNum()
    GlobalsSetValue("HERETIC_FLEE_FRAME", tostring(frame))

    --If a Heretic yells in a forest and no one is there to hear it, does it make a sound?
    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_yell", pos_x, pos_y );
    GameScreenshake( 100 )

    --Not sure if this is too needed... but I suppose he may fly in from offscreen or something
    local particle_id = EntityLoad("data/entities/animals/boss_flesh_monster/particles/chase_particles.xml", pos_x, pos_y)
    EntityAddChild( entity_id, particle_id)

    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance_end.lua",
	execute_every_n_frame=30,
	execute_on_added=0,
    }) 

    EntityAddComponent(entity_id, "AudioLoopComponent", {
	file="mods/Apotheosis/mocreeps_audio.bank",
	event_name="mocreeps_audio/animals/boss_flesh_monster/chase_movement_loop",
	set_speed_parameter="1",
	auto_play="1",
    }) 


end
end