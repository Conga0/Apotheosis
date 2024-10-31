function vec_normalize(x, y)
	local m = math.sqrt( x ^ 2 + y ^ 2 )
	if m == 0 then return 0,0 end
	x = x / m
	y = y / m
	return x,y
end

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform( entity_id )

local directional = false

local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
for k=1,#comps do
    if comps[k] ~= nil and ComponentGetValue2(comps[k],"script_source_file") == "mods/Apotheosis/files/scripts/items/radar_stone_ping_inside.lua" then
	directional = true
	break
    end
end

GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_radar/ping", pos_x, pos_y );

if directional == true then
    local entid = EntityLoad( "mods/Apotheosis/files/entities/particles/radar_stone_ping.xml", pos_x, pos_y )
    local partcomp = EntityGetFirstComponentIncludingDisabled( entid, "ParticleEmitterComponent" )
    ComponentSetValue2( partcomp, "count_min", 20 )
    ComponentSetValue2( partcomp, "count_max", 20 )

    local ping_distance = 30

    local plane_x = 5866
    local plane_y = 2421

    local dir_x = plane_x - pos_x
    local dir_y = plane_y - pos_y
    local dir_x,dir_y = vec_normalize(dir_x,dir_y)

    local ping_rot = math.atan2(dir_y,dir_x)

    for k=1,3 do
	--[[
	local ping_x = pos_x + dir_x * (ping_distance * k)
	local ping_y = pos_y + dir_y * (ping_distance * k)
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_radar/ping", ping_x, ping_y );
	]]--
	local eid = EntityLoad( "mods/Apotheosis/files/entities/particles/radar_stone_ping.xml", pos_x, pos_y )
	EntitySetTransform( eid, pos_x, pos_y, ping_rot )
	local particlecomp = EntityGetFirstComponentIncludingDisabled( eid, "ParticleEmitterComponent" )
	ComponentSetValue2( particlecomp, "area_circle_sector_degrees", 180 / k )
	ComponentSetValue2( particlecomp, "velocity_always_away_from_center", 30 * k )
    end
else
    EntityLoad( "mods/Apotheosis/files/entities/particles/radar_stone_ping.xml", pos_x, pos_y )
end

