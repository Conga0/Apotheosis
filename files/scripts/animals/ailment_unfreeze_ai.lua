dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 128

local charmTest = GameGetGameEffectCount( entity_id, "CHARM" )
friends = "enemy"
if charmTest >= 1 then friends = "player_unit" end
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, friends )
local isFrozen = false

for k=1, #targets
do local v = targets[k];
	local FrozenTest = GameGetGameEffectCount( v, "FROZEN" )
	if FrozenTest >= 1 then
		isFrozen = true
	end
end


if isFrozen then
	GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/on_fire/create", pos_x, pos_y );

	local eid = EntityLoad( "data/entities/animals/ai/drone_status_ailment_unfreeze_fx.xml", pos_x, pos_y )
	EntityAddChild( entity_id, eid )


	local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" )

	for i,v in ipairs( targets ) do
		if ( v ~= entity_id ) then
			local comp = GameGetGameEffect( v, "FROZEN" )
			if comp ~= 0 then
				ComponentSetValue2( comp, "frames", 1)
			end
			--GamePrint(tostring(comp))
		end
	end
end
