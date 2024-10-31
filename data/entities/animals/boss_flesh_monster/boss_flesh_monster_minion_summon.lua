
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 400

local players = EntityGetInRadiusWithTag(x,y,r,"player_unit")
if #players <= 0 then return end

local targets = EntityGetInRadiusWithTag( x, y, r, "touchmagic_immunity" )
local count = 0

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		if EntityGetName(v) == "Korruptoitunut Mestari" then
			count = count + 1
		end
	end
end

if count < 4 then
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/spells/teleport_alt", x, y );
	for k=1,7 do
		SetRandomSeed(x + k,y)
		list = {"hearty","manaeater","neutral","weaken",}
		rnd = Random(-60,60)
		rnd2 = Random(1,#list) 
		local filepath = GlobalsGetValue( table.concat({"apotheosis_cs_wizard_corrupt_",list[rnd2],"_filepath"}), table.concat({"data/entities/animals/wizard_corrupt_",list[rnd2],".xml"}) )
		local minion = EntityLoad(filepath, x + rnd, y + rnd)
		
		-- Conga 09/08/2024: We'll apply the minion changes here (temporary lifetime, not dropping gold, etc) since we won't know what creature we're spawning due to shifts
		-- This is handled through a status effect, because nolla sucks potatoes
		local status = EntityLoad("data/entities/animals/boss_flesh_monster/minions/effect_update_data_corrupt.xml",x,y)
		EntityAddChild(minion,status)

		EntityLoad( "data/entities/particles/teleportation_target.xml", x + rnd, y + rnd )
		EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_" .. list[rnd2] .. ".xml", x + rnd, y + rnd )
		--RO teleport sound
	end
end
