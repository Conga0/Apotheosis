dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local flag_status = HasFlagPersistent( "apotheosis_card_unlocked_rat_bite" )

if flag_status then
	EntityKill( entity_id )
end

function collision_trigger()
	
	AddFlagPersistent( "apotheosis_card_unlocked_rat_bite" )

	EntityKill( entity_id )
end