dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed(pos_x,pos_y)

if Random( 1, 4 ) == 2 then
	EntityLoad( "data/entities/animals/whisp_fast.xml", pos_x, pos_y)
end