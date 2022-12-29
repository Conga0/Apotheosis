dofile_once("data/scripts/lib/utilities.lua")


function do_money_drop( amount_multiplier )
	
	if ( GameGetIsTrailerModeEnabled() ) then return end

	local entity = GetUpdatedEntityID()

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

	amount = amount * amount_multiplier
	--[[if( amount > ( 15 * amount_multiplier ) ) then
		amount = 15 * amount_multiplier
	end]]--

	local money = 10 * amount
	local x, y = EntityGetTransform( entity )

	--- spawn first 10 gold as small nuggets
	local nugget_10_count = 0
	while money >= 10 and nugget_10_count < 5 do
		EntityLoad( "data/entities/items/pickup/goldnugget_10.xml", x, y + 9.5 )
		money = money - 10
		nugget_10_count = nugget_10_count + 1
	end	

	---
	while money >= 10000 do
		EntityLoad( "data/entities/items/pickup/goldnugget_10000.xml", x, y + 9.5 )
		money = money - 10000
	end	

	while money >= 1000 do
		EntityLoad( "data/entities/items/pickup/goldnugget_1000.xml", x, y + 9.5 )
		money = money - 1000
	end	

	while money >= 200 do
		EntityLoad( "data/entities/items/pickup/goldnugget_200.xml", x, y + 9.5 )
		money = money - 200
	end	

	while money >= 50 do
		EntityLoad( "data/entities/items/pickup/goldnugget_50.xml", x, y + 9.5 )
		money = money - 50
	end	

	while money >= 10 do
		EntityLoad( "data/entities/items/pickup/goldnugget_10.xml", x, y + 9.5 )
		money = money - 10
	end	

end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	do_money_drop( 1 )
end