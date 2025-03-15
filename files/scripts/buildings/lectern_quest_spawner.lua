local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local did_hit, hit_x, hit_y = Raytrace( pos_x, pos_y + 100, pos_x, pos_y + 512 )

LoadPixelScene( "mods/Apotheosis/files/biome_impl/forest/lectern.png", "mods/Apotheosis/files/biome_impl/forest/lectern_visual.png", hit_x, hit_y-256, "mods/Apotheosis/files/biome_impl/forest/lectern_background.png", true )

EntityKill(entity_id)