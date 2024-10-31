dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160
local comps = EntityGetComponentIncludingDisabled( entity_id, "AIAttackComponent" )

local targets = EntityGetInRadius( x, y, r )
local minionCount = 0

for k=1, #targets
do local v = targets[k];
	local path = EntityGetFilename( v )
	if ( v ~= entity_id ) and (path == "data/entities/animals/tank_rocket.xml" or path == "data/entities/animals/tank.xml" ) then
		--GamePrint("HISII MINECART LUA CHECK")
		minionCount = minionCount + 1
	end
end

for i,v in ipairs(comps) do
	if minionCount >= 6 then
		EntitySetComponentIsEnabled( entity_id, v, false )
	else
		EntitySetComponentIsEnabled( entity_id, v, true )
	end
end
