dofile_once("data/scripts/lib/utilities.lua")



local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + entity_id )
local lootSeed = Random( 1, 100)

if (lootSeed >= 96) then
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_random_cursed.xml", pos_x, pos_y )
elseif (lootSeed >= 65) then
	EntityLoad( "data/entities/items/pickup/chest_random.xml", pos_x, pos_y )
elseif (lootSeed >= 60) then
	EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x, pos_y )
elseif (lootSeed >= 55) then
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/stone_fungus.xml", pos_x, pos_y )
elseif (lootSeed >= 50) then
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml", pos_x, pos_y )
else
	EntityLoad( "data/entities/items/pickup/heart.xml", pos_x, pos_y )
end