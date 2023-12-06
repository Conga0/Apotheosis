dofile_once("data/scripts/perks/perk.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

CreateItemActionEntity( "ALPHA", pos_x - 60, pos_y )
EntityLoad( "data/entities/items/pickup/heart_better.xml", pos_x - 30, pos_y )
perk_spawn( pos_x, pos_y, "EDIT_WANDS_EVERYWHERE" )
EntityLoad( "data/entities/items/pickup/heart_fullhp.xml", pos_x + 30, pos_y )
CreateItemActionEntity( "BLACKHOLE", pos_x + 60, pos_y )

EntityKill(entity_id)
