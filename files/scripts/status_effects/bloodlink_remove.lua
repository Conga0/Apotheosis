
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

if EntityGetIsAlive(player_id) == false then return end 

local luacomps = EntityGetComponent(player_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_damage_received") == "mods/Apotheosis/files/scripts/status_effects/bloodlink_damage.lua" then
        EntityRemoveComponent(player_id, luacomps[i])
    end
end