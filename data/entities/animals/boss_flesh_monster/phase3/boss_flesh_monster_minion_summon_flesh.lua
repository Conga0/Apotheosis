
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 600
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

local players = EntityGetInRadiusWithTag(x,y,r,"player_unit")
if #players <= 0 then return end

local targets = EntityGetInRadiusWithTag( x, y, r, "touchmagic_immunity" )
local count = 0

for k=1, #targets
do local v = targets[k];
	if ( v ~= entity_id ) then
		if EntityGetName(v) == "Kirottu Mestari" then
			count = count + 1
		end
	end
end

function setMinionData(minion_id)
	local status = EntityLoad("data/entities/animals/boss_flesh_monster/minions/effect_update_data_cursed.xml",x,y)
	EntityAddChild(minion_id,status)
end

if count < 5 then
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/spells/teleport_spooky", x, y );
	local orient_rnd = Random(1,6)
	local swap_rnd = Random(1,5)
	if ( swap_rnd == 1 ) then --Swapping Support
		rnd = Random(-60,60)
		local filepath = GlobalsGetValue( "apotheosis_cs_flesh_wizard_swapper_filepath", "data/entities/animals/flesh_wizard_swapper.xml" )
		local minion = EntityLoad(filepath, x + rnd, y + rnd)
		setMinionData(minion)
		EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
		EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
	end
	if ( orient_rnd == 1 ) then --Puppeteer Party
		local minion_amount = Random(2,3)
		for k=1,minion_amount do
			SetRandomSeed(x + k,y)
			rnd = Random(-60,60)
			local filepath = GlobalsGetValue( "apotheosis_cs_flesh_wizard_wands_filepath", "data/entities/animals/flesh_wizard_wands.xml" )
			local minion = EntityLoad(filepath, x + rnd, y + rnd)
			setMinionData(minion)
			EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
			EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
		end
	end
	if ( orient_rnd == 2 ) then --Toothy Terrors
		local minion_amount = Random(3,5)
		for k=1,minion_amount do
			SetRandomSeed(x + k,y)
			list = {"manaeater","twitchy"}
			rnd = Random(-60,60)
			rnd2 = Random(1,#list)
			local filepath = GlobalsGetValue( table.concat({"apotheosis_cs_",list[rnd2],"_filepath"}), table.concat({"data/entities/animals/flesh_wizard_",list[rnd2],".xml"}) )
			local minion = EntityLoad(filepath, x + rnd, y + rnd)
			setMinionData(minion)
			EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
			EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
		end
	end
	if ( orient_rnd == 3 ) then --Magicless Mayhem
		local minion_amount = Random(2,3)
		for k=1,minion_amount do
			SetRandomSeed(x + k,y)
			rnd = Random(-60,60)
			local filepath = GlobalsGetValue( "apotheosis_cs_flesh_wizard_manaeater_filepath", "data/entities/animals/flesh_wizard_manaeater.xml" )
			local minion = EntityLoad(filepath, x + rnd, y + rnd)
			setMinionData(minion)
			EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
			EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
		end
	end
	if ( orient_rnd == 4 ) then --Wonky Wands
		local minion_amount = Random(2,4)
		for k=1,minion_amount do
			SetRandomSeed(x + k,y)
			list = {"wands","neutral","manaeater"}
			rnd = Random(-60,60)
			rnd2 = Random(1,#list)
			local filepath = GlobalsGetValue( table.concat({"apotheosis_cs_",list[rnd2],"_filepath"}), table.concat({"data/entities/animals/flesh_wizard_",list[rnd2],".xml"}) )
			local minion = EntityLoad(filepath, x + rnd, y + rnd)
			setMinionData(minion)
			EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
			EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
		end
	end
	if ( orient_rnd == 5 ) then --Swindling Switchery
		local minion_amount = 3
		for k=1,minion_amount do
			SetRandomSeed(x + k,y)
			rnd = Random(-60,60)
			local filepath = GlobalsGetValue( "apotheosis_cs_flesh_wizard_swapper_filepath", "data/entities/animals/flesh_wizard_swapper.xml" )
			local minion = EntityLoad(filepath, x + rnd, y + rnd)
			setMinionData(minion)
			EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
			EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
		end
	end
	if ( orient_rnd == 6 ) then --Faulty Firing
		local minion_amount = Random(2,3)
		for k=1,minion_amount do
			SetRandomSeed(x + k,y)
			list = {"twitchy","neutral"}
			rnd = Random(-60,60)
			rnd2 = Random(1,#list)
			local filepath = GlobalsGetValue( table.concat({"apotheosis_cs_",list[rnd2],"_filepath"}), table.concat({"data/entities/animals/flesh_wizard_",list[rnd2],".xml"}) )
			local minion = EntityLoad(filepath, x + rnd, y + rnd)
			setMinionData(minion)
			EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief_small.xml", x + rnd, y + rnd)
			EntityLoad("data/entities/animals/boss_flesh_monster/particles/circle_fast_flesh.xml", x + rnd, y + rnd )
		end
	end
end
