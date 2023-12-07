dofile_once("data/scripts/perks/perk.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

CreateItemActionEntity( "ALPHA", pos_x - 60, pos_y - 40 )
EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x - 30, pos_y - 40 )
perk_spawn( pos_x, pos_y - 40, "EDIT_WANDS_EVERYWHERE" )
EntityLoad( "data/entities/items/pickup/heart_fullhp.xml", pos_x + 30, pos_y - 40 )
CreateItemActionEntity( "BLACK_HOLE", pos_x + 60, pos_y - 40 )

EntityKill(entity_id)
