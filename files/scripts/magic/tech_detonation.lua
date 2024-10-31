dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local opts = {
    {
        event = function()  --Meteor Rain
            EntityLoad( "data/entities/projectiles/deck/meteor_rain.xml", pos_x, pos_y )
        end
    },
    {
        event = function()  --Circle of Acid in a random direction 200px away from the player
            local angle = math.random( 0, 31415 ) * 0.0001
            local length = 200
            
            local ex = pos_x + math.cos( angle ) * length
            local ey = pos_y - math.sin( angle ) * length

            EntityLoad( "data/entities/projectiles/circle_acid_small.xml", ex, ey )
        end,
    },
    {
        event = function()  --Circle of Lava in a random direction 200px away from the player
            local angle = math.random( 0, 31415 ) * 0.0001
            local length = 200
            
            local ex = pos_x + math.cos( angle ) * length
            local ey = pos_y - math.sin( angle ) * length

            EntityLoad( "data/entities/projectiles/circle_lava_small.xml", ex, ey )
        end,
    },
    {
        event = function()  --Cursed Orb Tsunami
            local angle = math.random( 0, 31415 ) * 0.0001
            local length = 150
            
            local ex = pos_x + math.cos( angle ) * length
            local ey = pos_y - math.sin( angle ) * length

            for i=0,15 do
                local angle_ = math.pi * 0.125 * i
                
                shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/orb_cursed_thrower.xml", ex, ex, math.cos( angle_ ) * 400, 0 - math.sin( angle_ ) * 400 )
            end
        end
    },
    {
        event = function()  --Ring of Propane tanks 100px away from the player
            for i=0,15 do
                local angle = math.pi * 0.125 * i
                local length = 120
                
                local ex = pos_x + math.cos( angle ) * length
                local ey = pos_y - math.sin( angle ) * length

                EntityLoad( "data/entities/particles/tiny_ghost_poof.xml", ex, ey )
                EntityLoad( "data/entities/props/physics_propane_tank.xml", ex, ey )
            end
        end,
    },
    {
        event = function()  --Summon a Mechanical Worm with buffed hp 300px away from the player, only one can be active at a time and can not spawn if the player just entered the Plane
            local angle = math.random( 0, 31415 ) * 0.0001
            local length = 400
            
            local ex = pos_x + math.cos( angle ) * length
            local ey = pos_y - math.sin( angle ) * length

            local mech_worm = EntityGetWithTag("mechanical_worm_miniboss") or {}
            local player_id = EntityGetParent(entity_id)
            local plyr_x = EntityGetTransform(player_id)

            if #mech_worm < 1 and plyr_x > -5600 then
                EntityLoad( "data/entities/animals/planes/worm_mechanical.xml", ex, ey )
            else
                EntityLoad( "data/entities/projectiles/deck/meteor_rain.xml", pos_x, pos_y )
            end
        end,
    },
    {
        event = function()  --Spawn an array of hazardous flasks around the player
            for k=1,16 do
                local angle = math.random( 0, 31415 ) * 0.0001
                local length = 120
                
                local ex = pos_x + math.cos( angle ) * length
                local ey = pos_y - math.sin( angle ) * length

                EntityLoad( "mods/Apotheosis/files/entities/items/pickups/potion_aggressive_tech.xml", ex, ey )
            end
        end,
    },
}

--Pick a random event from the list and run it
opts[math.random(1,#opts)].event()
