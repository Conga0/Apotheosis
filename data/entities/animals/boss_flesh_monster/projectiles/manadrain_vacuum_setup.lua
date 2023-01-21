dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

EntityLoad("data/entities/animals/boss_flesh_monster/projectiles/manadrain_vacuum.xml",x,y)
EntityKill(entity_id)

--Scraping sound effect similar to esoteric being's divine light attack being created would sound cool and giive indication something's going on