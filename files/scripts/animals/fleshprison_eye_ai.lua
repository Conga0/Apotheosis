dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
local length = Random( 95, 115 )

-- Get projectile data
local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
if velcomp ~= nil then

    -- Calculate angle and velocity
    local angle = math.rad( Random( 1, 360 ) )
    local vel_x = -math.cos( angle ) * length
    local vel_y = math.sin( angle ) * length

    -- Set velocity
    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
end

--Code by Copi