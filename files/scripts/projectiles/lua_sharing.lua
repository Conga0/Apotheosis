local entity_id = GetUpdatedEntityID()

if EntityGetName(entity_id) ~= "separator" then

	local values = {}
	local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
	for k=1,#comps
	do local v = comps[k]
		if ComponentGetValue2(v,"script_source_file") ~= "mods/Apotheosis/files/scripts/projectiles/lua_sharing.lua" then
			values = {
				execute_on_added = ComponentGetValue2(v,"execute_on_added"),
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
        local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
        local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
        local i, j = string.find(desc, "\nCASTSTATE_APOLUASHARE|([a-zA-Z0-9]*)")
        caststate = (string.sub(desc, i, j))
    end

    local player_projectiles = EntityGetWithTag("projectile_player") or {}
    for index = 1, #player_projectiles do
        local target = player_projectiles[index]
        local projcomp = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent")
        local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
        local i, j = string.find(desc, "\nCASTSTATE_APOLUASHARE|([a-zA-Z0-9]*)")
        local target_caststate = (string.sub(desc, i, j))
        if target_caststate == caststate then
			EntityAddComponent2(target, "LuaComponent", values )
        end
    end
end