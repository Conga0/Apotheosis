dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
local vel_x, vel_y = 0,0
local amount = 7

if EntityHasTag(entity_id,"projectile_cloned") then return end

local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
local projectile_file = ""


if ( variablestorages ~= nil ) then
	for j,storage_id in ipairs(variablestorages) do
		local var_name = ComponentGetValue( storage_id, "name" )
		if ( var_name == "projectile_file" ) then
			projectile_file = ComponentGetValue2( storage_id, "value_string" )
		end
	end
end

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
end)

for k=1,amount do

    math.randomseed( GameGetFrameNum() + k + pos_x + pos_y)
    vel_x = math.random(vel_x * 0.7, vel_x * 1.3) + math.random(vel_y * -0.2, vel_y * 0.2)
    vel_y = math.random(vel_y * 0.7, vel_y * 1.3) + math.random(vel_x * -0.2, vel_x * 0.2)


    if ( #projectile_file > 0 ) then
        local eid = shoot_projectile_from_projectile( entity_id, projectile_file, pos_x, pos_y, vel_x, vel_y )
        EntityAddTag( eid, "projectile_cloned" )
    end

end