
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")
local iframes_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")

local angle = math.atan2(targ_y, targ_x)
local acidspit_cooldown_duration = 18 * 60
local current_frame = GameGetFrameNum()

function Stage1()
    --Disable the barrage lua script
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
end

function Stage2()

    --Set to normal speed and wait for next attack opportunity
	ComponentSetValue2( wormAiComp, "speed", 4 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 4 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.05 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.05 )    
end

function Stage3()
    --Slow down the worm for the upcoming barrage

	ComponentSetValue2( wormAiComp, "speed", 2 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 2 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.00001 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.00001 )    
end

function Stage4()
    --Enables barrage lua script
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)

    --GameShootProjectile(entity_id, pos_x, pos_y, pos_x + targ_x, pos_y + targ_y, EntityLoad("data/entities/animals/worm_hell_big/projectiles/liquidsphere_lava.xml", pos_x, pos_y))

	--ComponentSetValue2( wormAiComp, "speed", 6 )
	--ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
	--ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
	--ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )    
end

function Stage5()
    --Allow the worm to speed back up
	ComponentSetValue2( wormAiComp, "speed", 6 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 8 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.04 )    
end

local cooldown_frame
local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
for k=1,#variablecomp
do local v = variablecomp[k]
    if ComponentGetValue2(v,"name") == "basic_ai" then
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
        ComponentSetValue2( variablecomp, "value_int", current_frame + 1200 )
        ComponentSetValue2( variablecomp, "value_float", 3 )
        Stage2()
    elseif (current_frame >= cooldown_frame) and laser_stage == 3 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 4 )
        Stage3()
    elseif (current_frame >= cooldown_frame) and laser_stage == 4 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 420 )
        ComponentSetValue2( variablecomp, "value_float", 5 )
        Stage4()
    elseif (current_frame >= cooldown_frame) and laser_stage == 5 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 1 )
        Stage5()
    end
end




--Worm Laser "AI" explanation
-- 1. begin emitting particles/fake laser from the worm's head, in the direction it's moving
-- 2. begin slowing the worm down and intensify beam particles
-- 3. 0.5-1 seconds later, unleash a massive powerful laser beam
-- 4. After 2-3 seconds pass, disable the laser beam and give the worm it's normal movement back, but potentially disengage with the player
-- 5. After the cooldown finishes, chase after the player again



--Keeps worm focused on the player
--Ticks down iframes counter
local player_id = EntityGetWithTag("player_unit")[1] or 0
if player_id ~= 0 then
    ComponentSetValue2(wormAiComp,"mTargetEntityId",player_id)
    local iframes = ComponentGetValue2(iframes_comp,"value_int")
    ComponentSetValue2(iframes_comp,"value_int",iframes - 1)
end

