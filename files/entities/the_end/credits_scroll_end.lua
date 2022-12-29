dofile_once("data/scripts/lib/utilities.lua")

local player = EntityGetWithTag("player_unit")
for i,v in ipairs(player) do
	ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(v, "PlatformShooterPlayerComponent"), "move_camera_with_aim", true)
end
