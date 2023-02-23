function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local lukki_new = EntityLoad("data/entities/animals/secret/lukki_fire_miniboss_phase2.xml", pos_x, pos_y)
	GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );

	--Spits out a ton of firebolts when the rocks break
	EntityAddComponent2(
		lukki_new,
		"LuaComponent",
		{
			execute_on_added = false,
			script_source_file = "data/entities/animals/boss_fire_lukki/boss_fire_lukki_healing_phase_logic_lowhp_burst.lua",
			execute_every_n_frame = 1,
			remove_after_executed = false,
			execute_times=7
		}
	)

	--50% speed boost in phase 2
	local comp = EntityGetComponentIncludingDisabled( lukki_new, "PhysicsAIComponent")[1]
	ComponentSetValue2(comp, "force_coeff", 24)
	ComponentSetValue2(comp, "force_max", 300)

end
