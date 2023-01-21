dofile_once("data/scripts/lib/utilities.lua")

local child_id    = GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)

local players = EntityGetWithTag( "player_unit" )
local player = players[1]

for k=1, #players
do local v = players[k]
	local x, y = EntityGetTransform( v )
	EntityLoad("data/entities/animals/boss_flesh_monster/projectiles/manadrain_vacuum_setup.xml",x,y)
end

--If we grab rootentityid here, couldn't we make it give kill credit to the Aesthete of Heat?

