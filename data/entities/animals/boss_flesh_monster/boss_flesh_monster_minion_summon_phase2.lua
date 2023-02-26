dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

SetRandomSeed(x,y)
rnd = Random(-30,30) * 5
EntityLoad("data/entities/animals/boss_flesh_monster/minions/wraith_summon_portal.xml", x + rnd, y + rnd)
