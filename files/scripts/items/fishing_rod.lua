
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local root = EntityGetRootEntity(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
local cooldown_frames = 60
local cooldown_frame
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )

if GameGetFrameNum() >= cooldown_frame then
    if ComponentGetValue2(controlscomp, "mButtonDownLeftClick") then
        --Detected cast/reel attempt
        local activebobber = EntityGetWithName("Fishing Hook")
        if activebobber ~= 0 then
            --Reel existing bobber in
            EntityKill(activebobber)
            ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + 10 )
        else
            --Cast new bobber
            local proj_id = EntityLoad("mods/apotheosis/files/entities/projectiles/fishing/fishing_bobber.xml", x, y)
            GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+(aim_y - 0.1)*20, proj_id)
            ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(proj_id,"VariableStorageComponent"),"value_int",entity_id)
            ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
            
            GamePlaySound( "data/audio/Desktop/animals.bank", "animals/generic/jump", x, y )
        end
    end
end
