
function FreedomFalse() --Forces camera onto player
    GameSetCameraFree(false)
end

function FreedomTrue()  --Lets camera roam freely, can be manipulated by wasd
    GameSetCameraFree(true)
end

function SetCamPos00()  --Forces the camera to center on 0,0, will snap back to player if Freedom is set to false
    GameSetCameraPos(0,0)
end

function PlayerCamControlsFalse()   --Disables camera locking onto player
    local player = EntityGetWithTag("player_unit")[1]
    local comp = EntityGetFirstComponentIncludingDisabled(player,"PlatformShooterPlayerComponent")
    ComponentSetValue2(comp,"center_camera_on_this_entity",false)
end

function PlayerCamControlsTrue()   --Enables camera locking onto player
    local player = EntityGetWithTag("player_unit")[1]
    local comp = EntityGetFirstComponentIncludingDisabled(player,"PlatformShooterPlayerComponent")
    ComponentSetValue2(comp,"center_camera_on_this_entity",true)
end
