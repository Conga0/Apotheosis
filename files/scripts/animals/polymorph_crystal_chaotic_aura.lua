dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 128

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

for k=1, #targets
do local v = targets[k];
	if (EntityHasTag( v, "player_unit") or EntityHasTag( v, "enemy") or EntityHasTag( v, "helpless_animal")) and (EntityHasTag( v, "polymorphable_NOT") == false) then
		local valid = true

		if GameGetGameEffectCount( v, "POLYMORPH_RANDOM" ) > 0 then
			valid = false
			break
		end

		if ( EntityGetName( v ) == "Chaotic Polymorph Crystal" ) or ( EntityGetName( v ) == "Polymorph Crystal" ) or ( EntityGetName( v ) == "unknown" ) then
			valid = false
		end
		
		if valid then
			local eid = EntityLoad( "mods/Apotheosis/files/scripts/animals/poly_crystal_chaotic_attack/debuff.xml", target_x, target_y )
			EntityAddChild( v, eid )
		end
	end
end

