
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
EntityGetTransform(target)

local c = EntityLoad("mods/apotheosis/files/entities/misc/hitfx_nohealing_remove.xml", pos_x, pos_y)
EntityAddChild(target,c)
