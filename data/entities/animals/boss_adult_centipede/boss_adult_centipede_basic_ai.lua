
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")
local targ_x, targ_y = ComponentGetValue2(wormComp,"mTargetVec")

local angle = math.atan2(targ_y, targ_x)
local acidspit_cooldown_duration = 15 * 60
local current_frame = GameGetFrameNum()

function CrackEggs(table)

    local angle_inc = ( 2 * 3.14159 ) / how_many
    local theta = 0
    local length = 400

    for i=1,12 do
        local vel_x = math.cos( theta ) * length
        local vel_y = math.sin( theta ) * length
        theta = theta + angle_inc
    
        shoot_projectile( entity_id, "data/entities/animals/boss_adult_centipede/projectiles/mass_status_charm_effect.xml", pos_x, pos_y, vel_x, vel_y )
    end

    for z=1,#table
    do local c = table[z]
        local ant_x, ant_y = EntityGetTransform(c)
        local options = { "ant.xml", "ant_fire.xml", "ant_suffocate.xml", }
        SetRandomSeed(pos_x, pos_y)
        local output = options[Random(1,#options)]
    
        EntityKill(c)
        EntityLoad("data/entities/animals/" .. output, pos_x, pos_y)
        GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/egg/hatch", pos_x, pos_y );
    end
end


function Stage1()
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)
end

function Stage2()

	ComponentSetValue2( wormAiComp, "speed", 4 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 4 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.05 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.05 )    
end

function Stage3()
    --Enable Acid Burst
    --EntitySetComponentsWithTagEnabled(entity_id,"lurker_data",true)

	ComponentSetValue2( wormAiComp, "speed", 4 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 4 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.00001 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.00001 )    
end

function Stage4()
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)

    --Disable Acid Burst
    --EntitySetComponentsWithTagEnabled(entity_id,"lurker_data",false)
    local eggs = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "homing_target")
    local ant_eggs = {}
    for k=1,#eggs
    do local v = eggs[k]
        if EntityGetName(v) == "Ant Egg" then
            table.insert(ant_eggs,v)
        end
    end

    --If more than 8 ant eggs are nearby, instantly open them all
    --Otherwise, shoot an acidic sphere that homes onto the player
    if #ant_eggs > 8 then
        CrackEggs(ant_eggs)
    else
        GameShootProjectile(entity_id, pos_x, pos_y, pos_x + targ_x, pos_y + targ_y, EntityLoad("data/entities/animals/boss_adult_centipede/projectiles/liquidsphere_acid.xml", pos_x, pos_y))
    end

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



--Keeps worm focused on the player if they're their target
if ComponentGetValue2( variablecomp, "value_string" ) == "player" then
    local player_id = EntityGetWithTag("player_unit")[1]
    if EntityHasTag(player_id,"mortal") then
        ComponentSetValue2(wormAiComp,"mTargetEntityId",player_id)
        --GamePrint("Test 1")
    else
        ComponentSetValue2( variablecomp, "value_string", "null" )
        --GamePrint("Test 2")
    end
else
    local target_id = ComponentGetValue2(wormAiComp,"mTargetEntityId")
    if EntityHasTag(target_id,"player_unit") then
        ComponentSetValue2( variablecomp, "value_string", "player" )
        --GamePrint("Test 3")
    end
end
