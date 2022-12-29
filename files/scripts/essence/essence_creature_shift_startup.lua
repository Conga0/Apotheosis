dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/files/scripts/magic/creature_shift_file.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y)

-- shift creatures
creature_shift( entity_id, pos_x, pos_y, true )


