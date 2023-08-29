dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 150

local targets = EntityGetInRadiusWithTag( x, y, r, "enemy" )

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		local c = EntityGetAllChildren( v )
		
		local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_infusion_vulnerability_long.xml", x, y )
		EntityAddChild( v, eid )
	end
end

local how_many = 12
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 200
GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", x, y );

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/mass_status_infusion_vulnerability_effect.xml", x, y, vel_x, vel_y )
end