
RegisterSpawnFunction( 0xff227132, "spawn_spirit_spawner" )
RegisterSpawnFunction( 0xff57ac68, "spawn_spirit_spawner_lava" )

function spawn_spirit_spawner(x, y)
	EntityLoad( "data/entities/animals/boss_spirit/spawner.xml", x, y )
end

function spawn_spirit_spawner_lava(x, y)
	EntityLoad( "data/entities/animals/boss_spirit/spawner.xml", x, y )
end