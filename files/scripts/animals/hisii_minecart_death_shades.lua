dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local health = 0
	local max_health = 0

	local eid = EntityLoad( "data/entities/animals/secret/shotgunner.xml", pos_x, pos_y )
	
	EntityAddComponent( eid, "LuaComponent", 
	{ 
		execute_every_n_frame = "-1",
		script_death = "data/scripts/items/drop_money4x.lua",
		remove_after_executed = "1",
	} )

	if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then
		local comp = EntityGetFirstComponent( eid, "DamageModelComponent" )

		local health = ComponentGetValue2( comp, "hp" )
		local health_max = ComponentGetValue2( comp, "max_hp" )

		health = health * 2
		health_max = health_max * 2

		ComponentSetValue( comp, "max_hp", tostring(health_max) )
		ComponentSetValue( comp, "hp", tostring(health) )
	end

	--EntityKill( entity_id )
end