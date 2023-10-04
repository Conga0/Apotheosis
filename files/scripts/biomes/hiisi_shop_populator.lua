    

RegisterSpawnFunction( 0xffec9a19, "spawn_brimstone_apo" )

function spawn_brimstone_apo(x, y)
	EntityLoad( "data/entities/items/pickup/brimstone.xml", x, y )
end
