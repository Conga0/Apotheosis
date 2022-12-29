dofile_once("data/scripts/lib/utilities.lua")


if HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki" ) then
	EntityKill(GetUpdatedEntityID())
end
