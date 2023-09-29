
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

EntityLoad( "mods/Apotheosis/files/entities/misc/remove_ground_smaller.xml", pos_x, pos_y )
EntityKill(entity_id)
