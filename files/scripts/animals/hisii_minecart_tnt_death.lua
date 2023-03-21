dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local health = 0
	local max_health = 0
	local combo_count = 2

	local eid = ""

	if seasonalSetting == true then
		if ( month == 12 ) and ( day >= 15 ) then
			eid = EntityLoad( "data/entities/animals/miner_santa.xml", pos_x, pos_y )
		else
			eid = EntityLoad( "data/entities/animals/miner_weak.xml", pos_x, pos_y )
		end
	else
		eid = EntityLoad( "data/entities/animals/miner_weak.xml", pos_x, pos_y )
	end

	local VSCComps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
	if VSCComps then
		for k=1,#VSCComps
		do v = VSCComps[k]
			if ComponentGetValue2(v,"name") == "cart_combo_bonus" then
				combo_count = ComponentGetValue2(v,"value_int")
			end
		end
	end

	if combo_count > 64 then combo_count = 64 end

	EntityAddComponent2(
		eid,
		"VariableStorageComponent",
		{
			name="cart_combo_bonus",
			value_int=combo_count * 2,
		}
	)

	EntityAddComponent( eid, "LuaComponent", 
	{ 
		execute_every_n_frame = "-1",
		script_death = "data/scripts/items/drop_money4x.lua",
		script_death = "data/scripts/items/drop_money" .. combo_count * 2 .. "x.lua",
		remove_after_executed = "1",
	} )

	--GamePrint("combo_count is " .. combo_count)

	--EntityKill( entity_id )
end



