
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
local cooldown_frames = 90
local cooldown_frame
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")

if GameGetFrameNum() >= cooldown_frame then
	if isButtonDown("altfire") then
		GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_red_marker.xml", x, y))
		ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
		if ModIsEnabled("quant.ew") then
			CrossCall("apoth_ew_alt_fire", root, x, y, aim_x, aim_y, "mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_red_marker.xml")
		end
	elseif ComponentGetValue2(controlscomp, "mButtonDownFire") and EntityGetName(EntityGetParent(entity_id))=="inventory_quick" then
		GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_red_portal.xml", x, y))
		ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
		if ModIsEnabled("quant.ew") then
			CrossCall("apoth_ew_alt_fire", root, x, y, aim_x, aim_y, "mods/Apotheosis/files/entities/projectiles/deck/markerportals/portal_red_portal.xml")
		end
	end
end