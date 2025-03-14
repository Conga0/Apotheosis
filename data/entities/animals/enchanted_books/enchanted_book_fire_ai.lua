dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)

function find_vsc(name)
    local vsc = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    for k=1,#vsc do
        if ComponentGetValue2(vsc[k],"name") == name then
            return vsc[k]
        end
    end
end

local open_state = ComponentGetValue2(find_vsc("open_status"),"value_int") --0 = closed, 1 = openning, 2 = closing, 3 = openned
local attack = "firebolt"
local attack_switch_timer = ComponentGetValue2(find_vsc("cooldown_data"),"value_int")
local attack_timer = ComponentGetValue2(find_vsc("cooldown_data"),"value_float")
local book_timer = ComponentGetValue2(find_vsc("open_status"),"value_float")
local attack_opts = {"firebolt","small_sun"}
local last_attack = ""

attack_switch_timer = attack_switch_timer - 1
if open_state == 3 then attack_timer = attack_timer - 1 end
book_timer = book_timer - 1
ComponentSetValue2(find_vsc("cooldown_data"),"value_int",attack_switch_timer)
ComponentSetValue2(find_vsc("cooldown_data"),"value_float",attack_timer)
ComponentSetValue2(find_vsc("open_status"),"value_float",book_timer)

if attack_switch_timer <= 0 then
    ComponentSetValue2(find_vsc("cooldown_data"),"value_int",300)
    for k=1,#attack_opts do
        if attack_opts[k] == last_attack then
            table.remove(attack_opts,k)
            break
        end
    end

    attack = attack_opts[math.random(1,#attack_opts)]
    last_attack = attack

    --[[
    if attack == "firebolt" then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_entity_file", "data/entities/projectiles/deck/grenade.xml")
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_frames_between", 2)
    end
    ]]--
end

if attack_timer <= 0 then
    if attack == "firebolt" then
        ComponentSetValue2(find_vsc("cooldown_data"),"value_float",60)

        local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 350, "player_unit" )

        target = targets[1]
        
        
        local angle_inc = 0
        local angle_inc_set = false
        
        local length = 2
        
        if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
            local ex, ey = EntityGetTransform( target )
            
            if ( ex ~= nil ) and ( ey ~= nil ) then
                angle_inc = 0 - math.atan2( ( ey - pos_y ), ( ex - pos_x ) )
                angle_inc_set = true
            end
        end

        for k=1,5 do
            SetRandomSeed(k+pos_x,pos_y+k)

            local angle = 0
            local length = 250
            if angle_inc_set then
                angle = angle_inc + Random( -35, 35 ) * 0.01
            else
                angle = math.rad( Random( 1, 360 ) )
            end
            
            local vel_x = math.cos( angle ) * length
            local vel_y = 0- math.sin( angle ) * length
        
            local pid = shoot_projectile( entity_id, "data/entities/projectiles/deck/grenade.xml", pos_x, pos_y, vel_x, vel_y )
            local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
            ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("ghost"))
        end        
    elseif attack == "small_sun" then
        ComponentSetValue2(find_vsc("cooldown_data"),"value_float",260)

        local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 350, "player_unit" )

        target = targets[1]
        
        
        local angle_inc = 0
        local angle_inc_set = false
        
        local length = 2
        
        if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
            local ex, ey = EntityGetTransform( target )
            
            if ( ex ~= nil ) and ( ey ~= nil ) then
                angle_inc = 0 - math.atan2( ( ey - pos_y ), ( ex - pos_x ) )
                angle_inc_set = true
            end
        end

        do
            SetRandomSeed(pos_x,pos_y)

            local angle = 0
            local length = 250
            if angle_inc_set then
                angle = angle_inc + Random( -35, 35 ) * 0.01
            else
                angle = math.rad( Random( 1, 360 ) )
            end
            
            local vel_x = math.cos( angle ) * length
            local vel_y = 0- math.sin( angle ) * length
        
            local pid = shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/sun_small.xml", pos_x, pos_y, vel_x, vel_y )
            local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
            ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("ghost"))
        end
    end
end

if book_timer <= 0 then
    if open_state == 0 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","openning")
        ComponentSetValue2(find_vsc("open_status"),"value_float",36)
        ComponentSetValue2(find_vsc("open_status"),"value_int",1)
    elseif open_state == 1 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","open")
        ComponentSetValue2(find_vsc("open_status"),"value_float",600 + math.random(-60,60))
        ComponentSetValue2(find_vsc("open_status"),"value_int",3)
        --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", true)
    elseif open_state == 3 then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","closing")
        ComponentSetValue2(find_vsc("open_status"),"value_float",32)
        ComponentSetValue2(find_vsc("open_status"),"value_int",2)
        --ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent"), "attack_ranged_enabled", false)
    else
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"rect_animation","closed")
        ComponentSetValue2(find_vsc("open_status"),"value_float",180 + math.random(-18,18))
        ComponentSetValue2(find_vsc("open_status"),"value_int",0)
    end
end
