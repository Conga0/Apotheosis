--if the player leaves the stone behind, then spawn a couple corrupt masters and pretend Heretic has it now
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then

    EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true)

    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)

    local comp_id = GetUpdatedComponentID()
    EntitySetComponentIsEnabled(entity_id,comp_id,false)
end
