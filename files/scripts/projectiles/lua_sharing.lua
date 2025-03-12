local extract = dofile_once("mods/Apotheosis/files/scripts/misc/proj_data.lua")
local entity_id = GetUpdatedEntityID()
if EntityHasTag(entity_id,"cast_share") == false then
	EntityAddTag(entity_id, "cast_share")

	--TODO
	--Entity Add Component, this component is a lua script with a shot script
	--If the entity shoots a projectile, then the magic properties will be carried over to the newly shot out projectile.
	--Only need to transfer the tag & projectile description on shoot. Don't make an infinite lua share loop!!!

	-- Hey conga, about this
	-- Sounds like it could be fucking awesome :3
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

		local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
		local cast_state = extract(projcomp, {1})

		local player_projectiles = EntityGetWithTag("cast_share") or {}
		for index = 1, #player_projectiles do
			local target = player_projectiles[index]
			local projcomp2 = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent") --[[@cast projcomp number]]
			local target_caststate = extract(projcomp2, {1})
			if target_caststate == cast_state then
				EntityAddComponent2(target, "LuaComponent", values )
			end
		end
	end
end