local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local radius = 600
local length = 150
local player = EntityGetWithTag( "player_unit" )[1] or nil
if player ~= nil then
    local player_x, player_y = EntityGetTransform( player )
    local projectiles = EntityGetInRadiusWithTag( pos_x, pos_y, radius, "projectile" ) or {}
    for i=1, #projectiles do
        local projectile = projectiles[i]

        if ( EntityGetName(projectile) == "darkflame_red_hurl" ) then
        -- Get projectile data
        local velcomp = EntityGetFirstComponentIncludingDisabled(projectile, "VelocityComponent")   --[[@cast velcomp number]]
        local projectile_x, projectile_y = EntityGetTransform( projectile )
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")

        -- Calculate angle and velocity
        local divergence = ((math.random() - 0.5) * 0.174533)
        ---@diagnostic disable-next-line: deprecated
        local angle = (math.pi - math.atan2( ( player_y - projectile_y ), ( player_x - projectile_x ) )) + divergence
        vel_x = -math.cos( angle ) * length
        vel_y = math.sin( angle ) * length

        -- Set velocity
        ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)

        local homingcomp = EntityGetFirstComponentIncludingDisabled(projectile, "HomingComponent")
        EntitySetComponentIsEnabled(projectile, homingcomp, true)
        end
    end
end
--Code lightly copy and pasted from Copi