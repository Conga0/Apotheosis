dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local arm_id = EntityGetAllChildren(entity_id)[1]
local arm_joint_id = EntityGetAllChildren(entity_id)[2]
local pos_x, pos_y = EntityGetTransform(entity_id)
local armjoint_x, armjoint_y = EntityGetTransform(arm_joint_id)
local arm_x, arm_y, arm_rotation, arm_scale_x, arm_scale_y = EntityGetTransform(arm_id)

local vsc_comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local state_data = vsc_comps[1]
local target_data = vsc_comps[2]
local attack_data_1 = vsc_comps[3]
local attack_data_2 = vsc_comps[4]
local death_data = vsc_comps[5]
local teleportation_data = vsc_comps[6]

--State data
local state = ComponentGetValue2(state_data,"value_int")
local sub_state = ComponentGetValue2(state_data,"value_float")

--Targetting data
local current_target = ComponentGetValue2(target_data,"value_int")
local ctarg_x,ctarg_y = 0,0
local target_last_pos = ComponentGetValue2(target_data,"value_string") or "0,0"
if target_last_pos ~= "0,0" then target_last_pos = SplitStringOnCharIntoTable(target_last_pos, ",") end
local default_rotation = 0
local rotation_goal = default_rotation
local default_rotation_speed = 0.06
local arm_offset_x = -3 --Need to manually set arm offset here since its position is set each frame via the rotation script
local arm_offset_y = -3
local tele_distance_from_target = 128

--Attack data
local current_frame = GameGetFrameNum()
attack_data = {
    attacks_remaining_in_this_cycle = ComponentGetValue2(attack_data_1,"value_int"),
    bursts_remaining_in_this_cycle = ComponentGetValue2(attack_data_1,"value_float"),
    attack_tbl_id = tonumber(ComponentGetValue2(attack_data_1,"name")),
    attack_id = tonumber(ComponentGetValue2(attack_data_1,"value_string")),
    next_attack_frame = ComponentGetValue2(attack_data_2,"value_int"),
    previous_attack = ComponentGetValue2(attack_data_2,"value_string"),
    --needs_target_entity = ai_data[attack_data.attack_tbl_id].attack_options[attack_data.attack_id].extra_func ~= nil,
    --attack_data_table = ai_data[attack_data.attack_tbl_id].attack_options[attack_data.attack_id],
}
attack_data.needs_target_entity = ai_data[attack_data.attack_tbl_id].attack_options[attack_data.attack_id].extra_func ~= nil
attack_data.attack_data_table = ai_data[attack_data.attack_tbl_id].attack_options[attack_data.attack_id]

--Teleportation data
local next_teleport_frame = ComponentGetValue2(teleportation_data,"value_int")
local teleportation_cooldown = 1200

--Health data
local damage_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(damage_comp,"hp")
local hp_max = ComponentGetValue2(damage_comp,"max_hp")
local hp_percent = hp / hp_max

--Misc data
local wait_between_attack_subphases = 120
local finish_idle_state_frame = tonumber(ComponentGetValue2(attack_data_2,"name"))

--Fire a machinegun of phase bolts
--Puppeter wands remotely
--Fire a ring of bolt orbs outwards
--Fire out a bomb that explodes after a long delay
--Teleport away from the player in a random direction 1000 pixels away to escape, create a pixel scene with a phase 2 witch at its location
---If it takes the player longer than 5 minutes to find it, the witch will have fully healed
--
--Arm on witch aims towards target coordinates?

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

function lerp(a, b, weight)
	return a * weight + b * (1 - weight)
end

local state_options = {
    combat_phase_1 = 0,
    combat_phase_2 = 1,
    death_animation = 2,
}

local sub_state_options = {
    idle=0,
    attacking=1
}

