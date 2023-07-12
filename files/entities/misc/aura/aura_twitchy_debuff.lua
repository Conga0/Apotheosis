
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local x, y = EntityGetTransform( entity_id )

local c_id = EntityLoad( "data/entities/misc/effect_twitchy.xml", x, y )
EntityAddChild(parent_id, c_id)
GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )
EntityKill( entity_id )
