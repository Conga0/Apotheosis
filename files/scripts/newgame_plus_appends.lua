local previousInit = do_newgame_plus
---@diagnostic disable-next-line: lowercase-global
function do_newgame_plus()
	previousInit()
    GameRemoveFlagRun( "apotheosis_blob_boss_slain" )
    GameRemoveFlagRun( "apotheosis_fire_lukki_boss_summoned" )
end