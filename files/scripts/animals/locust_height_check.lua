dofile_once( "data/scripts/lib/utilities.lua" )


local entity_id = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform(entity_id)

if pos_y <= 400 then
    EntityKill(entity_id)
    EntityLoad("data/entities/animals/desert/poring.xml", pos_x, pos_y)
end