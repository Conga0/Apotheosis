
local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local pos_x, pos_y = EntityGetTransform( root_id )

-- kill self
-- We use an EntityKill here to avoid adding a kill count to the progress log
EntityKill(root_id)

EntityLoad( "data/entities/animals/boss_flesh_monster/boss_flesh_monster_explosion.xml", pos_x, pos_y )
EntityLoad( "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster.xml", pos_x, pos_y )
