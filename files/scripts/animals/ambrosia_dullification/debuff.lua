local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform( entity_id )

EntityAddRandomStains( v, CellFactory_GetType("apotheosis_magic_liquid_protection_all_fading_dulled"), 400 )

GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )

EntityKill( entity_id )