dofile_once("data/scripts/lib/utilities.lua")


if HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki" ) or GameHasFlagRun( "apotheosis_miniboss_boss_fire_lukki" ) then
	EntitySetComponentsWithTagEnabled( GetUpdatedEntityID(), "enabled_by_liquid", true )
else
	EntitySetComponentsWithTagEnabled( GetUpdatedEntityID(), "enabled_by_liquid", false )
end
