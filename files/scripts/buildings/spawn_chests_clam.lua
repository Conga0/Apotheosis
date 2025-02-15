dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

local count = Random(1,3)

for i=1,count do
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_random_clam.xml", pos_x + Random( -360, 360 ), pos_y - 300 )
end

local types = { "fish_large","sunken_cave/eel" } 
local rnd = Random( 1, #types )
local entity = types[rnd]

if ( rnd > 1 ) then -- Normal fishes get multiple spawns
	count = 1
end

if ( entity ~= nil ) then
	for i=1,count do
		local eid = EntityLoad( "data/entities/animals/" .. entity .. ".xml", pos_x + Random( -360, 360 ), pos_y - 320 )
		EntityRemoveTag( eid, "helpless_animal" ) -- Need to do this otherwise they'll trigger the fish rain :p
	end
end

GameScreenshake( 30 )
