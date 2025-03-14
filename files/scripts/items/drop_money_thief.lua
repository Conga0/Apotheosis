dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/game_helpers.lua" )

function do_money_drop( amount_multiplier, trick_kill )
	
	if ( GameGetIsTrailerModeEnabled() ) then return end

	local entity = GetUpdatedEntityID()

	local thiefgold = 0
    local thiefgoldcomps = EntityGetComponentIncludingDisabled(entity,"VariableStorageComponent")
    for k=1,#thiefgoldcomps
    do local v = thiefgoldcomps[k]
        if ComponentGetValue2(v,"name") == "thief_gold" then
            thiefgold = ComponentGetValue2(v,"value_int")
        end
    end


	local no_gold_drop = false
	edit_component_with_tag( entity, "VariableStorageComponent", "no_gold_drop", function(comp,vars) no_gold_drop = true end )
	
	if no_gold_drop then
		return
	end

	local amount = 1

	edit_component( entity, "DamageModelComponent", function(comp,vars)
		local health = tonumber(ComponentGetValue( comp, "max_hp"))

		if health > 1.0 then
			amount = math.floor(health)
		end

	end)
	
	if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) then
		amount = amount * 3.0
	end

	amount = amount * amount_multiplier
	--[[if( amount > ( 15 * amount_multiplier ) ) then
		amount = 15 * amount_multiplier
	end]]--

	local money = 10 * amount
	local x, y = EntityGetTransform( entity )
	
	local entity_list = {}
	
	local gold_entity = "data/entities/items/pickup/goldnugget_"
	local remove_timer = false
	local drop_first_10 = true

	local comp_worldstate = EntityGetFirstComponent( GameGetWorldStateEntity(), "WorldStateComponent" )
	if( comp_worldstate ~= nil ) then
		if( ComponentGetValue2( comp_worldstate, "perk_gold_is_forever" ) ) then
			remove_timer = true
		end

		if( trick_kill ) then
			-- if worldstate perk_trick_kills_blood_money == 1
			if( ComponentGetValue2( comp_worldstate, "perk_trick_kills_blood_money" ) ) then
				gold_entity = "data/entities/items/pickup/bloodmoney_"
				drop_first_10 = false
			end
		end

		-- drop hp?
		SetRandomSeed( x + entity, y - entity )
		local hp_drop_chance = tonumber( ComponentGetValue2( comp_worldstate, "perk_hp_drop_chance" ) )
		hp_drop_chance = amount_multiplier * hp_drop_chance
		if( hp_drop_chance > 0 and Random( 1, 100 ) <= hp_drop_chance ) then
			local eid = load_gold_entity( "data/entities/items/pickup/bloodmoney_50.xml", x, y-8, remove_timer )
			money = money - 50
			
			table.insert( entity_list, {eid, 9} )
		end
	end

	--- spawn first 10 gold as small nuggets
	if( drop_first_10 ) then
		local nugget_10_count = 0
		while money >= 10 and nugget_10_count < 5 do
			local eid = load_gold_entity( gold_entity .. "10.xml", x, y-8, remove_timer )
			money = money - 10
			nugget_10_count = nugget_10_count + 1
			
			table.insert( entity_list, {eid, 6} )
		end	
	end
	
	---
	--Sets Thief gold to be 300k max in high NG+, also adds the thief's stolen player gold to the money pool
	if money > 300000 then money = 300000 end
	money = money + thiefgold

	while money >= 200000 do
		local eid = load_gold_entity( gold_entity .. "200000.xml", x, y-8, remove_timer )
		money = money - 200000
		
		table.insert( entity_list, {eid, 12} )
	end	
	
	while money >= 10000 do
		local eid = load_gold_entity( gold_entity .. "10000.xml", x, y-8, remove_timer )
		money = money - 10000
		
		table.insert( entity_list, {eid, 12} )
	end	

	while money >= 1000 do
		local eid = load_gold_entity( gold_entity .. "1000.xml", x, y-8, remove_timer )
		money = money - 1000
		
		table.insert( entity_list, {eid, 20} )
	end	

	while money >= 200 do
		local eid = load_gold_entity( gold_entity .. "200.xml", x, y-8, remove_timer )
		money = money - 200
		
		table.insert( entity_list, {eid, 12} )
	end	

	while money >= 50 do
		local eid = load_gold_entity( gold_entity .. "50.xml", x, y-8, remove_timer )
		money = money - 50
		
		table.insert( entity_list, {eid, 9} )
	end	

	while money >= 10 do
		local eid = load_gold_entity( gold_entity .. "10.xml", x, y-8, remove_timer )
		money = money - 10
		
		table.insert( entity_list, {eid, 6} )
	end	

	--1 gold nuggets need to exist because the player will likely have weird amounts of gold, not clean intervals of 20.
	while money >= 1 do
		local eid = load_gold_entity( gold_entity .. "1.xml", x, y-8, remove_timer )
		money = money - 1
		
		table.insert( entity_list, {eid, 6} )
	end	
	
	if GameHasFlagRun( "exploding_gold" ) then
		for i,v in ipairs( entity_list ) do
			local eid = v[1]
			local size = tostring(v[2])
			
			EntityAddComponent( eid, "CollisionTriggerComponent", 
			{ 
				width = size,
				height = size,
				required_tag = "enemy",
				timer_for_destruction = "5",
			} )
			
			EntityAddComponent( eid, "LuaComponent", 
			{ 
				execute_every_n_frame = "-1",
				script_collision_trigger_hit = "data/scripts/perks/gold_explosion_collision_trigger.lua"
			} )
		end
	end
end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	if entity_thats_responsible == 0 then
		do_money_drop( 2, true )
	else
		do_money_drop( 1, false )
	end

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	if Random(1,100) == 1 then
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/hiisi_thief/death", pos_x, pos_y );
	end
end