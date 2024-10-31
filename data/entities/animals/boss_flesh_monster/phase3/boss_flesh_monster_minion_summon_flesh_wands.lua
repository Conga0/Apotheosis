
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 600
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

local players = EntityGetInRadiusWithTag(x,y,r,"player_unit")
if #players <= 0 then return end

function setMinionData(minion_id)
	local status = EntityLoad("data/entities/animals/boss_flesh_monster/minions/effect_update_data_cursed.xml",x,y)
	EntityAddChild(minion_id,status)
end

GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/spells/teleport_spooky", x, y );
--Puppeteer Party
local minion_amount = 4
for k=1,minion_amount do
	SetRandomSeed(x + k,y)
	rnd = Random(-60,60)
	local filepath = GlobalsGetValue( "apotheosis_cs_flesh_wizard_wands_filepath", "data/entities/animals/flesh_wizard_wands.xml" )
	local minion = EntityLoad(filepath, x + rnd, y + rnd)
	setMinionData(minion)
	EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
	EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
end