function scanForTarget()
    --Get a target
    local animal_ai_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
    current_target = ComponentGetValue2(animal_ai_comp,"mGreatestPrey") or ComponentGetValue2(animal_ai_comp,"mGreatestThreat") or 0
    if EntityGetIsAlive(current_target) == false and current_target ~= 0 then current_target = 0 ComponentSetValue2(target_data,"value_string","0,0") end

    --Set current target coordinates x&y position
    if current_target ~= 0 then
        ctarg_x,ctarg_y = EntityGetTransform(current_target)
        ComponentSetValue2(target_data,"value_string",table.concat({ctarg_x,",",ctarg_y}))
    elseif type(target_last_pos) == "table" then
        ctarg_x = target_last_pos[1]
        ctarg_y = target_last_pos[2]
    end

    local spin_speed = attack_data.attack_data_table.spin_speed or 0
    local new_rotation = arm_rotation

    --Update arm rotation to aim towards target coordinates
    if (ctarg_x ~= 0 and ctarg_y ~= 0) or arm_rotation ~= default_rotation then
        ctarg_x = ctarg_x + (ai_data[attack_data.attack_tbl_id].attack_options[attack_data.attack_id].bias_x or 0)
        ctarg_y = ctarg_y + (ai_data[attack_data.attack_tbl_id].attack_options[attack_data.attack_id].bias_y or 0)
        if (ctarg_x ~= 0 and ctarg_y ~= 0) then rotation_goal = math.atan2( ( ctarg_y - arm_y ), ( ctarg_x - arm_x ) ) end
        if spin_speed ~= 0 then rotation_goal = arm_rotation + spin_speed end
        local rotate_speed = (spin_speed ~= 0.0 and spin_speed) or default_rotation_speed
        new_rotation = rotateTo(arm_rotation, rotation_goal, rotate_speed)

        arm_scale_x = 1
        if math.abs(new_rotation) > (math.pi / 2) then
            arm_scale_y = -1
            arm_offset_x = arm_offset_x * -1
        else
            arm_scale_y = 1
        end
    end
    EntitySetTransform(arm_id, armjoint_x, armjoint_y, new_rotation, arm_scale_x, arm_scale_y)
end

function updateWandGraphic(wand_sprite_filepath,particle_name)
    local particle_name = particle_name or "spark_white"
    local wand_sprite_comp = EntityGetFirstComponentIncludingDisabled(EntityGetAllChildren(arm_id)[1],"SpriteComponent")
    ComponentSetValue2(wand_sprite_comp,"image_file",wand_sprite_filepath)
    EntityRefreshSprite( arm_id, wand_sprite_comp )

    --Play musical flair & emit particles
    GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/spiral_shot/create", pos_x, pos_y )
    local eid = EntityLoad("data/entities/animals/witch_miniboss/wand_graphics/wand_change_particles.xml", pos_x, pos_y)
    local particle_comp = EntityGetFirstComponentIncludingDisabled(eid,"ParticleEmitterComponent")
    ComponentSetValue2(particle_comp,"emitted_material_name",particle_name)
end

function setEntityImmobile()
    local platforming_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"CharacterPlatformingComponent")
    ComponentSetValue2(platforming_comp,"fly_speed_mult",0)
    ComponentSetValue2(platforming_comp,"fly_velocity_x",0)
    ComponentSetValue2(platforming_comp,"fly_speed_change_spd",0)
    ComponentSetValue2(platforming_comp,"velocity_min_x",0)
    ComponentSetValue2(platforming_comp,"velocity_max_x",0)
    ComponentSetValue2(platforming_comp,"velocity_min_y",0)
    ComponentSetValue2(platforming_comp,"velocity_max_y",0)

    
end

function setTeleportLocation()
    SetRandomSeed(pos_x+current_frame,pos_y)
    if EntityGetIsAlive(current_target) == false and current_target ~= 0 then return end
    local t_x,t_y = EntityGetTransform(current_target)
    local angle = math.rad(Random(0,359))

    local did_hit = false
	local tele_x = t_x + math.cos( angle ) * tele_distance_from_target
	local tele_y = t_y - math.sin( angle ) * tele_distance_from_target

    did_hit, tele_x, tele_y = RaytracePlatforms( t_x, t_y, tele_x, tele_y )

    local eid = EntityLoad("data/entities/animals/witch_miniboss/misc/teleport_indicator.xml",tele_x,tele_y)
    local tele_vsc = EntityGetFirstComponentIncludingDisabled(eid,"VariableStorageComponent")
    ComponentSetValue2(tele_vsc,"value_int",entity_id)

    --Teleport indication
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use", tele_x, tele_y )
    local eid = EntityLoad("data/entities/animals/witch_miniboss/wand_graphics/wand_change_particles.xml", tele_x, tele_y)
    local particle_comp = EntityGetFirstComponentIncludingDisabled(eid,"ParticleEmitterComponent")
    ComponentSetValue2(particle_comp,"emitted_material_name","magic_liquid_teleportation")

    --Set teleport CD
    ComponentSetValue2(teleportation_data,"value_int",current_frame + teleportation_cooldown)
end


--Phase 0 idle state
--Phase 1 attacking state

