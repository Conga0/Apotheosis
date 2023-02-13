dofile_once("data/scripts/lib/utilities.lua")
local flipflop = 1

function projcleanup()
    local proj_list = EntityGetWithTag( "projectile" )

    if #proj_list > 1000 then
        for k=1,#proj_list
        do proj = proj_list[k]
            if flipflop == 1 then
                EntityKill(proj)
                flipflop = 2
            else
                flipflop = 1
            end
        end

        local entity_id    = GetUpdatedEntityID()
        local pos_x, pos_y = EntityGetTransform( entity_id )
        
        local how_many = 12
        local angle_inc = ( 2 * 3.14159 ) / how_many
        local theta = 0
        local length = 400
        
        for i=1,how_many do
            local vel_x = math.cos( theta ) * length
            local vel_y = math.sin( theta ) * length
            theta = theta + angle_inc
        
            shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/deck/mass_status_polymorph_effect.xml", pos_x, pos_y, vel_x, vel_y )
        end

        GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye", pos_x, pos_y );

    end
end

function damage_received( damage )
    projcleanup()
end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
    projcleanup()
end

--If you're wondering why this is there, it's so when you shoot out a plasma beam to the pitboss, it doesn't end up creating 2000 beams in response and crash your noita, it limits it.
--This is for if you have a 1000% health pitboss for example, usually the boss dies before it makes *too* much lag, but when it has 10x it's normal hp, let alone more, it can get pretty unhinged
--Only clearing half of the onscreen projectiles probably makes more sense visually than clearing all of them, if it causes too much lag it can be undone