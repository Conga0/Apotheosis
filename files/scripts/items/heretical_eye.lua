
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then
    local eye = EntityGetAllChildren(entity_id)[1]
    if EntityGetComponent(eye, "SpriteComponent", "enabled_in_world") == nil then
        EntitySetComponentsWithTagEnabled(eye,"enabled_in_world",true)
    end

    --Disables the lua component so it doesn't keep run unnecessarily
    --Sorry, but you're under new management now >:) -Spoop
    --local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
    --EntitySetComponentIsEnabled(entity_id,comp,false)

    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    local timer = ComponentGetValue2( timercomp, "value_float")
    local current_time = GameGetFrameNum()
    local thrown_time = ComponentGetValue2( timercomp, "value_int")
    local time = 0

    if thrown_time <= 0 then
        thrown_time = ComponentSetValue2( timercomp, "value_int", current_time)
    elseif thrown_time > 0 then
        time = current_time - thrown_time
    end

    ComponentSetValue2( timercomp, "value_float", time)

else
    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)
end
