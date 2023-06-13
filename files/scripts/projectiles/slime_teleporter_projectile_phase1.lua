
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local vsccomp = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
for k=1,#vsccomp
do local v = vsccomp[k]
    if ComponentGetValue2(v,"name") == "teleport_data" then
        ComponentSetValue2(v,"value_int",pos_x)
        ComponentSetValue2(v,"value_float",pos_y)
        break
    end
end
