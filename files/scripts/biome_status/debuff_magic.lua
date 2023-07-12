
function collision_trigger( player_id )

	local children = EntityGetAllChildren(player_id)
	local found = false
	for k=1,#children
	do local v = children[k]
		if EntityGetName(v) == "apotheosis_no_flight" and EntityHasTag(v,"watermage") then
			--Remove the previous curse.. might be better to just do this through the gate portal though
			EntityKill(v)
		elseif EntityGetName(v) == "apotheosis_no_flight" and EntityHasTag(v,"watermage") then
			found = true
			break
		end
	end

	if found == false and 2 == 1 then
		local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_magic_curse.xml", x, y )
		EntityAddChild( player_id, eid )
	end

	EntitySetComponentsWithTagEnabled(GetUpdatedEntityID(),"invincible",false)
end
