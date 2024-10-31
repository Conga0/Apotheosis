-- extra dialogue for dashening
local entity_id = GetUpdatedEntityID()

local x, y, rot, scale_x = EntityGetTransform(entity_id)

SetRandomSeed(x + GameGetFrameNum(), y + 1394)

if ModIsEnabled("grahamsdialogue") then
    dofile_once("mods/grahamsdialogue/files/common.lua")

    local dialogue = {"HI-YAAHH!", "EAT THIS!", "EMBLAZE!"}
    local type = Random(1, #dialogue)

    Speak(entity_id, dialogue[type], pools.CUSTOM, true)
end