local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")

if comp then
    
    --Sets MOTD message depending on date & time, automatically updates between days
    local year, month, day, hour = GameGetDateAndTimeLocal()
    --This should never appear under any circumstances.. Unless you did something really, *really* bad
    local motd = "$motd_apotheosis_description"
    if GameHasFlagRun(table.concat({"apothe","osis_","div","ine_red_fi","sh"})) then
        --Reed Feesh
        motd = motd .. "_red_fish"
    elseif (month == 1) and (day == 1) then
        --New Year
        motd = motd .. "_new_year"
    elseif (month == 7) and ((day >= 20) and (day <= 22)) then
        --Birthday
        motd = motd .. "_birthday"
    elseif (month == 10) and (day >= 15) and (hour % 2 == 0) then
        --Halloween
        motd = motd .. "_halloween"
    elseif (month == 12) and (day >= 15) and (hour % 2 == 0) then
        --Smissmass
        motd = motd .. "_smissmass"
    else
        -- Regular MOTD values
        if day <= 31 then
            motd = table.concat { motd, "_", string.format("%03d", day) }
        end
    end
    -- Set updated motd
    ComponentSetValue2(comp, "ui_text", motd)
end

--[[
        -- Regular MOTD values
        if month % 2 == 0 then
            if day <= 31 then
                motd = table.concat { motd, "_alt_", string.format("%03d", day) }
            end
        else
            if day <= 31 then
                motd = table.concat { motd, "_", string.format("%03d", day) }
            end
        end
]]