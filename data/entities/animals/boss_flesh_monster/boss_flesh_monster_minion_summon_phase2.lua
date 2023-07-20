
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

SetRandomSeed(x,y)
local rnd = Random(-30,30) * 5
EntityLoad("data/entities/animals/boss_flesh_monster/minions/wraith_summon_portal.xml", x + rnd, y + rnd)

SetRandomSeed(x*2,y+999)
local rnd = Random(-30,30) * 4
EntityLoad("data/entities/animals/boss_flesh_monster/minions/twitchy_summon_portal.xml", x + rnd, y + rnd)

