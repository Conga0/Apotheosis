local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 60

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	
local max_vel = 0
local hatch = false
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" ) or {}

for k=1, #targets
do local target = targets[k];
    if not IsInvisible(target) then
        local temp_vel = 0
        local vel_x, vel_y = GameGetVelocityCompVelocity(target)
        vel_x = math.abs(vel_x)
        vel_y = math.abs(vel_y)
        if (vel_y / 3 > vel_x) then
            max_vel = vel_y / 3
        else 
            max_vel = vel_x
        end
        if (temp_vel > max_vel) then
            max_vel = temp_vel
        end
    end
end

--[[
if (#targets > 0) then
    GamePrint("max_vel:" .. tostring(max_vel))
end
]]--

local luacomp = nil
local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/props/egg_volcanic_lukki_trap_shift.lua" then
	    luacomp = luacomps[i]
	    break
    end
end

if (max_vel >= 1.9) then
    hatch = true
elseif (max_vel == 0) then
    local cooldown = Random(100,190)
    ComponentSetValue2( luacomp, "execute_every_n_frame", cooldown )
else
    local limit = 0.90
    local fastest = 10
    local slowest = 180 - fastest
    local divider = math.max((limit - max_vel) / limit, 0)
    local cooldown = math.ceil((slowest * divider) + fastest)

    ComponentSetValue2( luacomp, "execute_every_n_frame", cooldown )
    if (divider == 0) then
	    ComponentSetValue2( luacomp, "mNextExecutionTime", GameGetFrameNum() + fastest )
    end
end

local varcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent")
local caution = ComponentGetValue2(varcomp, "value_float")

if (hatch == true or caution > 4) then
    EntityLoad( "data/entities/animals/lukki_fire_tiny.xml", pos_x, pos_y )
    if ( Random( 1, 8 ) == 8 ) then
	    EntityLoad( "data/entities/animals/lukki_fire_tiny.xml", pos_x, pos_y )
    end
    EntityLoad( "mods/Apotheosis/files/entities/projectiles/fireball_explosion.xml", pos_x, pos_y )
    EntityKill( entity_id )
end

local new_caution = math.max(caution - 0.05, 0)
ComponentSetValue2( varcomp, "value_float", new_caution )