local spawn_all_perks_apotheosispatch = spawn_all_perks

function spawn_all_perks( x, y )
	spawn_all_perks_apotheosispatch( x, y )
	EntityLoad("mods/Apotheosis/files/entities/buildings/perk_manipulator.xml", x, y)
end