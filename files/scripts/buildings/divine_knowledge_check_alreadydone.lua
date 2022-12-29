dofile_once("data/scripts/lib/utilities.lua")

local entity_id	= GetUpdatedEntityID()

if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) then
	EntityKill( entity_id )
end
