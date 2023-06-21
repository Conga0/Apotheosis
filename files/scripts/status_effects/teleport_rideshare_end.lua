
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
local comps = EntityGetComponentIncludingDisabled(target,"LuaComponent")

for k=1,#comps
do local v = comps[k]
    if ComponentGetValue2(v,"script_teleported") == "mods/Apotheosis/files/scripts/status_effects/teleport_rideshare_teleport.lua" then
        EntityRemoveComponent(target,v)
    end
end
