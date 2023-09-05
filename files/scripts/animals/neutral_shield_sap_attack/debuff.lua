
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)
local x, y = EntityGetTransform( player_id )

local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_shield_disabled.xml", x, y)
EntityAddChild(player_id,c)
GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )


EntityKill( entity_id )