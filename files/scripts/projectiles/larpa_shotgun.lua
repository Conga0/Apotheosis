dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
local vel_x, vel_y = 0,0
local amount = 7

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

for k=1,amount
do

    local length = 400 * math.random(0.70,1.30)

    --3.12 * 0.15 / 2 = 0.234
    --GamePrint("rot is " .. rot)

    vel_x = math.cos(rot + math.random(-0.234,0.234)) * length
    vel_y = math.sin(rot + math.random(-0.234,0.234)) * length


    if ( #projectile_file > 0 ) then
        local eid = shoot_projectile_from_projectile( entity_id, projectile_file, pos_x, pos_y, vel_x, vel_y )
        EntityAddTag( eid, "projectile_cloned" )
    end
    SetRandomSeed( GameGetFrameNum() + k, pos_x + pos_y + entity_id )

end