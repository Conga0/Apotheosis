local last_frame = -100000

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local frame = GameGetFrameNum()
	local vcomp = 0
	local vcomp2 = 0

	local colour
	local colour2
	local cooldown_frame
	local bloodlinked = false
	local comps = EntityGetComponent(entity_id,"VariableStorageComponent")
	for k=1,#comps
	do comp = comps[k]
		if ComponentGetValue2(comp,"name") == "shield_colour" then
			vcomp = comp
			colour = ComponentGetValue2(comp,"value_string")
			last_frame = ComponentGetValue2(comp,"value_int")
		end
		if ComponentGetValue2(comp,"name") == "bloodlinker" then
			vcomp2 = comp
			colour2 = ComponentGetValue2(comp,"value_string")
			cooldown_frame = ComponentGetValue2(comp, "value_int")
			bloodlinked = ComponentGetValue2(comp, "value_bool")
		end
	end

	if ( entity_who_caused == entity_id ) or (frame <= last_frame + 60*10) then return end

	local children = EntityGetAllChildren(entity_id)
	for k=1,#children
	do v = children[k]
		if EntityGetName(v) == "corrupted_shield" then
			EntityKill(v)
			break
		end
	end

	if (cooldown_frame < frame) or (bloodlinked) then
		if EntityHasTag(entity_who_caused,"player_unit") or EntityHasTag(entity_id,"polymorphed_player") then
			colour = colour2
		end
	end
	
	local eid = EntityLoad( table.concat({"mods/apotheosis/files/entities/misc/shields/shield_",colour,".xml"}), pos_x, pos_y )
	EntityAddChild( entity_id, eid )

	ComponentSetValue2(vcomp,"value_int",GameGetFrameNum())
end
