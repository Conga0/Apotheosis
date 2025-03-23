dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
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
    elseif (month == 4) and (day == 1) then
        --April Fools
        motd = motd .. "_april_fools"
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
    elseif userseed_check("00130639114681086286") and HasFlagPersistent("apotheosis_dnk_oneoff") == false then
        --Special message just for dunk, using fairmod userseed tech

        -- Last time Dunk played (23rd of march 2025)
        local target_day = 23
        local target_month = 3
        local target_year = 2025

        -- Calculate the difference
        local days, months = time_since(target_day, target_month, target_year, day, month, year)

        motd = table.concat({"Message of the Day\nWelcome back old man!\nIt's been ",days," days and ",months," months since you were last here."})
        AddFlagPersistent("apotheosis_dnk_oneoff")
        --This can be removed next time he plays, which should be somewhere around the heat death of the unvierse
        --motd = "Message of the Day\n\"Dunk is bald\"\n- With love, from fairmod"
    else
        -- Regular MOTD values
        -- MOTD switches between original & alt list every month
        if day <= 31 then
            if month % 2 == 0 then
                motd = table.concat { motd, "_alt_", string.format("%03d", day) }
            else
                motd = table.concat { motd, "_", string.format("%03d", day) }
            end
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