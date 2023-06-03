
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

EntityLoad( "data/entities/particles/poof_red_sparse.xml", pos_x, pos_y )