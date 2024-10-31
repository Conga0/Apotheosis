--For further elaboration on what this is for please check heretical_eye_destroyed.lua
--Nevermind turns out this might not be needed? Still keeping it though just in case...
local entity_id = GetUpdatedEntityID()
local incarncomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
local ngplus = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT"))
ComponentSetValue2( incarncomp, "value_int", ngplus)