--Built to combat shields :)

local entity_id = GetUpdatedEntityID()
local vel_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" )
local vel_x, vel_y = ComponentGetValue2( vel_comp, "mVelocity" )
local pvel_x, pvel_y = ComponentGetValue2( vel_comp, "mPrevVelocity" )
local avel_x = pvel_x * -1
local avel_y = pvel_y * -1

local angle = math.atan2(vel_y, vel_x)
local pangle = math.atan2(pvel_y, pvel_x)
local aangle = math.atan2(avel_y, avel_x)

local leniency = 2.0

if angle >= aangle - leniency and angle <= aangle + leniency then 
  --GamePrint("NO FLIP!")
  ComponentSetValue2( vel_comp, "mVelocity", vel_x * -1, vel_y * -1 )
end