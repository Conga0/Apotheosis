function RemoveDamageScript(entity_id)
    local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
    for k=1,#comps
    do local v = comps[k]
        if ComponentGetValue2(v,"script_source_file") == "mods/Apotheosis/files/scripts/animals/playerghost/tablet_damage.lua" then
            EntityRemoveComponent(entity_id,v)
            break
        end
    end
end

--Remove tablet damage if it's made contact with the ground already
function item_pickup()
    local entity_id = GetUpdatedEntityID()
    RemoveDamageScript(entity_id)
end

local entity_id = GetUpdatedEntityID()
local ghost_id = 0

if EntityGetParent(entity_id) ~= 0 then
    RemoveDamageScript(entity_id)
else
    local pos_x, pos_y = EntityGetTransform(entity_id)
    local player = EntityGetInRadiusWithTag(pos_x,pos_y,8,"player_unit")[1]
    if player then
        local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "UIInfoComponent")
        local tabletname = ComponentGetValue2(comp,"name")
        
        local comps = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent")
        for z=1,#comps
        do local c = comps[z]
            if ComponentGetValue2(c,"name") == "obj_path" then
                ghost_id = ComponentGetValue2(c,"value_int")
            end
        end
        local tabletname = ComponentGetValue2(comp,"name")
        if player then
            EntityInflictDamage(player,2.0,"DAMAGE_PROJECTILE",tabletname,"NONE",pos_x,pos_y,ghost_id,pos_x,pos_y,2)
            RemoveDamageScript(entity_id)
        end
    end
end

--I assure you, this is just as horrible as it looks
