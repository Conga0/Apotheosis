dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )

local projcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
local genome = ComponentGetValue2(projcomp,"mShooterHerdId")

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

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

if ( #projectile_file > 0 ) then
	local angle = math.rad(Random(0,359))
	local speed = 90
	local how_many = 32
	local angle_inc = ( math.pi * 2 ) / how_many
	
	for i=1,how_many do
		local vel_x = math.cos( angle ) * speed
		local vel_y = 0 - math.sin( angle ) * speed

		local eid = shoot_projectile_from_projectile( entity_id, projectile_file, pos_x, pos_y, vel_x, vel_y )
		EntityAddTag( eid, "projectile_cloned" )
		angle = angle + angle_inc

		local projcomp_child = EntityGetFirstComponentIncludingDisabled(eid,"ProjectileComponent")
		ComponentSetValue2(projcomp_child,"mShooterHerdId",genome)
		ComponentSetValue2(projcomp_child,"damage_every_x_frames",1)
		ComponentSetValue2(projcomp_child,"collide_with_entities",true)
	end
end