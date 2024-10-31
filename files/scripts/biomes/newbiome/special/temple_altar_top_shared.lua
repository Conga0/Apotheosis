

function spawn_portal( x, y )
	if y < 1000 then
		EntityLoad( "data/entities/buildings/teleport_ending.xml", x, y - 4 )
	else
		EntityLoad( "data/entities/buildings/teleport_liquid_powered.xml", x, y - 4 )
	end
end

function spawn_altar_top(x, y, is_solid)
	SetRandomSeed( x, y )
	local randomtop = Random( 1, 50 )
	local file_visual = "mods/Apotheosis/files/biome_impl/upsidedown/temple/altar_bottom_visual.png"
	
	LoadBackgroundSprite( "mods/Apotheosis/files/biome_impl/upsidedown/temple/altar_bottom_background.png", x-1, y - 30, 35 )

	if( y > 12000 ) then
		--LoadPixelScene( "data/biome_impl/temple/altar_top_boss_arena.png", file_visual, x, y-40, "", true )
		LoadPixelScene( "mods/Apotheosis/files/biome_impl/upsidedown/temple/altar_bottom.png", file_visual, x, y-40, "", true ) -- Placeholder
	else
		LoadPixelScene( "mods/Apotheosis/files/biome_impl/upsidedown/temple/altar_bottom.png", file_visual, x, y-40, "", true )
	end	

	if is_solid then LoadPixelScene( "mods/Apotheosis/files/biome_impl/upsidedown/temple/solid.png", "", x, y-300, "", true ) end
end
