dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

function collision_trigger()

	local year, month, day = GameGetDateAndTimeLocal()
	
	if (day == 1) then
		EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/wand_of_wonders.xml", pos_x, pos_y )
		EntityLoad( "data/entities/particles/poof_green.xml", pos_x, pos_y )
		EntityLoad( "mods/Apotheosis/files/entities/items/pickups/orb_mattereater.xml", pos_x + 24, pos_y - 4 )
	else
		EntityLoad( "data/entities/items/wand_unshuffle_03.xml", pos_x, pos_y )
		EntityLoad( "data/entities/particles/poof_green.xml", pos_x, pos_y )
	end

	EntityLoad( "data/entities/items/pickup/powder_stash.xml", pos_x + 16, pos_y )
	EntityLoad( "data/entities/particles/poof_green.xml", pos_x + 16, pos_y )

	EntityLoad( "data/entities/animals/sandcave/poring.xml", pos_x + 8, pos_y )
	EntityLoad( "data/entities/particles/poof_green.xml", pos_x + 8, pos_y )
	EntityLoad( "data/entities/animals/sandcave/poring.xml", pos_x + 36, pos_y )
	EntityLoad( "data/entities/particles/poof_green.xml", pos_x + 36, pos_y )

	EntityKill( entity_id )
end