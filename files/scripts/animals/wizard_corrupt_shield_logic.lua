local last_frame = -100000
local shield_made = false

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local frame = GameGetFrameNum()

	--Prevents duplicate shields if the creature was hit multiple times on the same frame
	if frame < last_frame then shield_made = false end

	local colour
	local comps = EntityGetComponent(entity_id,"VariableStorageComponent")
	for k=1,#comps
	do comp = comps[k]
		if ComponentGetValue2(comp,"name") == "shield_colour" then
			colour = ComponentGetValue2(comp,"value_string")
			last_frame = ComponentGetValue2(comp,"value_int")
		end
	end

	if ( entity_who_caused == entity_id ) or (frame <= last_frame + 60*10) or (shield_made == true) then return end

	shield_made = true
	local eid = EntityLoad( "mods/apotheosis/files/entities/misc/shields/shield_" .. colour .. ".xml", pos_x, pos_y )
	EntityAddChild( entity_id, eid )

	ComponentSetValue2(comp,"value_int",GameGetFrameNum())
end
