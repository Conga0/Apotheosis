dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local pos_x,pos_y,rotation,scale_x,scale_y = EntityGetTransform(entity_id)
local book_attack_state_timeout = 1800 --If the book is in its attack state for longer than 30 seconds, tell it to close

local vsc_comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local state_data = vsc_comps[2]
local target_data = vsc_comps[3]
local attack_data_1 = vsc_comps[4]
local attack_data_2 = vsc_comps[5]

--State data
local book_states = {
    closed = 0,
    opening = 1,
    closing = 2,
    open = 3,
}
local current_state = ComponentGetValue2(state_data,"value_int")
local current_state_timer = ComponentGetValue2(state_data,"value_float")
local is_ai_disabled = ComponentGetValue2(state_data,"value_bool")

--Targetting data
local current_target = ComponentGetValue2(target_data,"value_int")
local ctarg_x,ctarg_y = 0,0
local target_last_pos = ComponentGetValue2(target_data,"value_string") or "0,0"
local default_rotation = 0
local rotation_goal = default_rotation
local default_rotation_speed = 0.06

--Attack data
local current_frame = GameGetFrameNum()
attack_data = {
    attacks_remaining_in_this_cycle = ComponentGetValue2(attack_data_1,"value_int"),
    attacks_remaining_in_this_burst = ComponentGetValue2(attack_data_1,"value_float"),
    attack_id = tonumber(ComponentGetValue2(attack_data_1,"value_string")),
    next_attack_frame = ComponentGetValue2(attack_data_2,"value_int"),
    previous_attack = ComponentGetValue2(attack_data_2,"value_string"),
}
attack_data.needs_target_entity = attack_options[attack_data.attack_id].extra_func ~= nil
attack_data.attack_data_table = attack_options[attack_data.attack_id]



function playAnimation(animation_to_play)
    local sprite_comps = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent") or {}
    for k=1,#sprite_comps do
        ComponentSetValue2(sprite_comps[k],"rect_animation",animation_to_play)
    end
end

function rotateTo(current, goal, maxStep)
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

function lerp(a, b, weight)
	return a * weight + b * (1 - weight)
end

function scanForTarget()
    --Get a target
    local animal_ai_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
    current_target = ComponentGetValue2(animal_ai_comp,"mGreatestPrey") or ComponentGetValue2(animal_ai_comp,"mGreatestThreat") or 0
    if EntityGetIsAlive(current_target) == false and current_target ~= 0 then current_target = 0 ComponentSetValue2(target_data,"value_string","0,0") end

    if current_target ~= 0 then
        ctarg_x,ctarg_y = EntityGetTransform(current_target)
        ComponentSetValue2(target_data,"value_string",table.concat({ctarg_x,",",ctarg_y}))
    elseif type(target_last_pos) == "table" then
        ctarg_x = target_last_pos[1]
        ctarg_y = target_last_pos[2]
    end

    local spin_speed = attack_data.attack_data_table.spin_speed or 0
    local new_rotation = rotation

    --Update book rotation to aim towards target coordinates
    if (ctarg_x ~= 0 and ctarg_y ~= 0) or rotation ~= default_rotation then
        if math.abs(rotation) > (math.pi / 2) then attack_options[attack_data.attack_id].bias_x = attack_options[attack_data.attack_id].bias_x or 0 * -1 end
        ctarg_x = ctarg_x + (attack_options[attack_data.attack_id].bias_x or 0)
        ctarg_y = ctarg_y + (attack_options[attack_data.attack_id].bias_y or 0)
        if (ctarg_x ~= 0 and ctarg_y ~= 0) then rotation_goal = math.atan2( ( ctarg_y - pos_y ), ( ctarg_x - pos_x ) ) end
        if spin_speed ~= 0 then rotation_goal = rotation + spin_speed end
        local rotate_speed = (spin_speed ~= 0.0 and spin_speed) or default_rotation_speed
        new_rotation = rotateTo(rotation, rotation_goal, rotate_speed)

        scale_x = 1
        if math.abs(new_rotation) > (math.pi / 2) then
            scale_y = -1
        else
            scale_y = 1
        end
    end
    EntitySetTransform(entity_id, pos_x, pos_y, new_rotation, scale_x, scale_y)
end

function reset_attack_data()
    --ComponentSetValue2(attack_data_1,"name","0") --attack table id
    ComponentSetValue2(attack_data_1,"value_int",0)         --attacks remaining in current cycle
    ComponentSetValue2(attack_data_1,"value_float",0)       --attacks remaining in current burst
    ComponentSetValue2(attack_data_1,"value_string","1")    --attack id
    
    --ComponentSetValue2(attack_data_2,"name","0") --Wait between attack phases
    ComponentSetValue2(attack_data_2,"value_int",0)         -- next attack frame
    --ComponentSetValue2(attack_data_2,"value_float",0)     -- 
    --ComponentSetValue2(attack_data_2,"value_string","0") --Previously used attack
    
    --Hide warning particles
    EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
end



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




