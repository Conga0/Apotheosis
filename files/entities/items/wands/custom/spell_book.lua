dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

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
SetRandomSeed( x, y + GameGetFrameNum() )

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

--[[
--Weak Stats (can be used for letters only)
local gun = { }
gun.name = {"$wand_apotheosis_spell_book_name"}
gun.deck_capacity = 20
gun.actions_per_round = 1
gun.reload_time = {33,33}
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = {11,33}
gun.spread_degrees = 0
gun.speed_multiplier = 1.00
gun.mana_charge_speed = {5,5}
gun.mana_max = {10,10}
]]--

--Strong Stats (can be used for any spells)
local gun = { }
gun.name = {"$wand_apotheosis_spell_book_name"}
gun.deck_capacity = 26
gun.actions_per_round = 1
gun.reload_time = {33,33}
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = {11,22}
gun.spread_degrees = 0
gun.speed_multiplier = 1.00
gun.mana_charge_speed = {400,600}
gun.mana_max = {1200,1800}

local mana_max = get_random_between_range( gun.mana_max )
local deck_capacity = gun.deck_capacity

ComponentSetValue( ability_comp, "ui_name", get_random_from( gun.name ) )

ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", get_random_between_range( gun.reload_time ) )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", get_random_between_range( gun.fire_rate_wait ) )
ComponentSetValue( ability_comp, "mana_charge_speed", get_random_between_range( gun.mana_charge_speed ) )

ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun.actions_per_round )
ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", gun.deck_capacity )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun.speed_multiplier )

ComponentSetValue( ability_comp, "mana_max", mana_max )
ComponentSetValue( ability_comp, "mana", mana_max )

local item_comp = EntityGetFirstComponent( entity_id, "ItemComponent" )
ComponentSetValue2( item_comp, "item_name", "$wand_apotheosis_spell_book_name" )
ComponentSetValue2( item_comp, "always_use_item_name_in_ui", true )

local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
ComponentSetValue2(sprite_comp,"image_file","mods/Apotheosis/files/items_gfx/wands/custom/spell_book.xml")