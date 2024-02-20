dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 650
local player_id = EntityGetWithTag("player_unit")[1] or 0

if player_id ~= 0 then
	local wormcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
	local player_hp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")

	local bite_dmg = math.max(4,(ComponentGetValue2(player_hp,"max_hp")/5)) --Bite damage is equal to 20% of the player's max health, minimum of 100 damage
	ComponentSetValue2(wormcomp,"bite_damage",bite_dmg)
end

local how_many = 12
local angle_inc = ( 2 * 3.14159 ) / how_many
local theta = 0
local length = 400

for i=1,how_many do
	local vel_x = math.cos( theta ) * length
	local vel_y = math.sin( theta ) * length
	theta = theta + angle_inc

	shoot_projectile( entity_id, "data/entities/animals/worm_hell_big/projectiles/mass_status_song_effect.xml", pos_x, pos_y, vel_x, vel_y )
end

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

for k=1,#targets
do v = targets[k]
	if ( v ~= entity_id ) then
		if EntityHasTag(v, "hittable") then
			local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_final_requiem.xml", pos_x, pos_y )
			GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", pos_x, pos_y );
			EntityAddChild( v, eid )
		end
	end
end
