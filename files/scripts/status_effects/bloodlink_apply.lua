
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

EntityAddComponent( player_id, "LuaComponent",
{
    script_damage_received="mods/Apotheosis/files/scripts/status_effects/bloodlink_damage.lua",
    execute_every_n_frame="-1",
})