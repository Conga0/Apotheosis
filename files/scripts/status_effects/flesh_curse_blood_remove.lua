
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

if EntityGetIsAlive(player_id) == false then return end 

local luacomps = EntityGetComponent(player_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_death") == "mods/Apotheosis/files/scripts/status_effects/flesh_curse_death.lua" then
        EntityRemoveComponent(player_id, luacomps[i])
    end
end

local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
local new_blood = ComponentGetValue2(dmgcomp,"blood_material")

--GamePrint("new_blood: " .. tostring(new_blood))

if ( new_blood == "apotheosis_blood_infectious_fading_slow") then -- incase they for whatever reason pick up a blood perk
    local bloodvarcomp = EntityGetComponentIncludingDisabled( player_id, "VariableStorageComponent" )
    for k=1,#bloodvarcomp
    do local v = bloodvarcomp[k]
	if ComponentGetValue2(v,"name") == "sacreligious_bloody" then
	    bloodvarcomp = v
	    break
	end
    end

    local old_blood = ComponentGetValue2(bloodvarcomp,"value_string")

    --GamePrint("old_blood: " .. tostring(old_blood))

    ComponentSetValue2(dmgcomp,"blood_material",old_blood)

    EntityRemoveComponent(player_id, bloodvarcomp)
end

-- hopefully nothing in the future makes the player themselves emit infectious blood...
local particlecomps = EntityGetComponent(player_id, "ParticleEmitterComponent") or {}
for i = 1, #particlecomps do
    if ComponentGetValue2(particlecomps[i], "emitted_material_name") == "apotheosis_blood_infectious_fading_slow" then
        EntityRemoveComponent(player_id, particlecomps[i])
    end
end