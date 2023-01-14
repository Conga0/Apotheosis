dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local length = 500
local angle_inc = 0
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

local projectiles = EntityGetWithTag( "projectile" )

local player = EntityGetWithTag( "player_unit" )[1]
local cursor_x, cursor_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")
for _, projectile in ipairs(EntityGetWithTag( "projectile" ) or {}) do

    -- Get projectile data
    local velcomp = EntityGetFirstComponentIncludingDisabled(projectile, "VelocityComponent")
    if velcomp ~= nil then
        local projectile_x, projectile_y = EntityGetTransform( projectile )
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")

        -- Calculate angle and velocity
        local divergence = ((math.random() - 0.5) * 0.174533)
        local angle = (math.pi - math.atan2( ( cursor_y - projectile_y ), ( cursor_x - projectile_x ) )) + divergence
        vel_x = -math.cos( angle ) * length
        vel_y = math.sin( angle ) * length

        -- Set velocity
        ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
    end
end

--Code by Copi