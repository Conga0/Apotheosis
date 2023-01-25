

function portal_teleport_used( entity_that_was_teleported, from_x, from_y )

    if from_y < 1100 then -- Mines
        GameAddFlagRun("apotheosis_teleporter_secret_mines")
    elseif from_y < 2635 then -- Coal Mine
        GameAddFlagRun("apotheosis_teleporter_secret_coalmine")
    elseif from_y < 4685 then -- Snowy Depths
        GameAddFlagRun("apotheosis_teleporter_secret_snowydepths")
    elseif from_y < 6220 then -- Hiisi Base
        GameAddFlagRun("apotheosis_teleporter_secret_hiisibase")
    elseif from_y < 8270 then -- Jungle
        GameAddFlagRun("apotheosis_teleporter_secret_jungle")
    elseif from_y < 10315 then -- Vault
        GameAddFlagRun("apotheosis_teleporter_secret_vault")
    end

end