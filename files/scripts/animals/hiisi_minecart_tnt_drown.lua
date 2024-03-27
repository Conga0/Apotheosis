
function cartGold()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local health = 0
	local max_health = 0
	local combo_count = 2

	local eid = ""

	if seasonalSetting == true then
		if ( month == 12 ) and ( day >= 15 ) or ModSettingGet("Apotheosis.seasonal_events_forced_smissmass") then
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

	if combo_count >= 64 then
		combo_count = 64
		local c = EntityLoad("mods/apotheosis/files/entities/misc/drop_gold_visual.xml", x, y)
		EntityAddChild(eid,c)
	end

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
		--script_death = "data/scripts/items/drop_money4x.lua",
		script_death = "data/scripts/items/drop_money" .. (math.min(64,combo_count * 2)) .. "x.lua",
		remove_after_executed = "1",
	} )

    EntityInflictDamage( eid, 2, "DAMAGE_DROWNING", "Drowning", "NONE", 0, 0, 0 )
end

function damage_about_to_be_received( damage )
    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local air = ComponentGetValue2(comp,"air_in_lungs")
    local hp = ComponentGetValue2(comp,"hp")
    if air < 0.1 and hp < 0.12 then
        local x,y = EntityGetTransform(entity_id)
        cartGold()
        EntityLoad("data/entities/props/physics_minecart.xml", x, y + 5)
        EntityKill(entity_id)
    else
        return damage
    end
end
