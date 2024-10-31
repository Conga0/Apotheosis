dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform( parent_id )

shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/deathlaser/deathcross_cross.xml", pos_x, pos_y, 0, 0 )

shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/deathlaser/deathcross_cross.xml", pos_x+2, pos_y-2, 0, 0 )

shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/deathlaser/deathcross_cross.xml", pos_x-2, pos_y+2, 0, 0 )

shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/deathlaser/deathcross_cross.xml", pos_x-2, pos_y-2, 0, 0 )

shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/deathlaser/deathcross_cross.xml", pos_x+2, pos_y+2, 0, 0 )
