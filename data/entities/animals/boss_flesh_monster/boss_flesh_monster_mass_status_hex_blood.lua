dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 650

-- check that we're only shooting every 10 frames
if script_wait_frames( entity_id, 10 ) then  return  end

local how_many = 12
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 400

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	shoot_projectile( entity_id, "data/entities/animals/boss_flesh_monster/projectiles/mass_status_wounded_effect.xml", pos_x, pos_y, vel_x, vel_y )
end

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

for k=1,#targets
do v = targets[k]
	if ( v ~= entity_id ) then
		if EntityHasTag(v, "hittable") then
			local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_hex_blood_short.xml", pos_x, pos_y )
			GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", pos_x, pos_y );
			EntityAddChild( v, eid )
		end
	end
end