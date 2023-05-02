function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

    local entity_id = GetUpdatedEntityID()

    local path = ""
    local comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    for k=1,#comps
    do local v = comps[k]
        if ComponentGetValue2(v,"name") == "tablet_path" then
            path = ComponentSetValue2(v,"value_string")
            break
        end
    end



    if path ~= nil then
        local pos_x, pos_y = EntityGetTransform(entity_id)
        EntityLoad(path,pos_x,pos_y)
    end


    --NOTE: This is still bugged, very inconsistent, but will sometimes spawn a tablet on death without picking up the original tablet, when being killed via tablet physics dmg
    --Could check for nearby entities with tag tablet, if they have the same entity filepath as the planned tablet to death, don't drop it?

    --NOTE (03/05/2023): Not sure if still bugged, tried a new method of grabbing the tablet's filepath, the originally intended method.. let's see if it still dupes...
end
