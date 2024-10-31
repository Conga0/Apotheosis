
dofile_once("data/scripts/lib/utilities.lua")
local speed = 0

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )

--[[
-- velocity
local vel_x,vel_y = GameGetVelocityCompVelocity(entity_id)
vel_x, vel_y = vec_normalize(vel_x, vel_y)
if vel_x == nil then return end
vel_x = vel_x * speed
vel_y = vel_y * speed
]]--

local vel_x = 0
local vel_y = 0

local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")

--If the building tank is too far away from the engineer or engie is dead then explode
if projcomp ~= nil then
    local shooter = ComponentGetValue2(projcomp, "mWhoShot")
    local s_x = pos_x + 20
    local s_y = pos_y + 20
    if EntityGetIsAlive(shooter) then
	s_x, s_y = EntityGetTransform( shooter )
    end
    local dis_x = s_x - pos_x
    local dis_y = s_y - pos_y
    local distance = get_magnitude(dis_x, dis_y)

    if EntityGetIsAlive(shooter) == false or distance >= 15 then
	local eid = EntityLoad("data/entities/animals/tank.xml", pos_x, pos_y )
	dcomp = EntityGetFirstComponentIncludingDisabled( eid, "DamageModelComponent" )
	if ( dcomp ~= nil ) then
	    local max_hp = ComponentGetValue2( dcomp, "max_hp" )
	    EntityInflictDamage( eid, max_hp, "DAMAGE_CURSE", "", "NORMAL", 0, 0) 
	end
    elseif EntityGetIsAlive(shooter) then
	shoot_projectile_from_projectile(entity_id, "mods/Apotheosis/files/entities/projectiles/summon_tank.xml", pos_x, pos_y, vel_x, vel_y)
    end
end