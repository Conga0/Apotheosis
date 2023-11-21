
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

local luacomps = EntityGetComponent(player_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_death") == "mods/apotheosis/files/scripts/status_effects/flesh_curse_death.lua" then
        EntityRemoveComponent(player_id, luacomps[i])
    end
end

-- hopefully nothing in the future makes the player themselves emit infectious blood...
local particlecomps = EntityGetComponent(player_id, "ParticleEmitterComponent") or {}
for i = 1, #particlecomps do
    if ComponentGetValue2(particlecomps[i], "emitted_material_name") == "apotheosis_blood_infectious_fading_slow" then
        EntityRemoveComponent(player_id, particlecomps[i])
    end
end