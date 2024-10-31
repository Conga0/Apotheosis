--dofile_once("data/scripts/lib/utilities.lua")

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local current_frame = GameGetFrameNum()
local lifcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"LifetimeComponent")
local parcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteParticleEmitterComponent")
local kill_frame = ComponentGetValue2(lifcomp,"kill_frame")

local sprite_fade = ((kill_frame - current_frame) / 7200) + 0.1
local original = 0.75 - 0.1

ComponentSetValue2(parcomp, "color", 1, 1, 1, original * sprite_fade)

    