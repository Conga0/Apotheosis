dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 105

--I feel thise frozen check could be optimised somehow.. but I am unsure how

local frozenTest = GameGetGameEffectCount( entity_id, "FROZEN" )
if frozenTest <= 0 then
	local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

	for k=1, #targets
	do local v = targets[k];
		if ( v ~= entity_id ) then
				local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_mana_degradation.xml", x, y )
				EntityAddChild( v, eid )
		end
	end
end
