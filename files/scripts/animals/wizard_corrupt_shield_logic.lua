local last_frame = -100000

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local frame = GameGetFrameNum()

	local colour
	local comps = EntityGetComponent(entity_id,"VariableStorageComponent")
	for k=1,#comps
	do comp = comps[k]
		if ComponentGetValue2(comp,"name") == "shield_colour" then
			colour = ComponentGetValue2(comp,"value_string")
			last_frame = ComponentGetValue2(comp,"value_int")
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
	
	local eid = EntityLoad( "mods/apotheosis/files/entities/misc/shields/shield_" .. colour .. ".xml", pos_x, pos_y )
	EntityAddChild( entity_id, eid )

	ComponentSetValue2(comp,"value_int",GameGetFrameNum())
end
