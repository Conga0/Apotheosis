
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 300

local targets = EntityGetInRadiusWithTag( x, y, r, "touchmagic_immunity" )
local count = 0

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		if EntityGetName(v) == "Jäänkatse" then
			count = count + 1
		end
	end
end

if count < 4 then
	for k=1,7 do
		SetRandomSeed(x + k,y)
		rnd = Random(-30,30)
		EntityLoad("data/entities/animals/AI/gazer_cold_apotheosis.xml", x + rnd, y + rnd)
		EntityLoad( "data/entities/particles/teleportation_target.xml", x + rnd, y + rnd )
		--RO teleport sound
	end
end
