
local entity_id = GetUpdatedEntityID()
function shot( entity_id )

    EntityAddComponent2(
        entity_id
        "LuaComponent",
        {
            execute_on_added = false,
            script_source_file = "mods/Apotheosis/files/scripts/status_effects/disable_homing_shoot.lua",
            execute_every_n_frame = 2,
            remove_after_executed = true,
            execute_times=1
        }
    )
end

if EntityHasTag(entity_id,"projectile") then
    local homing_comps = EntityGetComponentIncludingDisabled(entity_id,"HomingComponent") or {}
    for k=1,#homing_comps do
        EntityRemoveComponent( entity_id, homing_comps[k] )
    end
end