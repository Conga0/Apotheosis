
old_func = spawn_perk_reroll
function spawn_perk_reroll( x, y )
    old_func(x, y)
	EntityLoad( "mods/Apotheosis/files/entities/buildings/perk_void_check.xml", x - 50, y )
end