dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "InteractableComponent")


local year, month, day, hour = GameGetDateAndTimeLocal()
local rnd_seed = {year, month * day}
math.randomseed(rnd_seed[1] + rnd_seed[2]) --use math.random instead of Noita random to avoid world seed stuff


MOTD_conditionals = {
    {
        condition = GameHasFlagRun(table.concat({"apothe","osis_","div","ine_red_fi","sh"})),
        motd = "$motd_apotheosis_red_fish",
    },
    {
        condition = (month == 4) and (day == 1),
        motd = "$motd_apotheosis_april_fools",
    },
    {
        condition = (month == 1) and (day == 1),
        motd = "$motd_apotheosis_new_year",
    },
    {
        condition = (month == 7) and ((day >= 20) and (day <= 22)),
        motd = "$motd_apotheosis_birthday",
    },
    {
        condition = (month == 10) and (day >= 15) and (hour % 2 == 0),
        motd = "$motd_apotheosis_halloween",
    },
    {
        condition = (month == 12) and (day >= 15) and (hour % 2 == 0),
        motd = "$motd_apotheosis_smissmass",
    },
    {
        condition = userseed_check("00130639114681086286") and HasFlagPersistent("apotheosis_dnk_oneoff") == false,
        func = function ()
            --Special message just for dunk, using fairmod userseed tech

            -- Last time Dunk played (23rd of march 2025)
            local target_day = 23
            local target_month = 3
            local target_year = 2025

            -- Calculate the difference
            local days, months = time_since(target_day, target_month, target_year, day, month, year)

            AddFlagPersistent("apotheosis_dnk_oneoff")
            return table.concat({"Message of the Day\nWelcome back old man!\nIt's been ",days," days and ",months," months since you were last here."})
            --This can be removed next time he plays, which should be somewhere around the heat death of the unvierse
            --return "Message of the Day\n\"Dunk is bald\"\n- With love, from fairmod"
        end,
    },
    {
        condition = day == 31,
        motd = "$motd_apotheosis_toxic_nest"
    }
}


MOTD_also_try = {
    "$apotheosis_modname_worse_enemies",
    "$apotheosis_modname_copith",
    "$apotheosis_modname_conga_cats",
    "$apotheosis_modname_stray_pixel",
    "$apotheosis_modname_more_stuff",
    "$apotheosis_modname_glimmers",
    "$apotheosis_modname_gramth",
    "$apotheosis_modname_meta_level",
}

MOTD_regulars = { --global so other mods can append their own stuff if they want
    {
        probability = 25, --2.5x more likely than other MOTDs
        func = function ()
            --CC has a custom CN translation so we need to account for it separately, this check makes sure it has the same probability as the other mods
            if math.random(1, #MOTD_also_try+1) == 1 then return "$motd_apotheosis_also_try_mod_cc" end
            return GameTextGet("$motd_apotheosis_also_try_mod", GameTextGetTranslatedOrNot(MOTD_also_try[math.random(1, #MOTD_also_try)])) --pick random result from MOTD_also_try list
        end
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_homeless_hiisi"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_blood_fuel"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_meow"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_go_outside"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_init_success"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_get_out"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_eat_crayon"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_check_wand"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_lore_questions"
    },
    {
        probability = 10,
        func = function () --numbers used to be "78 40 28 59 20 13"
            local numbers = ""
            for i = 1, 6, 1 do
                numbers = numbers .. tostring("%02d"):format(math.random(0, 99)) .. " "
            end
            return GameTextGet("$motd_apotheosis_magic_numbers", numbers)
        end,
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_never_lie"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_hear_ghosts"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_sisyphus"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_music_fear"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_scattered_knowledge"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_tough_creatures"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_happy_birthday"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_red_sand"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_played_by_many"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_kind_creeps"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_water_awaits"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_have_fun"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_faith"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_void_overgrowth"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_humour_desert"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_happy_day"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_weary_travel"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_stay_inside"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_eat_powerballs"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_polish_sausage"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_those_days"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_conga_and_friends"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_intuitive_wand"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_wan_wan"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_robin_fool"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_be_honest"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_clown_circus"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_friendship_success"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_favourite_liquid_1"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_1432"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_must_fight"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_blue_fire"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_sewer_mermaids"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_deranged_maniac"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_apoth_founded"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_spy_chest"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_magic_inebriation"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_eat_healthy"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_physical_memorabilia"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_street_pass"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_five_pushups"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_feeling_lucky"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_awesome_boss"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_hungry_walls"
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_favourite_liquid_2"
    },
    {
        probability = 30,
        motd = "$motd_apotheosis_cat_killer",
        condition = tonumber(ModSettingGet("Apotheosis.cat_kills") or 0) >= 10,
    },
    {
        probability = 10,
        motd = "$motd_apotheosis_cat_deaths",
        condition = tonumber(ModSettingGet("Apotheosis.cat_deaths") or 0) >= 25,
    },
}

if comp then
    local motd = nil
    local target_found = false

    for _, value in ipairs(MOTD_conditionals) do
        if value.condition then
            motd = value.motd
            if value.func then motd = value.func() end
            break
        end
    end

    if motd == nil then

        while(target_found == false) do
            local target = ProceduralRandomFromTable(MOTD_regulars, rnd_seed)
            if target.condition ~= nil and target.condition == false and 1 == 2 then
                rnd_seed[2] = rnd_seed[2] + 1
            else
                target_found = true
            end
            motd = target.motd or target.func()
        end
    end

    --This should never appear under any circumstances.. Unless you did something really, *really* bad
    if motd == nil then motd = "$motd_apotheosis_description" end --this should not happen!

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