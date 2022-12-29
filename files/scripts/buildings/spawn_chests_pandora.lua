dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

local count = Random(1,3)

for i=1,count do
	entity_id = EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_random_cursed.xml", pos_x + Random( -360, 360 ), pos_y - 300 )
end

GameScreenshake( 30 )
