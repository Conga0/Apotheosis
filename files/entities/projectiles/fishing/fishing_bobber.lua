local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local liquiform = RaytraceSurfacesAndLiquiform(x, y, x, y+1)
local platform = RaytracePlatforms(x, y, x, y+1)
local bob_vel = 8
if liquiform and not platform then
    local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y-bob_vel)
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
end

-- Particle logic
local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local line_target = EntityGetAllChildren(ComponentGetValue2(vsccomp,"value_int"))[1]

if ComponentGetIsEnabled(EntityGetFirstComponentIncludingDisabled(ComponentGetValue2(vsccomp,"value_int"),"LuaComponent")) == false then
    EntityKill(entity_id)
end

--ugh...
local target_x , target_y, rotation = EntityGetTransform(line_target)
if rotation > -1.5 and rotation < 1.5 then
    rotation = rotation + 0.19
else
    rotation = rotation - 0.19
end

local target_x = target_x + (math.cos( rotation ) * 26)
local target_y = target_y + (math.sin( rotation ) * 26)
local vars = EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent", "disabled_at_start") or {}
for i = 1, #vars do
    if target_x and target_y then
        ComponentSetValue2(vars[i], "mExPosition", target_x, target_y)
    end
end

--local target_x = math.cos( rotation ) * 22
--local vel_y = 0 - math.cos( angle ) * 100
