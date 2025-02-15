local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if currbiome == "$biome_underwater" then
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/chest_random_clam.xml", pos_x, pos_y )
	EntityLoad( "mods/Apotheosis/files/entities/particles/image_emitters/chest_clam_convert.xml", pos_x, pos_y )
	EntityKill(entity_id)
end