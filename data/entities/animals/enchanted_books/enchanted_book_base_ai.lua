dofile_once("data/scripts/lib/utilities.lua")

entity_id = GetUpdatedEntityID()
local pos_x,pos_y,rotation,scale_x,scale_y = EntityGetTransform(entity_id)

local function rotateTo(current, goal, maxStep)
    local function normalizeAngle(angle)
        while angle > math.pi do
            angle = angle - 2 * math.pi
        end
        while angle < -math.pi do
            angle = angle + 2 * math.pi
        end
        return angle
    end

    local diff = normalizeAngle(goal - current)

    if math.abs(diff) <= maxStep then
        return goal
    else
        return current + math.sign(diff) * maxStep
    end
end

function math.sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

function find_vsc(name)
    local vsc = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    for k=1,#vsc do
        if ComponentGetValue2(vsc[k],"name") == name then
            return vsc[k]
        end
    end
end

function lerp(a, b, weight)
	return a * weight + b * (1 - weight)
end

local open_state = ComponentGetValue2(find_vsc("open_status"),"value_int") --0 = closed, 1 = openning, 2 = closing, 3 = openned
local attack = ComponentGetValue2(find_vsc("cooldown_data"),"value_string")
local attack_timer = ComponentGetValue2(find_vsc("cooldown_data"),"value_float")
local book_timer = ComponentGetValue2(find_vsc("open_status"),"value_float")
local attacks_in_this_cycle = ComponentGetValue2(find_vsc("cooldown_data_2"),"value_int")
local spin_speed = ComponentGetValue2(find_vsc("cooldown_data_2"),"value_float") or 0.0

--Manually handle visual rotation?
local rotation_goal = 0
local animalAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
local current_target = ComponentGetValue2(animalAiComp,"mGreatestPrey") or ComponentGetValue2(animalAiComp,"mGreatestThreat") or 0

local ctarg_x,ctarg_y = EntityGetTransform(current_target)

--print(rotation)
--print(tostring(current_target))

if current_target ~= 0 or rotation ~= 0 then
    if current_target ~= 0 then rotation_goal = math.atan2( ( ctarg_y - pos_y ), ( ctarg_x - pos_x ) ) end
    if spin_speed ~= 0 then rotation_goal = rotation + spin_speed end
    local rotate_speed = (spin_speed ~= 0.0 and spin_speed) or 0.06
    local new_rotation = rotateTo(rotation, rotation_goal, rotate_speed)

    scale_x = 1
    if math.abs(new_rotation) > (math.pi / 2) then
        scale_y = -1
    else
        scale_y = 1
    end

    EntitySetTransform(entity_id,pos_x,pos_y,new_rotation,scale_x,scale_y)
end



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



if open_state == 3 then attack_timer = attack_timer - 1 end
book_timer = book_timer - 1
ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_timer)
ComponentSetValue2(find_vsc("open_status"),"value_float",book_timer)

function select_new_attack()
    local disabled_attack = ""
    for k=1,#attack_options do
        if attack_options[k].name == attack then
            disabled_attack = attack_options[k].name
            break
        end
    end

    math.randomseed(GameGetFrameNum())
    local chosen_attack = attack_options[math.random(1,#attack_options)]
    local recurse_limit = 20
    while chosen_attack.name == disabled_attack and recurse_limit >= 1 do
        chosen_attack = attack_options[math.random(1,#attack_options)]
        recurse_limit = recurse_limit - 1
    end
    attack = chosen_attack.name

    ComponentSetValue2(find_vsc("cooldown_data"),"value_string",attack)
    for k=1,#attack_options do
        if attack_options[k].name == attack then
            attacks_in_this_cycle = attack_options[k].attacks_in_this_cycle
            ComponentSetValue2(find_vsc("cooldown_data_2"),"value_int",attack_options[k].attacks_in_this_cycle)
            ComponentSetValue2(find_vsc("cooldown_data"),"value_int",(attack_options[k].attacks_in_this_cycle * (attack_options[k].after_attack_delay + 1)) - 60)
            ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_options[k].after_attack_delay)
            break
        end
    end
    
    return chosen_attack
end

function run_attack(attack_name)
    local target = current_target
    EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
    for k=1,#attack_options do
        if attack_options[k].name == attack_name then
            ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_options[k].after_attack_delay)
            ComponentSetValue2(find_vsc("cooldown_data_2"),"value_int",attacks_in_this_cycle - 1)
            SetRandomSeed(k+pos_x+GameGetFrameNum(),pos_y+k)

            for z=1,Random(attack_options[k].count_min,attack_options[k].count_max) do
                SetRandomSeed(z+pos_x+GameGetFrameNum(),pos_y+z)

                local firing_angle = rotation + math.rad(Random( -attack_options[k].random_spread, attack_options[k].random_spread ) / 2)


                local speed = attack_options[k].speed
                if attack_options[k].speed_random_mult ~= nil then
                    speed = speed * Randomf(1,attack_options[k].speed_random_mult)
                end

                local vel_x = math.cos( firing_angle ) * speed
                local vel_y = math.sin( firing_angle ) * speed
            
                local pid = shoot_projectile( entity_id, attack_options[k].filepath, pos_x, pos_y, vel_x, vel_y )
                local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
                if projcomp ~= nil then
                    ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_library"))
                end
            end
        end
    end
end

if attack_timer <= 0 and open_state == 3 then
    if attacks_in_this_cycle <= 0 then
        book_timer = 0
    elseif current_target ~= 0 then
        run_attack(attack)
    end
end

if book_timer <= 0 or (open_state == 3 and current_target == 0) then
    if open_state == 0 and current_target ~= 0 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","openning")
        ComponentSetValue2(find_vsc("open_status"),"value_float",36)
        ComponentSetValue2(find_vsc("open_status"),"value_int",1)
    elseif open_state == 1 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","open")
        ComponentSetValue2(find_vsc("open_status"),"value_float",600 + math.random(-60,60) + 99999)
        ComponentSetValue2(find_vsc("open_status"),"value_int",3)
        local new_attack = select_new_attack()
        if new_attack.give_warning == true then
            EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )
        end
        if new_attack.spin_speed then
            ComponentSetValue2(find_vsc("cooldown_data_2"),"value_float",new_attack.spin_speed)
        end
        --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", true)
    elseif open_state == 3 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","closing")
        ComponentSetValue2(find_vsc("open_status"),"value_float",32)
        ComponentSetValue2(find_vsc("open_status"),"value_int",2)
        ComponentSetValue2(find_vsc("cooldown_data_2"),"value_float",0.0)
        --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", false)
    else
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","closed")
        ComponentSetValue2(find_vsc("open_status"),"value_float",180 + math.random(-18,18))
        ComponentSetValue2(find_vsc("open_status"),"value_int",0)
    end
end
