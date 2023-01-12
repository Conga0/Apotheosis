dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 160
local comp = EntityGetFirstComponent( entity_id, "AnimalAIComponent" )

local targets = EntityGetInRadius( x, y, r )
local minionCount = 0

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) and ( EntityGetName( v ) == "Pieni räjähtävä sieni" ) then
		minionCount = minionCount + 1
	end
end

if minionCount >= 5 then
	ComponentSetValue2( comp, "attack_ranged_enabled", false )
else
	ComponentSetValue2( comp, "attack_ranged_enabled", true )
end