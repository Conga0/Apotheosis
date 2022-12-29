dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

function collision_trigger()
	
	local eid = EntityLoad( "mods/Apotheosis/files/entities/items/wands/custom/rat_wand.xml", pos_x, pos_y )
	  

	EntityKill( entity_id )
end