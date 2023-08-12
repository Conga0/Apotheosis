
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)

EntityAddComponent2(
    target,
    "LuaComponent",
    {
		execute_on_added=false,
		script_teleported="mods/Apotheosis/files/scripts/status_effects/teleport_rideshare_teleport.lua",
		execute_every_n_frame=-1,
		remove_after_executed=false,
    }
)
