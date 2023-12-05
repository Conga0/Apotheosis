
function spawn_small_enemies(x, y)
	if ( y < 0 ) then
		spawn(g_small_enemies,x,y)
	else
		spawn(g_small_enemies_sky,x,y)
	end
end

function spawn_big_enemies(x, y)
	if ( y < 0 ) then
		spawn(g_big_enemies,x,y)
	else
		spawn(g_big_enemies_sky,x,y)
	end
end

function spawn_moon( x, y )
	if ( y >= 0 ) then
		EntityLoad( "data/entities/buildings/moon_altar.xml", x, y )
	else
		EntityLoad( "data/entities/buildings/dark_moon_altar.xml", x, y )
	end
end
