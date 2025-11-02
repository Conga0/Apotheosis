dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

entity_id = GetUpdatedEntityID()
local pos_x,pos_y,rotation,scale_x,scale_y = EntityGetTransform(entity_id)
local book_attack_state_timeout = 1800 --If the book is in its attack state for longer than 30 seconds, tell it to close

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

--Optimise this lmao
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
local burst_wait_between = ComponentGetValue2(find_vsc("cooldown_data_3"),"value_int")
local attacks_remaining_in_this_burst = ComponentGetValue2(find_vsc("cooldown_data_3"),"value_float")
local spin_speed = ComponentGetValue2(find_vsc("cooldown_data_2"),"value_float") or 0.0
local bias_data = ComponentGetValue2(find_vsc("cooldown_data_2"),"value_string") or "0,0"
local target_last_pos = ComponentGetValue2(find_vsc("targetting_data"),"value_string") or "0,0"
local needs_target_entity = ComponentGetValue2(find_vsc("targetting_data"),"value_bool")
if bias_data ~= "0,0" then bias_data = SplitStringOnCharIntoTable(bias_data, ",") if math.abs(rotation) > (math.pi / 2) then bias_data[1] = bias_data[1] * -1 end end
if target_last_pos ~= "0,0" then target_last_pos = SplitStringOnCharIntoTable(target_last_pos, ",") end


--Manually handle visual rotation
local rotation_goal = 0
local animalAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
local current_target = ComponentGetValue2(animalAiComp,"mGreatestPrey") or ComponentGetValue2(animalAiComp,"mGreatestThreat") or 0
if EntityGetIsAlive(current_target) == false and current_target ~= 0 then current_target = 0 ComponentSetValue2(find_vsc("targetting_data"),"value_string","0,0") end

local ctarg_x,ctarg_y = 0,0
if current_target ~= 0 then
    ctarg_x,ctarg_y = EntityGetTransform(current_target)
    ComponentSetValue2(find_vsc("targetting_data"),"value_string",table.concat({ctarg_x,",",ctarg_y}))
elseif type(target_last_pos) == "table" then
    ctarg_x = target_last_pos[1]
    ctarg_y = target_last_pos[2]
end

if (ctarg_x ~= 0 and ctarg_y ~= 0) or rotation ~= 0 then
    if type(bias_data) == "table" then ctarg_x = ctarg_x + bias_data[1] ctarg_y = ctarg_y + bias_data[2] end
    if (ctarg_x ~= 0 and ctarg_y ~= 0) then rotation_goal = math.atan2( ( ctarg_y - pos_y ), ( ctarg_x - pos_x ) ) end
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
    for k=1,#attack_options do
        if attack_options[k].name == attack_name then
            if (attack_options[k].attacks_in_this_burst or 0) > 0 then
                if attacks_remaining_in_this_burst > 1 then
                    ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_options[k].after_attack_delay)
                    ComponentSetValue2(find_vsc("cooldown_data_3"),"value_float",attacks_remaining_in_this_burst - 1)
                else
                    ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_options[k].burst_wait_between)
                    ComponentSetValue2(find_vsc("cooldown_data_3"),"value_float",attack_options[k].attacks_in_this_burst)
                    ComponentSetValue2(find_vsc("cooldown_data_2"),"value_int",attacks_in_this_cycle - 1)
                end
            else
                ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_options[k].after_attack_delay)
                ComponentSetValue2(find_vsc("cooldown_data_2"),"value_int",attacks_in_this_cycle - 1)
            end

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

                local proj_filepath = ""
                if type(attack_options[k].filepath) == "string" then
                    proj_filepath = attack_options[k].filepath
                else
                    proj_filepath = attack_options[k].filepath[math.random(1,#attack_options[k].filepath)]
                end

                if attack_options[k].continous_warning ~= true then
                    EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
                end
            
                local pid = shoot_projectile( entity_id, proj_filepath, pos_x, pos_y, vel_x, vel_y )
                if attack_options[k].extra_func then
                    attack_options[k].extra_func(pid,current_target)
                end
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
    elseif current_target ~= 0 or ((ctarg_x ~= 0 and ctarg_y ~= 0) and needs_target_entity == false) then
        run_attack(attack)
    end
end

if book_timer <= 0 or (open_state == 3 and current_target == 0 and needs_target_entity == true) then
    if open_state == 0 and current_target ~= 0 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","openning")
        ComponentSetValue2(find_vsc("open_status"),"value_float",36)
        ComponentSetValue2(find_vsc("open_status"),"value_int",1)
    elseif open_state == 1 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","open")
        ComponentSetValue2(find_vsc("open_status"),"value_float",book_attack_state_timeout)
        ComponentSetValue2(find_vsc("open_status"),"value_int",3)
        local new_attack = select_new_attack()
        if new_attack.give_warning == true then
            EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )
        end
        ComponentSetValue2(find_vsc("cooldown_data_2"),"value_float",new_attack.spin_speed or 0)
        ComponentSetValue2(find_vsc("cooldown_data_2"),"value_string",table.concat({new_attack.bias_x or 0,",",new_attack.bias_y or 0}))
        ComponentSetValue2(find_vsc("cooldown_data_3"),"value_int",new_attack.burst_wait_between or 0)
        ComponentSetValue2(find_vsc("cooldown_data_3"),"value_float",new_attack.attacks_in_this_burst or 0)
        ComponentGetValue2(find_vsc("targetting_data"),"value_bool",new_attack.extra_func ~= nil)

        --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", true)
    elseif open_state == 3 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","closing")
        ComponentSetValue2(find_vsc("open_status"),"value_float",32)
        ComponentSetValue2(find_vsc("open_status"),"value_int",2)
        ComponentSetValue2(find_vsc("cooldown_data_2"),"value_float",0.0)
        ComponentSetValue2(find_vsc("cooldown_data_2"),"value_string","0,0")
        ComponentSetValue2(find_vsc("cooldown_data_3"),"value_int",0)
        ComponentSetValue2(find_vsc("cooldown_data_3"),"value_float",0)
        EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
        --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", false)
        ComponentSetValue2(find_vsc("targetting_data"),"value_string","0,0")
    else
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","closed")
        ComponentSetValue2(find_vsc("open_status"),"value_float",180 + math.random(-18,18))
        ComponentSetValue2(find_vsc("open_status"),"value_int",0)
    end
end
