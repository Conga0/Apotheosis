
local EZWand = dofile_once("mods/Apotheosis/lib/EZWand/EZWand.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local wand = EZWand(EntityGetParent(entity_id))
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
local alwayscast = ComponentGetValue2(itemcomp,"permanently_attached")
local cooldown_frames = 45
--I didn't like the inconsistency felt when cooldown scaled off of the wand recharge speed. I prefer the feeling of a consistent right click to teleport every 0.75 seconds
--local cooldown_frames = wand.rechargeTime
--if cooldown_frames <= 20 then cooldown_frames = 20 end
--if cooldown_frames >= 45 then cooldown_frames = 45 end
local cooldown_frame
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
local manacost = 80

if GameGetFrameNum() >= cooldown_frame then
    if ComponentGetValue2(controlscomp, "mButtonDownRightClick") or InputIsJoystickButtonDown(0, 26) then
        local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
        local uses = ComponentGetValue2(comp,"uses_remaining")
        if uses >= 1 or uses == -1 or alwayscast then
            local mana = wand.mana
            if (mana > manacost) then

                GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad("mods/apotheosis/files/entities/projectiles/deck/targetter.xml", x, y))
				if not HasFlagPersistent("action_apotheosis_alt_fire_targetter") then
					GameAddFlagRun("new_action_apotheosis_alt_fire_targetter")
					AddFlagPersistent("action_apotheosis_alt_fire_targetter")
				end
                wand.mana = mana - manacost
                ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
                if alwayscast == false then
                    uses = uses - 1
                    ComponentSetValue2(comp,"uses_remaining",uses)
                end
                if uses <= 0 then
                    GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/action_consumed", x, y )
                    EntityLoad("mods/apotheosis/files/entities/particles/spell_fades/targetter_fade.xml", x, y )
                end
            else
                GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y );
            end
        end
    end
end