function select_new_attack()
    --Select a random attack, will not select the same attack twice in a row

    math.randomseed(current_frame)
    local rng = math.random(1,#attack_options)
    local new_attack = attack_options[rng]
    local recurse_limit = 20
    while new_attack.name == attack_data.previous_attack and recurse_limit >= 1 do
        rng = math.random(1,#attack_options)
        new_attack = attack_options[rng]
        recurse_limit = recurse_limit - 1
    end

    --Save relevent attack data to memory
    ComponentSetValue2(attack_data_1,"value_int",new_attack.attacks_in_this_cycle)
    ComponentSetValue2(attack_data_1,"value_float",new_attack.attacks_in_this_burst or 0)
    ComponentSetValue2(attack_data_1,"value_string",rng)
    ComponentSetValue2(attack_data_2,"value_int",current_frame + new_attack.after_attack_delay)
    ComponentSetValue2(attack_data_2,"value_string",new_attack.name)

    --Enable warning visuals for powerful attacks
    if new_attack.give_warning == true then
        EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )
    end

    --Update glyph sprite inside the spellbook to match the new spell being cast
    --We'll assume the file exists in the provided directory here
    local sprite_comp_glyphs = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent")[2]
    ComponentSetValue2(sprite_comp_glyphs,"image_file",table.concat({"mods/Apotheosis/files/enemies_gfx/enchanted_book/",new_attack.name,".xml"}))
    EntityRefreshSprite(entity_id,sprite_comp_glyphs)
    
    return new_attack
end

function run_attack(attack_name)
    local target = current_target
    if (attack_data.attack_data_table.attacks_in_this_burst or 0) > 0 then
        if attack_data.attacks_remaining_in_this_burst > 1 then
            ComponentSetValue2(attack_data_2,"value_int",current_frame + attack_data.attack_data_table.burst_wait_between)
            ComponentSetValue2(attack_data_1,"value_float",attack_data.attacks_remaining_in_this_burst - 1)
        else
            ComponentSetValue2(attack_data_2,"value_int",current_frame + attack_data.attack_data_table.after_attack_delay)
            ComponentSetValue2(attack_data_1,"value_float",attack_data.attack_data_table.attacks_in_this_burst)
            ComponentSetValue2(attack_data_1,"value_int",attack_data.attacks_remaining_in_this_cycle - 1)
        end
    else
        ComponentSetValue2(attack_data_2,"value_int",current_frame + attack_data.attack_data_table.after_attack_delay)
        ComponentSetValue2(attack_data_1,"value_int",attack_data.attacks_remaining_in_this_cycle - 1)
    end

    SetRandomSeed(pos_x+current_frame,pos_y+pos_x)

    for z=1,Random(attack_data.attack_data_table.count_min,attack_data.attack_data_table.count_max) do
        SetRandomSeed(z+pos_x+current_frame,pos_y+z)

        local firing_angle = rotation + math.rad(Random( -attack_data.attack_data_table.random_spread, attack_data.attack_data_table.random_spread ) / 2)


        local speed = attack_data.attack_data_table.speed
        if attack_data.attack_data_table.speed_random_mult ~= nil then
            speed = speed * Randomf(1,attack_data.attack_data_table.speed_random_mult)
        end

        local vel_x = math.cos( firing_angle ) * speed
        local vel_y = math.sin( firing_angle ) * speed

        local proj_filepath = ""
        if type(attack_data.attack_data_table.filepath) == "string" then
            proj_filepath = attack_data.attack_data_table.filepath
        else
            proj_filepath = attack_data.attack_data_table.filepath[math.random(1,#attack_data.attack_data_table.filepath)]
        end

        if attack_data.attack_data_table.continous_warning ~= true then
            EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
        end
    
        local pid = shoot_projectile( entity_id, proj_filepath, pos_x, pos_y, vel_x, vel_y )
        if attack_data.attack_data_table.extra_func then
            attack_data.attack_data_table.extra_func(pid,current_target)
        end
        local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
        if projcomp ~= nil then
            ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_library"))
        end
    end
end

--This handles attack updates
function runAttackUpdate()
    if current_frame >= attack_data.next_attack_frame and current_state == book_states.open then
        if attack_data.attacks_remaining_in_this_cycle <= 0 then
            current_state_timer = current_frame
        elseif current_target ~= 0 or ((ctarg_x ~= 0 and ctarg_y ~= 0) and attack_data.needs_target_entity == false) then
            run_attack(attack)
        end
    end
end

function bookStateUpdate()
    if current_state_timer <= current_frame or (current_state == book_states.open and current_target == 0 and attack_data.needs_target_entity == true) then
        if current_state == book_states.closed and current_target ~= 0 then
            playAnimation("openning")
            ComponentSetValue2(state_data,"value_float",current_frame + 36)
            ComponentSetValue2(state_data,"value_int",book_states.opening)
            select_new_attack()
        elseif current_state == book_states.opening then
            playAnimation("open")
            ComponentSetValue2(state_data,"value_float",current_frame + book_attack_state_timeout)
            ComponentSetValue2(state_data,"value_int",book_states.open)

            --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", true)
        elseif current_state == book_states.open then
            playAnimation("closing")
            ComponentSetValue2(state_data,"value_float",current_frame + 32)
            ComponentSetValue2(state_data,"value_int",book_states.closing)

            reset_attack_data()
        else
            playAnimation("closed")
            ComponentSetValue2(state_data,"value_float",current_frame + 180 + math.random(-18,18)) --Some closed timing variation
            ComponentSetValue2(state_data,"value_int",book_states.closed)
        end
    end
end

--Update order
function runAIUpdate()
    if is_ai_disabled then return end
    scanForTarget()
    runAttackUpdate()
    bookStateUpdate()
end

runAIUpdate()
