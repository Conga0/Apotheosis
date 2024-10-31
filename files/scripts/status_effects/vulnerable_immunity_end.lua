
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
EntityGetTransform(target)

local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_protection_vulnerable_temporary_remove.xml", pos_x, pos_y)
EntityAddChild(target,c)
