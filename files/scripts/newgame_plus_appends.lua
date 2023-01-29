





local previousInit = do_newgame_plus
function do_newgame_plus()
	previousInit( x ,y ,w ,h)
    GameRemoveFlagRun( "apotheosis_blob_boss_slain" )
    GameRemoveFlagRun( "apotheosis_fire_lukki_boss_summoned" )
end