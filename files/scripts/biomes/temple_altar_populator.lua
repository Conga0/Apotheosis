
function spawn_all_perks( x, y )
	SetRandomSeed( x, y )

	if( GlobalsGetValue( "TEMPLE_SPAWN_GUARDIAN" ) == "1" ) then
		-- EntityLoad( "data/entities/misc/spawn_necromancer_shop.xml", x + 30, y - 30 )
		temple_spawn_guardian( x + 30, y - 30 )
	else
		EntityLoad( "data/entities/buildings/workshop_guardian_spawn_pos.xml", x + 30, y - 30 )
	end

	local spawn_shop, do_spawn_perks = temple_random( x, y )
	if( do_spawn_perks == "0" ) then
		return
	end
	
	perk_spawn_many( x, y )

    EntityLoad("mods/apotheosis/files/entities/buildings/perk_manipulator.xml", x, y)
end