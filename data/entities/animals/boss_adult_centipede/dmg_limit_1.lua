
function damage_about_to_be_received( damage )

    local phase = 0
	local storages = EntityGetComponentIncludingDisabled( GetUpdatedEntityID(), "VariableStorageComponent" )
	if ( storages ~= nil ) then
		for i,comp in ipairs( storages ) do
			local name = ComponentGetValue2( comp, "name" )
			if ( name == "phase_brain" ) then
				phase = ComponentGetValue2( comp, "value_int")
                break
			end
		end
	end

    if damage > 0 and (phase == 2 or phase == 4) then
        return 0.04
    else
        return damage
    end
end