dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160
local comps = EntityGetComponentIncludingDisabled( entity_id, "AIAttackComponent" )

local targets = EntityGetInRadius( x, y, r )
local minionCount = 0

for i,v in ipairs( targets ) do
	local path = EntityGetFilename( v )
	if ( v ~= entity_id ) and (path == "data/entities/animals/tank_rocket.xml" or path == "data/entities/animals/tank.xml" ) then
		--GamePrint("HISII MINECART LUA CHECK")
		minionCount = minionCount + 1
	end
end

for i,v in ipairs(comps) do
	if minionCount >= 6 then
		ComponentSetValue2( v, "attack_ranged_entity_count_min", 0 )
		ComponentSetValue2( v, "attack_ranged_entity_count_max", 0 )
	else
		ComponentSetValue2( v, "attack_ranged_entity_count_min", 1 )
		ComponentSetValue2( v, "attack_ranged_entity_count_max", 1 )
	end
end