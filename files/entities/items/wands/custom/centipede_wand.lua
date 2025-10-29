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
gun.name = "$wand_apotheosis_centipede_wand_name"
gun.deck_capacity = {26,30}
gun.actions_per_round = 1
gun.reload_time = {20,30}
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = {-30,15}
gun.spread_degrees = -20
gun.speed_multiplier = 1.33
gun.mana_charge_speed = {700,900}
gun.mana_max = {1500,1800}

local mana_max = get_random_between_range( gun.mana_max )

ComponentSetValue( ability_comp, "ui_name", gun.name )

ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", get_random_between_range( gun.reload_time ) )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", get_random_between_range( gun.fire_rate_wait ) )
ComponentSetValue( ability_comp, "mana_charge_speed", get_random_between_range( gun.mana_charge_speed ) )

local deck_capacity = get_random_between_range( gun.deck_capacity )
if Random(1,1000) == 1 then
	deck_capacity = deck_capacity + 1
	while Random(1,10) ~= 1 do
		deck_capacity = deck_capacity + 1
	end
end

ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity )
ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun.actions_per_round )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun.speed_multiplier )

ComponentSetValue( ability_comp, "mana_max", mana_max )
ComponentSetValue( ability_comp, "mana", mana_max )

AddGunActionPermanent( entity_id, "APOTHEOSIS_SUPPORT_PASSIVE")

function AddSpellToWand(wand_id,spell_type,level,x,y)
	local card = GetRandomActionWithType( x, y, level, spell_type, 666 )
	AddGunAction( wand_id, card )
end

function GenerateCardsSimple(wand_id,deck_capacity,level)
	local x, y = EntityGetTransform( wand_id )
	SetRandomSeed(x,y)
	local cards_to_generate = Random(10,deck_capacity-10)

	--Generate modifiers
	if cards_to_generate > 1 and Random(1,2) == 1 then
		local cards = Random(0,math.floor((cards_to_generate * 0.5)-1))
		for k=1,cards do
			AddSpellToWand(wand_id,ACTION_TYPE_MODIFIER,level,x+k,y+k)
		end
		cards_to_generate = cards_to_generate - cards
	end

	--Generate multicasts
	if cards_to_generate > 1 and Random(1,2) == 1 then
		local cards = Random(0,math.floor((cards_to_generate * 0.5)-1))
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

--Generate Spells
GenerateCardsSimple(entity_id,deck_capacity,6)

local item_comp = EntityGetFirstComponent( entity_id, "ItemComponent" )
ComponentSetValue2( item_comp, "item_name", "$wand_apotheosis_centipede_wand_name" )
ComponentSetValue2( item_comp, "always_use_item_name_in_ui", true )
