
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 300
local particlePath = "mods/Apotheosis/files/entities/misc/effect_berserk_short_evil_perk.xml"
if ModSettingGet( "Apotheosis.particle_reduction" ) then
	particlePath = "mods/Apotheosis/files/entities/misc/effect_berserk_short_evil_perk_lowparticles.xml"
end

local targets = EntityGetInRadiusWithTag( x, y, r, "enemy" )

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		local c = EntityGetAllChildren( v )
		local valid = true
		
		if ( c ~= nil ) then
			for a,b in ipairs( c ) do
				local comps = EntityGetComponent( b, "GameEffectComponent", "effect_berserk_short_evil" )
				
				if ( comps ~= nil ) then
					valid = false
					break
				end
			end
		end
		
		if valid then
			local eid = EntityLoad( particlePath, x, y )
			EntityAddChild( v, eid )
		end
	end
end
