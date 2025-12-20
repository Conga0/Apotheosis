
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local did_hit, hit_x, hit_y = Raytrace( pos_x, pos_y, pos_x, pos_y + 512 )

local scene_radius = 128

--mat, visual, bg

LoadPixelScene( "mods/Apotheosis/files/biome_impl/special_scenes/magic_fountain.png", "mods/Apotheosis/files/biome_impl/special_scenes/magic_fountain_visual.png", hit_x-scene_radius, hit_y-scene_radius-112, "mods/Apotheosis/files/biome_impl/special_scenes/magic_fountain_background.png", true )

EntityLoad("mods/Apotheosis/files/entities/buildings/magic_fountain.xml",hit_x,hit_y)

EntityKill(entity_id)