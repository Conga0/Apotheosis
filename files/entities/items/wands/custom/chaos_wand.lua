dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once( "data/scripts/gun/gun_enums.lua")

function get_random_from( target )
	local rnd = Random(1, #target)
	
	return tostring(target[rnd])
end

function get_multiple_random_from( target, amount_ )
	local amount = amount_ or 1
	
	local result = {}
	
	for i=1,amount do
		local rnd = Random(1, #target)
		
		table.insert(result, tostring(target[rnd]))
	end
	
	return result
end

function get_random_between_range( target )
	local minval = target[1]
	local maxval = target[2]
	
	return Random(minval, maxval)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
--GamePrint("x: " .. x .. " y: " .. y)
SetRandomSeed( x, y + GameGetFrameNum() )

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

local gun = { }
gun.name = "$wand_apotheosis_chaos_wand_name"
gun.deck_capacity = {3,7}
gun.actions_per_round = {1,3}
gun.reload_time = {25,40}
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = {1,20}
gun.spread_degrees = 0
gun.speed_multiplier = 1.0
gun.mana_charge_speed = {100,250}
gun.mana_max = {400,700}

local mana_max = get_random_between_range( gun.mana_max )

ComponentSetValue( ability_comp, "ui_name", gun.name )

local reload_time = get_random_between_range( gun.reload_time )
ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", reload_time )
local fire_rate_wait = get_random_between_range( gun.fire_rate_wait )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", fire_rate_wait )
ComponentSetValue( ability_comp, "mana_charge_speed", get_random_between_range( gun.mana_charge_speed ) )

local deck_capacity = get_random_between_range( gun.deck_capacity )
if Random(1,1000) == 1 then
	deck_capacity = deck_capacity + 1
	while Random(1,10) ~= 1 do
		deck_capacity = deck_capacity + 1
	end
end

ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity )
local multicast_count = get_random_between_range( {1,deck_capacity} )
ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", multicast_count )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun.speed_multiplier )

ComponentSetValue( ability_comp, "mana_max", mana_max )
ComponentSetValue( ability_comp, "mana", mana_max )

AddGunActionPermanent( entity_id, "DRAW_RANDOM_X3")

function AddSpellToWand(wand_id,spell_type,level,x,y)
	local card = GetRandomActionWithType( x, y, level, spell_type, 666 )
	AddGunAction( wand_id, card )
end

function GenerateCardsSimple(wand_id,deck_capacity,level)
	local x, y = EntityGetTransform( wand_id )
	SetRandomSeed(x,y)
	local cards_to_generate = Random(1,deck_capacity)

	--Generate modifiers
	if cards_to_generate > 1 and Random(1,2) == 1 then
		local cards = Random(0,cards_to_generate-1)
		for k=1,cards do
			AddSpellToWand(wand_id,ACTION_TYPE_MODIFIER,level,x+k,y+k)
		end
		cards_to_generate = cards_to_generate - cards
	end

	--Generate multicasts
	if cards_to_generate > 1 and Random(1,2) == 1 then
		local cards = Random(0,cards_to_generate-1)
		for k=1,cards do
			AddSpellToWand(wand_id,ACTION_TYPE_DRAW_MANY,level,x+k,y+k)
		end
		cards_to_generate = cards_to_generate - cards
	end

	--Generate projectiles
	if cards_to_generate > 0 then
		for k=1,cards_to_generate do
			AddSpellToWand(wand_id,ACTION_TYPE_PROJECTILE,level,x,y)
		end
		return
	end
end

function GenerateWandSprite(deck_capacity,actions_per_round,fire_rate_wait,reload_time)
	local wand_sprite = "chaos_wand.xml"
	local capacity_power = (deck_capacity - gun.deck_capacity[1]) / (gun.deck_capacity[2] - gun.deck_capacity[1])
	local multicast_power = (actions_per_round - 1) / (deck_capacity - 1)
	local fire_rate_power = 1 - ((((fire_rate_wait - gun.fire_rate_wait[1]) / (gun.fire_rate_wait[2] - gun.fire_rate_wait[1])) + ((reload_time - gun.reload_time[1]) / (gun.reload_time[2] - gun.reload_time[1]))) / 2)
	local standout_amount = 0.4

	if capacity_power > multicast_power + standout_amount and capacity_power > fire_rate_power + standout_amount then
		wand_sprite = "chaos_wand_capacity.xml"
	elseif multicast_power > capacity_power + standout_amount and multicast_power > capacity_power + standout_amount then
		wand_sprite = "chaos_wand_multicast.xml"
	elseif fire_rate_power > capacity_power + standout_amount and fire_rate_power > multicast_power + standout_amount then
		wand_sprite = "chaos_wand_rapidfire.xml"
	end

	--[[
	print("deck_capacity: " .. deck_capacity .. " | capacity_power: " .. capacity_power)
	print("actions_per_round: " .. actions_per_round .. " | multicast_power: " .. multicast_power)
	print("fire_rate_wait: " .. fire_rate_wait .. " reload_time: " .. reload_time .. " | fire_rate_power: " .. fire_rate_power)
	print("wand_sprite: " .. wand_sprite)
	]]--

	ComponentSetValue2(ability_comp,"sprite_file","mods/Apotheosis/files/items_gfx/wands/custom/" .. wand_sprite)
	local sprite_comp = EntityGetFirstComponent(entity_id,"SpriteComponent")
	ComponentSetValue2(sprite_comp,"image_file","mods/Apotheosis/files/items_gfx/wands/custom/" .. wand_sprite)
end

--Generate Spells
GenerateCardsSimple(entity_id,deck_capacity,4)
GenerateWandSprite(deck_capacity,multicast_count,fire_rate_wait,reload_time)

local item_comp = EntityGetFirstComponent( entity_id, "ItemComponent" )
ComponentSetValue2( item_comp, "item_name", "$wand_apotheosis_chaos_wand_name" )
ComponentSetValue2( item_comp, "always_use_item_name_in_ui", true )