--This handles firing projectiles
----------------------------------------------------------------------------------------------
--This is where I'm leaving off for today
--Read through the logic to make sure everything makes sense
--Use this opportunity to make bursts less weird to understand
----------------------------------------------------------------------------------------------
--4 Burst repeated 3 times
--shoot
--burst wait
--shoot
--burst wait
--shoot
--burst wait
--shoot
--after attack delay
--shoot
--burst wait
--shoot
--burst wait
--shoot
--burst wait
--shoot
--after attack delay
--shoot
--burst wait
--shoot
--burst wait
--shoot
--burst wait
--shoot
--after attack delay
----------------------------------------------------------------------------------------------
function run_attack()
    if (attack_data.attack_data_table.attacks_in_this_burst or 0) > 0 then
        if attack_data.bursts_remaining_in_this_cycle > 1 then
            ComponentSetValue2(attack_data_2,"value_int",current_frame + attack_data.attack_data_table.burst_wait_between)
            ComponentSetValue2(attack_data_1,"value_float",attack_data.bursts_remaining_in_this_cycle - 1)
        else
            ComponentSetValue2(attack_data_2,"value_int",current_frame + attack_data.attack_data_table.after_attack_delay)
            ComponentSetValue2(attack_data_1,"value_float",attack_data.attack_data_table.attacks_in_this_burst)
            ComponentSetValue2(attack_data_1,"value_int",attack_data.attacks_remaining_in_this_cycle - 1)
        end
    else
        ComponentSetValue2(attack_data_2,"value_int",current_frame + attack_data.attack_data_table.after_attack_delay)
        ComponentSetValue2(attack_data_1,"value_int",attack_data.attacks_remaining_in_this_cycle - 1)
    end

    SetRandomSeed(pos_x+GameGetFrameNum(),pos_y+arm_y)
    local wand_tip = EntityGetAllChildren(EntityGetAllChildren(arm_id)[1])[1]
    local tip_x, tip_y = EntityGetTransform(wand_tip)

    for z=1,Random(attack_data.attack_data_table.count_min,attack_data.attack_data_table.count_max) do
        SetRandomSeed(z+pos_x+GameGetFrameNum(),pos_y+z)

        local firing_angle = arm_rotation + math.rad(Random( -attack_data.attack_data_table.random_spread, attack_data.attack_data_table.random_spread ) / 2)


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
    
        local pid = shoot_projectile( entity_id, proj_filepath, tip_x, tip_y, vel_x, vel_y )
        if attack_data.attack_data_table.extra_func then
            attack_data.attack_data_table.extra_func(pid,current_target)
        end
        local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
        if projcomp ~= nil then
            local genome_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"GenomeDataComponent")
            ComponentSetValue2(projcomp, "mShooterHerdId", ComponentGetValue2(genome_comp,"herd_id"))
        end
    end
end

function reset_attack_data()
    --ComponentSetValue2(attack_data_1,"name","0") --attack table id
    ComponentSetValue2(attack_data_1,"value_int",0)
    ComponentSetValue2(attack_data_1,"value_float",0)
    ComponentSetValue2(attack_data_1,"value_string","0")
    
    --ComponentSetValue2(attack_data_2,"name","0") --Wait between attack phases
    ComponentSetValue2(attack_data_2,"value_int",0)
    ComponentSetValue2(attack_data_2,"value_float",0)
    --ComponentSetValue2(attack_data_2,"value_string","0") --Previously used attack
end

