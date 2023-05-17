
function collision_trigger( player_id )

	local children = EntityGetAllChildren(player_id)
	local found = false
	for k=1,#children
	do local v = children[k]
		if EntityGetName(v) == "apotheosis_curse_of_yggdrasil" then
			found = true
			break
		end
	end

	if found == false then
		local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_yggdrasil_curse.xml", x, y )
		EntityAddChild( player_id, eid )
	end

	EntityKill(GetUpdatedEntityID())
end
