dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( 2352, 6575 )
if Random(1,20) == 1 then
    local eid = EntityLoad( "mods/mod_name/files/entities/items/pickup/mycustomchest.xml", pos_x, pos_y)
    EntityKill ( entity_id )
end