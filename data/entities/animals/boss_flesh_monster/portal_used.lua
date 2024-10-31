--dofile_once("data/scripts/lib/utilities.lua")

function portal_teleport_used( entity_that_was_teleported, from_x, from_y, to_x, to_y )
	local entity_id = GetUpdatedEntityID()

	EntityKill(entity_id)
end
    