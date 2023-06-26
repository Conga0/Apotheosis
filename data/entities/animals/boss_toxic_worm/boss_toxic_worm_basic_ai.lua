
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")

local angle = math.atan2(targ_y, targ_x)
local acidspit_cooldown_duration = 27 * 60
local current_frame = GameGetFrameNum()
ComponentSetValue2(wormComp,"mFrameNextDamage",current_frame) --Dragon-like Mouth


function Stage1()
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)
end

function Stage2()

	ComponentSetValue2( wormAiComp, "speed", 2 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 2 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.05 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.05 )    
end

function Stage3()
    --Enable Acid Burst
    --EntitySetComponentsWithTagEnabled(entity_id,"lurker_data",true)

	ComponentSetValue2( wormAiComp, "speed", 2 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 2 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.00001 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.00001 )    
end

function Stage4()
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)

    --Disable Acid Burst
    --EntitySetComponentsWithTagEnabled(entity_id,"lurker_data",false)

    --Shoot a toxic sphere that homes onto the player
    GameShootProjectile(entity_id, pos_x, pos_y, pos_x + targ_x, pos_y + targ_y, EntityLoad("data/entities/animals/boss_toxic_worm/projectiles/liquidsphere_toxic.xml", pos_x, pos_y))

	ComponentSetValue2( wormAiComp, "speed", 4 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 5 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.003 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.035 )    
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
        ComponentSetValue2( variablecomp, "value_int", current_frame + 90 )
        ComponentSetValue2( variablecomp, "value_float", 3 )
        GamePlaySound( "data/audio/Desktop/materials.bank", "materials/laser_source", pos_x, pos_y )
        Stage2()
    elseif (current_frame >= cooldown_frame) and laser_stage == 3 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + 120 )
        ComponentSetValue2( variablecomp, "value_float", 4 )
        Stage3()
    elseif (current_frame >= cooldown_frame) and laser_stage == 4 then
        ComponentSetValue2( variablecomp, "value_int", current_frame + acidspit_cooldown_duration )
        ComponentSetValue2( variablecomp, "value_float", 1 )
        Stage4()
    end
end




--Worm Laser "AI" explanation
-- 1. begin emitting particles/fake laser from the worm's head, in the direction it's moving
-- 2. begin slowing the worm down and intensify beam particles
-- 3. 0.5-1 seconds later, unleash a massive powerful laser beam
-- 4. after 2-3 seconds pass, disable the laser beam and give the worm it's normal movement back



--Keeps worm focused on the player during the Toxic Sphere attack
if laser_stage ~= 1 then
    local player_id = EntityGetWithTag("player_unit")[1]
    if EntityHasTag(player_id,"mortal") then
        ComponentSetValue2(wormAiComp,"mTargetEntityId",player_id)
        --GamePrint("Test 1")
    end
end
