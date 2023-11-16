dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 128

local charmTest = GameGetGameEffectCount( entity_id, "CHARM" )
friends = "enemy"
if charmTest >= 1 then friends = "player_unit" end
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, friends )
local isBurning = false

for k=1, #targets
do local v = targets[k];
	local s = EntityGetComponent( v, "DamageModelComponent" )
	if ( s ~= nil ) then
		for i,b in ipairs( s ) do
			local name = ComponentGetValue2( b, "is_on_fire" )
			
			if ( name == true ) or GameGetGameEffectCount(v, "RADIOACTIVE") > 0 or GameGetGameEffectCount(v, "POISON") > 0 or GameGetGameEffectCount(v, "OILED") > 0 or GameGetGameEffectCount(v, "SLIMY") > 0 then
				isBurning = true
			end
		end
	end
end


if isBurning then
	local how_many = 12
	local angle_inc = ( 2 * 3.14159 ) / how_many
	local theta = 0
	local length = 120
	GamePlaySound( "data/audio/Desktop/player.bank", "player/jump_water", pos_x, pos_y );

	for i=1,how_many do
		local vel_x = math.cos( theta ) * length
		local vel_y = math.sin( theta ) * length
		theta = theta + angle_inc

		shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/deck/mass_status_wet_effect.xml", pos_x, pos_y, vel_x, vel_y )
		-- 	game_effect/on_fire/game_effect_end
	end

	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

	for i,v in ipairs( targets ) do		
		if EntityHasTag(v, "hittable") then
			local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_status_wet_ailment.xml", pos_x, pos_y )
			EntityAddChild( v, eid )
			EntityAddRandomStains( v, CellFactory_GetType("water"), 400 )
		end
	end
end

