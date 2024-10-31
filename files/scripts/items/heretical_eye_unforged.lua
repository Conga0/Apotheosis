--Ah here we go, now here's a moreso very complex system
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

EntityKill(entity_id)

EntityLoad( "mods/Apotheosis/files/entities/items/pickups/heretical_eye.xml", pos_x, pos_y )
EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/eye_vanish_emitter.xml", pos_x, pos_y-10)

local unforgeness = tonumber(GlobalsGetValue("HERETIC_UNFORGED"))
if unforgeness == nil then
	unforgeness = 0
end

GlobalsSetValue("HERETIC_UNFORGED", tostring(unforgeness + 1))