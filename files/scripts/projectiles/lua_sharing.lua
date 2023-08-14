local entity_id = GetUpdatedEntityID()
if EntityHasTag(entity_id,"cast_share") == false then
	EntityAddTag(entity_id, "cast_share")

	--TODO
	--Entity Add Component, this component is a lua script with a shot script
	--If the entity shoots a projectile, then the magic properties will be carried over to the newly shot out projectile.
	--Only need to transfer the tag & projectile description on shoot. Don't make an infinite lua share loop!!!
else
	if EntityGetName(entity_id) ~= "separator" then

		--Grab the first lua component
		local values = {}
		local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent") or {}
		for k=1,#comps
		do local v = comps[k]
			if ComponentGetValue2(v,"script_source_file") ~= "mods/Apotheosis/files/scripts/projectiles/lua_sharing.lua" then
				values = {
					script_source_file = ComponentGetValue2(v,"script_source_file"),
					execute_every_n_frame = ComponentGetValue2(v,"execute_every_n_frame"),
					remove_after_executed = ComponentGetValue2(v,"remove_after_executed"),
					execute_times = ComponentGetValue2(v,"execute_times"),
					execute_on_removed = ComponentGetValue2(v,"execute_on_removed"),
					execute_on_added = ComponentGetValue2(v,"execute_on_added"),
					script_death = ComponentGetValue2(v,"script_death")
				}
				break
			end
		end

		local caststate = nil
		do  -- Get cast state
			local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
			local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
			local i, j = string.find(desc, "\nCASTSTATE_APOLUASHARE|([a-zA-Z0-9]*)")
			caststate = (string.sub(desc, i, j))
		end

		local player_projectiles = EntityGetWithTag("cast_share") or {}
		for index = 1, #player_projectiles do
			local target = player_projectiles[index]
			local projcomp = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent") --[[@cast projcomp number]]
			local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
			local i, j = string.find(desc, "\nCASTSTATE_APOLUASHARE|([a-zA-Z0-9]*)")
			local target_caststate = (string.sub(desc, i, j))
			if target_caststate == caststate then
				EntityAddComponent2(target, "LuaComponent", values )
			end
		end
	end
end