
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 300

local targets = EntityGetInRadiusWithTag( x, y, r, "poring_holy" ) or {}

if #targets < 4 then

	--Wipe angelings
	local targets2 = EntityGetInRadiusWithTag( x, y, 600, "poring_holy" ) or {}
	for z=1,#targets2 do
		EntityKill(targets2[z])
	end
	
	for k=1,7 do
		SetRandomSeed(x + k,y)
		rnd = Random(-60,60)
		EntityLoad("data/entities/animals/AI/poring_holy.xml", x + rnd, y + rnd)
		EntityLoad( "data/entities/particles/teleportation_target.xml", x + rnd, y + rnd )
		--RO teleport sound
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/spells/teleport_alt", x, y );
	end
end
