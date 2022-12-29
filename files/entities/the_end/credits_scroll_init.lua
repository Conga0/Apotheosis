dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, r = EntityGetTransform( entity_id )

EntitySetTransform( entity_id, pos_x, pos_r, r, 0.5, 0.5 )

local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteComponent" )
EntitySetComponentIsEnabled(entity_id, comp, true)

local player = EntityGetWithTag("player_unit")
for i,v in ipairs(player) do
	ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(v, "PlatformShooterPlayerComponent"), "move_camera_with_aim", false)
end
