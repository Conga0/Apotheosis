--dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_barrage.lua" then
	EntitySetComponentIsEnabled(entity_id, luacomps[i], true)
	break
    end
end

local particlecomps = EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent") or {}
for i = 1, #particlecomps do
    EntitySetComponentIsEnabled(entity_id, particlecomps[i], false)
end