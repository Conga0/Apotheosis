
local projectile_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( projectile_id )

local vsc_data = EntityGetComponentIncludingDisabled(projectile_id,"VariableStorageComponent")
local origin_data = 0
for k=1,#vsc_data do
    if ComponentGetValue2(vsc_data[k],"name") == "float_orbit_comp" then
        origin_data = vsc_data[k]
        break
    end
end


local float_bob_y = 32
local float_bob_x = 32
local float_bob_speed_y = 0.023
local float_bob_speed_x = 0.01121
local float_lerp = 0.85
local current_frame = GameGetFrameNum()

function lerp(a, b, weight)
	return a * weight + b * (1 - weight)
end

function lerpVec(x1, y1, x2, y2, weight)
	local x = lerp(x1, x2, weight)
	local y = lerp(y1, y2, weight)
	return x,y
end

function run_init()
    ComponentSetValue2(origin_data,"value_int",pos_x)
    ComponentSetValue2(origin_data,"value_float",pos_y)

    local vel_comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"VelocityComponent")
    local proj_comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"ProjectileComponent")

    ComponentSetValue2(vel_comp,"liquid_drag",0)
    ComponentSetValue2(vel_comp,"displace_liquid",false)

    ComponentSetValue2(proj_comp,"penetrate_world",true)
    ComponentSetValue2(proj_comp,"penetrate_world_velocity_coeff",1.0)
end

function run_update()
    local origin_x = ComponentGetValue2(origin_data,"value_int")
    local origin_y = ComponentGetValue2(origin_data,"value_float")
    if origin_x == 0 and origin_y == 0 then
        run_init()
        return
    end

    local rng = ProceduralRandomf(projectile_id, 0, -1, 1)
    local time = current_frame + rng * 10000
    local bob_speed_x = float_bob_speed_x + (rng * float_bob_speed_x * 0.1)
    local bob_speed_y = float_bob_speed_y + (rng * float_bob_speed_y * 0.1)

    local goal_x = origin_x + math.sin(time * bob_speed_x) * float_bob_x
    local goal_y = origin_y + math.sin(time * bob_speed_y) * float_bob_y

    goal_x, goal_y = lerpVec(pos_x, pos_y, goal_x, goal_y, float_lerp)

    local rotation = math.atan2( ( goal_y - pos_y ), ( goal_x - pos_x ) )

    EntitySetTransform(projectile_id, goal_x, goal_y, rotation)
end

run_update()