
local entity_id = GetUpdatedEntityID()
local p = EntityGetWithTag( "player_unit" )

if ( #p > 0 ) then
	for k=1, #p
	do local pl = p[k];
		local ambrosiaTest = GameGetGameEffectCount( pl, "PROTECTION_ALL" )
		if ambrosiaTest >= 1 then
			local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/ambrosia_dullification/debuff.xml" )
			EntityAddChild( pl, eid )
		end
	end
end