dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

function SpecialModifierCheck(filename,current_flags,vsccomp)

    local special_victims = {
        {"wizard_tele.xml","wizard_swapper.xml","slime_teleporter.xml","fairy_big_discord.xml"}, -- 1: teleportation ability
        {"wraith.xml","wraith_glowing.xml","wraith_storm.xml","wraith_weirdo_shield.xml","wraith_returner_apotheosis.xml","wraith_alchemy_apotheosis.xml"} -- 2: reflection ability
    }

    for k=1,#special_victims do
        local v = special_victims[k]
        for z=1,#v do
            if filename == v[z] then
                print("Found special victim, applying bit flag")
                GamePrint("Found special victim, applying bit flag")
                current_flags = add_bit_flag(current_flags, k)
                print("current_flags is " .. current_flags)
                break
            end
        end
    end
    ComponentSetValue2(vsccomp,"value_string",tostring(current_flags))
end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
    GamePrint("Running pixie death script")
    if entity_thats_responsible ~= 0 then
        local vcomps = EntityGetComponentIncludingDisabled(entity_thats_responsible,"VariableStorageComponent") or {}
        for k=1,#vcomps do
            if ComponentGetValue2(vcomps[k],"name") == "pixie_level_data" then
                GamePrint("pixie found, rewarding exp")
                local hpcomp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(),"DamageModelComponent")
                local hp = ComponentGetValue2(hpcomp,"max_hp") * 25
                local current_pixie_exp = ComponentGetValue2(vcomps[k],"value_float") + hp
                ComponentSetValue2(vcomps[k],"value_float",current_pixie_exp)
                local current_flags = ComponentGetValue2(vcomps[k],"value_string")

                local filepath = EntityGetFilename(GetUpdatedEntityID())
                local last_slash = filepath:find("/[^/]*$")
                local filename = filepath:sub(last_slash + 1)
                SpecialModifierCheck(filename,tonumber(current_flags),vcomps[k])
                return
            end
        end
    end
end