
local length = 500
local player = EntityGetWithTag( "player_unit" )[1]
if player then
    local projectiles = EntityGetWithTag( "projectile" ) or {}
    local controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")  --[[@cast controls number]]
    local cursor_x, cursor_y = ComponentGetValue2(controls, "mMousePosition")
    for i=1, #projectiles do
        local projectile = projectiles[i]

        -- Get projectile data
        local velcomp = EntityGetFirstComponentIncludingDisabled(projectile, "VelocityComponent")   --[[@cast velcomp number]]
        local projectile_x, projectile_y = EntityGetTransform( projectile )
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")

        -- Calculate angle and velocity
        local divergence = ((math.random() - 0.5) * 0.174533)
        ---@diagnostic disable-next-line: deprecated
        local angle = (math.pi - math.atan2( ( cursor_y - projectile_y ), ( cursor_x - projectile_x ) )) + divergence
        vel_x = -math.cos( angle ) * length
        vel_y = math.sin( angle ) * length

        -- Set velocity
        ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
    end
end
--Code by Copi
-- Rewritten 8/14 -copi