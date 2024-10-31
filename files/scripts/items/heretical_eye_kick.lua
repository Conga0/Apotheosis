function kick( entity_who_kicked )

    local entity_id = GetUpdatedEntityID()

    local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
    local kicks_row = (ComponentGetValue2( kickcomp, "value_int") + 1) --Kicks in a row, resets after a short time
    local kicks_streak = tonumber(ComponentGetValue2( kickcomp, "value_string")) --Highest streak of kicks in a row
    local streak_attempt = ComponentGetValue2( kickcomp, "value_bool")
    local kicks_timer = ComponentGetValue2( kickcomp, "value_float")
    local kicks_overtime = tonumber(GlobalsGetValue("HERETIC_KICKED")) --All kicks ever done to Heretic
    if kicks_overtime == nil then
	kicks_overtime = 0
    end
    local kick_time = 300 --5 seconds

    if GameHasFlagRun("apotheosis_heretalk_id_14") and (kicks_row > kicks_streak) then --Streak won't go up unless you've let Heretic do his opening dialogue
	ComponentSetValue2( kickcomp, "value_string", tostring(kicks_row))
    end

    if (streak_attempt == false) and (kicks_row >= 10) then
	ComponentSetValue2( kickcomp, "value_bool", true)
    end

    if (GameGetFrameNum() >= kicks_timer + kick_time) then
	kicks_row = 1
    end

    GlobalsSetValue("HERETIC_KICKED", tostring(kicks_overtime + 1))
    ComponentSetValue2( kickcomp, "value_int", kicks_row)
    ComponentSetValue2( kickcomp, "value_float", GameGetFrameNum())
end
