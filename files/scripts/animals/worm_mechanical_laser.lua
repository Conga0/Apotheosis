
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")

local angle = math.atan2(targ_y, targ_x)
local laser_cooldown_duration = 15 * 60
local current_frame = GameGetFrameNum()

--GamePrint("Angle is " .. angle)

function UpdateLaserData(action,key,value)
    local laserComps = EntityGetComponentIncludingDisabled(entity_id,"LaserEmitterComponent")
    for k=1,#laserComps
    do local v = laserComps[k]
        if action == "object" then
            ComponentObjectSetValue2( v, "laser", key, value)
        else
            ComponentSetValue2( v, key, value )
        end
    end
end

local laserComp = EntityGetFirstComponentIncludingDisabled(entity_id,"LaserEmitterComponent")
UpdateLaserData( "value", "laser_angle_add_rad", angle)

function Stage1()
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)
end

function Stage2()
    UpdateLaserData( "value", "is_emitting", true )
    UpdateLaserData( "object", "beam_radius", 4.5 )
    UpdateLaserData( "object", "damage_to_entities", 0 )
    UpdateLaserData( "object", "damage_to_cells", 10 )
    UpdateLaserData( "object", "max_cell_durability_to_destroy", 2 )
    UpdateLaserData( "object", "audio_enabled", false )

	ComponentSetValue2( wormAiComp, "speed", 1 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 1 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.00001 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.00001 )    
end

function Stage3()
    UpdateLaserData( "object", "beam_radius", 10.5 )
    UpdateLaserData( "object", "damage_to_entities", 0.10 )
    UpdateLaserData( "object", "damage_to_cells", 100000 )
    UpdateLaserData( "object", "max_cell_durability_to_destroy", 15 )
    UpdateLaserData( "object", "audio_enabled", true )
end

function Stage4()
    UpdateLaserData( "value", "is_emitting", false )
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)

	ComponentSetValue2( wormAiComp, "speed", 6 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )    
end

local cooldown_frame
local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
for k=1,#variablecomp
do local v = variablecomp[k]
    if ComponentGetValue2(v,"name") == "laser_cooldown" then
        variablecomp = v
        break
    end
end
cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
laser_stage = ComponentGetValue2( variablecomp, "value_float" )
--GamePrint("My stage is " .. laser_stage)

do
    if (current_frame >= cooldown_frame) and laser_stage == 1 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 2 )
        Stage1()
    elseif (current_frame >= cooldown_frame) and laser_stage == 2 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 90 )
        ComponentSetValue2( variablecomp, "value_float", 3 )
        GamePlaySound( "data/audio/Desktop/misc.bank", "misc/beam_from_sky_start", pos_x, pos_y )
        Stage2()
    elseif (current_frame >= cooldown_frame) and laser_stage == 3 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 270 )
        ComponentSetValue2( variablecomp, "value_float", 4 )
        Stage3()
    elseif (current_frame >= cooldown_frame) and laser_stage == 4 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + laser_cooldown_duration )
        ComponentSetValue2( variablecomp, "value_float", 1 )
        Stage4()
    end
end




--Worm Laser "AI" explanation
-- 1. begin emitting particles/fake laser from the worm's head, in the direction it's moving
-- 2. begin slowing the worm down and intensify beam particles
-- 3. 0.5-1 seconds later, unleash a massive powerful laser beam
-- 4. after 2-3 seconds pass, disable the laser beam and give the worm it's normal movement back
