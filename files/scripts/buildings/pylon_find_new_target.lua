
local entity_id = GetUpdatedEntityID()

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local target = ComponentGetValue2(comp,"value_int")

if EntityHasTag(target,"mortal") == false then
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent"),"mNextExecutionTime",(GameGetFrameNum() + 2))
end