function decide_next_attack()
    local attack_options = ai_data[attack_data.attack_tbl_id].attack_options
    local rng = math.random(1,#attack_options)
    local new_attack = attack_options[rng]

    math.randomseed(GameGetFrameNum())
    if new_attack.name == attack_data.previous_attack then
        local recurse_limit = 20
        while new_attack.name == attack_data.previous_attack and recurse_limit >= 1 do
            rng = math.random(1,#attack_options)
            new_attack = attack_options[rng]
            recurse_limit = recurse_limit - 1
        end
    end

    ComponentSetValue2(attack_data_1,"value_int",new_attack.attacks_in_this_cycle)
    ComponentSetValue2(attack_data_1,"value_float",new_attack.attacks_in_this_burst or 0)
    ComponentSetValue2(attack_data_1,"value_string",rng)
    ComponentSetValue2(attack_data_2,"value_int",new_attack.after_attack_delay)
    ComponentSetValue2(attack_data_2,"value_string",new_attack.name)

    updateWandGraphic(new_attack.wandsprite_filepath,new_attack.particle_to_emit_on_swap)
end





--This handles attack updates
function runAttackUpdate()
    if current_frame >= attack_data.next_attack_frame and sub_state == sub_state_options.attacking then
        if attack_data.attacks_remaining_in_this_cycle <= 0 then
            ComponentSetValue2(attack_data_2,"name",tostring(current_frame+wait_between_attack_subphases))
            ComponentSetValue2(state_data,"value_float",sub_state_options.idle)

            reset_attack_data()
            decide_next_attack()
        elseif current_target ~= 0 or ((ctarg_x ~= 0 and ctarg_y ~= 0) and attack_data.needs_target_entity == false) then
            run_attack()
        end
    elseif sub_state == sub_state_options.idle then
        if current_frame >= finish_idle_state_frame and current_target ~= 0 then
            ComponentSetValue2(state_data,"value_float",sub_state_options.attacking)
        end
    end
end

--This handles what phase the boss is in
function runAIUpdate()
    scanForTarget()
    if state == state_options.combat_phase_1 then
        runAttackUpdate()
        if hp_percent <= 0.55 then
            --Enter phase 2 ewewewewewewe
            ComponentSetValue2(attack_data_2,"name",tostring(current_frame+wait_between_attack_subphases))
            ComponentSetValue2(state_data,"value_float",sub_state_options.idle)

            ComponentGetValue2(attack_data_1,"value_string","1")
            ComponentSetValue2(attack_data_1,"name","2")
            attack_data.attack_tbl_id = 2
            
            GamePlaySound( "data/audio/Desktop/animals.bank", "failed_alchemist_damage_01", pos_x, pos_y )

            reset_attack_data()
            decide_next_attack()

            ComponentSetValue2(state_data,"value_int",state_options.combat_phase_2)
        end
    elseif state == state_options.combat_phase_2 then
        runAttackUpdate()
        if current_target ~= 0 and (current_frame >= next_teleport_frame) then setTeleportLocation() end

        if hp_percent <= 0.00 then
            --Enter death phase ewewewewewewe
            ComponentSetValue2(attack_data_2,"name",tostring(current_frame+wait_between_attack_subphases))
            ComponentSetValue2(state_data,"value_float",sub_state_options.idle)

            ComponentGetValue2(attack_data_1,"value_string","1")
            ComponentSetValue2(attack_data_1,"name","2")

            ComponentSetValue2(state_data,"value_int",state_options.death_animation)

            --Initialise death data
            ComponentSetValue2(death_data,"value_int",current_frame)

            local sprite_comps = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent")
            for k=1,#sprite_comps do
                ComponentRemoveTag(sprite_comps[k],"character")
                ComponentSetValue2(sprite_comps[k],"rect_animation","death")
            end

            local arm_sprite_comp = EntityGetFirstComponentIncludingDisabled(arm_id,"SpriteComponent")
            ComponentSetValue2(arm_sprite_comp,"alpha",0.0)

            local wand_sprite_comp = EntityGetFirstComponentIncludingDisabled(EntityGetAllChildren(arm_id)[1],"SpriteComponent")
            ComponentSetValue2(wand_sprite_comp,"alpha",0.0)

            local hitbox_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"HitboxComponent")
            EntitySetComponentIsEnabled( entity_id, hitbox_comp, false )
            
            GamePlaySound( "data/audio/Desktop/animals.bank", "animals/enlightened_alchemist/death", pos_x, pos_y )

            setEntityImmobile()
        end
    elseif state == state_options.death_animation then
        --Death animation
        local death_init_frame = ComponentGetValue2(death_data,"value_int")

        --Kill the alchemist & convert his body into a crystallized meat
        --The death animation takes 36 frames to finish
        if current_frame >= death_init_frame + 36 then 
            ComponentSetValue2(damage_comp,"kill_now",true)
            StatsLogPlayerKill( entity_id ) --Be sure to log the entity's death in the progress log
            EntityConvertToMaterial( entity_id, "apotheosis_meat_wand_tinkering", false, false )
            local currbiome = BiomeMapGetName( pos_x, pos_y ) --Kind of simple implementation but functional, could be exploited on purpose if someone wanted the note?
            if Random(1,50) == 1 or currbiome == "$biome_snowcave" or currbiome == "$biome_lava_excavation" then EntityLoad( "mods/Apotheosis/files/entities/items/books/note_tinker_seed.xml", pos_x, pos_y ) end
            GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/create", pos_x, pos_y )
            --EntityKill( entity_id )
        end
        
    end
end

runAIUpdate()
