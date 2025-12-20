
--dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
local entity_id = GetUpdatedEntityID()
local i_x, i_y = EntityGetTransform(entity_id)
local root = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local cooldown_frames = 25
--I didn't like the inconsistency felt when cooldown scaled off of the wand recharge speed. I prefer the feeling of a consistent right click to teleport every 0.75 seconds
--local cooldown_frames = wand.rechargeTime
--if cooldown_frames <= 20 then cooldown_frames = 20 end
--if cooldown_frames >= 45 then cooldown_frames = 45 end
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local hotspotcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "HotspotComponent")
local offset_x, offset_y = ComponentGetValue2(hotspotcomp,"offset")
local cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
local uses = ComponentGetValue2(variablecomp, "value_float")
local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
local fire_button = ComponentGetValue2(controlscomp,"mButtonDownFire")
local uses_to_reveal = 50

if GameGetFrameNum() >= cooldown_frame and GameIsInventoryOpen() == false then
    if fire_button then
        GameShootProjectile(root, i_x, i_y, i_x+aim_x*20, i_y+aim_y*20, EntityLoad("mods/Apotheosis/files/entities/projectiles/laser_purple.xml", i_x, i_y))
        ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
        if uses >= uses_to_reveal then
            if uses == uses_to_reveal then
                local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
                ComponentSetValue2(item_comp, "ui_description", "$item_apotheosis_pity_desc_upgrade")
                ComponentSetValue2( variablecomp, "value_float", uses + 1)
            end
        else
            ComponentSetValue2( variablecomp, "value_float", uses + 1)
        end

        if ModIsEnabled("quant.ew") then
            CrossCall("apoth_ew_alt_fire", root, i_x, i_y, i_x+aim_x*20, i_y+aim_y*20, "mods/Apotheosis/files/entities/projectiles/laser_purple.xml")
        end
    end
end