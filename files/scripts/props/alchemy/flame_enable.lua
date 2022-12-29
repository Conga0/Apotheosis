dofile_once("data/scripts/lib/utilities.lua")


function collision_trigger()
	EntitySetComponentsWithTagEnabled( GetUpdatedEntityID(), "invincible", true )
end