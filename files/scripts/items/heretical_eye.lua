
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then
    local eye = EntityGetAllChildren(entity_id)[1]
    EntitySetComponentsWithTagEnabled(eye,"enabled_in_world",true)

    --Disables the lua component so it doesn't keep run unnecessarily
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
    EntitySetComponentIsEnabled(entity_id,comp,false)
end
