
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local did_hit, hit_x, hit_y = Raytrace( pos_x, pos_y, pos_x, pos_y + 512 )

--mat, visual, bg

LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/magic_fountain.png", "", hit_x-64, hit_y-64-47, "mods/Apotheosis/files/biome_impl/special_scenes/magic_fountain_background.png", true )

EntityLoad("mods/Apotheosis/files/entities/buildings/magic_fountain.xml",hit_x,hit_y+47-47)

EntityKill(entity_id)