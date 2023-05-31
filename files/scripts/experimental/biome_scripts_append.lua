
function spawn_portal( x, y )
	if( BIOME_NAME == "crypt" ) then
		EntityLoad( "data/entities/buildings/teleport_boss_arena.xml", x, y - 4 )
    elseif y < 6800 and y > 6600 then   --Midboss check teleporters
		EntityLoad( "data/entities/buildings/teleport_liquid_powered_midboss.xml", x, y - 4 )
	else
		EntityLoad( "data/entities/buildings/teleport_liquid_powered.xml", x, y - 4 )
	end
end