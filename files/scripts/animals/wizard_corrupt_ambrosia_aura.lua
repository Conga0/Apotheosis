dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local charmTest = GameGetGameEffectCount( entity_id, "CHARM" )
friends = "enemy"
if charmTest >= 1 then friends = "player_unit" end

local targets = EntityGetInRadiusWithTag( x, y, r, friends )

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_protection_all_temporary.xml", x, y )
		EntityAddChild( v, eid )
	end
end