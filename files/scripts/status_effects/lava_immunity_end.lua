
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform(target)

local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_protection_lava_temporary_remove.xml", pos_x, pos_y)
EntityAddChild(target,c)
