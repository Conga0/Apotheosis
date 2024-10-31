--dofile_once("data/scripts/lib/utilities.lua")

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
local parent_id = EntityGetParent(parent_id)
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_y = pos_y - 4 -- offset to middle of character

local plane_locations = { {"22790", "2400"}, {"-12538", "13613"}, {"-17146", "6445"}, {"23302", "14637"}, {"-11514", "4397"}, {"-18170", "11565"} }
--Table of potential portal spawn locations

SetRandomSeed(444,777)
local num = Random(1,6)
local plane_x = plane_locations[num][1]
local plane_y = plane_locations[num][2]

local no_ping = 1200
--If the player is closer than 300 pixels to the location, remove the radar to avoid ui clutter
if (math.abs(pos_y - plane_y) + math.abs(pos_x - plane_x)) > 300 then

    local particlecomp = EntityGetComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")[2]
    local lowest_ping = 600
    local farthest_dist = 15000
    local divider = farthest_dist / lowest_ping

    local dis_x = plane_x - pos_x
    local dis_y = plane_y - pos_y

    local distance = get_magnitude(dis_x, dis_y)

    
    local ping = math.abs(distance / divider)

    --[[
    ComponentSetValue2( particlecomp, "emission_interval_min_frames", ping )
    ComponentSetValue2( particlecomp, "emission_interval_max_frames", ping )
    ]]--

    local luacomp = nil
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/radar_stone_ping_visual.lua" then
	    luacomp = luacomps[i]
	    break
	end
    end

    ComponentSetValue2( luacomp, "execute_every_n_frame", ping )

    --In the initial world, this will search for the location of the random plane spawn location, could be 1 of 6 places
    --in the elemental planes yggdrasil, magic & technology, this will point towards the exit portal to the next plane which spawns at guaranteed x,y coordinates
    --In the final biome, the Empyrean, it'll vanish; all you have to do at that point is walk up to the altar

    --Also, hide the spatial awareness & moon radar perks while inside the planes
    --They won't be compatiable, or provide useful data

else
    --[[
    local particlecomp = EntityGetComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")[2]
    ComponentSetValue2( particlecomp, "emission_interval_min_frames", 1200 )
    ComponentSetValue2( particlecomp, "emission_interval_max_frames", 1200 )
    ]]--
    local luacomp = nil
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/radar_stone_ping_visual.lua" then
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

