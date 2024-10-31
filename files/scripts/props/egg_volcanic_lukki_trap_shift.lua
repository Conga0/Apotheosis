local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

SetRandomSeed(math.random() * 10000, math.random() * 10000)

EntityLoad( "mods/apotheosis/files/entities/projectiles/egg_shifter.xml", x + Random(-7, 7), y + Random(-4, 7) )