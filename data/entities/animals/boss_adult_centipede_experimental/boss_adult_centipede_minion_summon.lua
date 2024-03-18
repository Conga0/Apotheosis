dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 600

local players = EntityGetInRadiusWithTag(x,y,r,"player_unit")
if #players <= 0 then return end

local targets = EntityGetInRadiusWithTag( x, y, r, "enemy" )
local count = 0

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		if EntityGetName(v) == "Vangittumuurahainen" then
			count = count + 1
		end
	end
end

if count < 4 then
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/spells/teleport_alt", x, y );
	for k=1,7 do
		SetRandomSeed(x + k,y)
		list = {"fire","suffocate",}
		rnd = Random(-60,60)
		rnd2 = Random(1,#list)
		EntityLoad("data/entities/animals/boss_adult_centipede/minions/ant_" .. list[rnd2] .. ".xml", x + rnd, y + rnd)
		EntityLoad( "data/entities/particles/teleportation_target.xml", x + rnd, y + rnd )
		EntityLoad("data/entities/animals/boss_adult_centipede/particles/circle_fast_" .. list[rnd2] .. ".xml", x + rnd, y + rnd )
		--RO teleport sound
	end
end
