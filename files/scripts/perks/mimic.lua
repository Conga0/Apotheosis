
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local root = EntityGetRootEntity(entity_id)
local cooldown_frames = 30
local cooldown_frame
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local current_frame = GameGetFrameNum()
local has_flag = GameHasFlagRun("apotheosis_perk_mimic_reveal")
local has_flag_slowupdate = GameHasFlagRun("apotheosis_perk_mimic_slowupdate")
local is_mimic = false

if EntityHasTag(root,"polymorphed_player") then
    is_mimic = true
end

cooldown_frame = tonumber(GlobalsGetValue("apotheosis_mimic_perk_cd","0"))
if current_frame >= cooldown_frame then
    if isButtonDown("disguise") then
        if is_mimic then
            local children = EntityGetAllChildren(root)
            for k=1,#children do
                local comp = EntityGetFirstComponentIncludingDisabled(children[k],"GameEffectComponent")
                if comp ~= nil and ComponentGetValue2(comp,"effect") == "POLYMORPH" then
                    ComponentSetValue2(comp,"frames",2)
                end
            end
        elseif EntityHasTag(root,"player_unit") then
            local protection_polymorph = GameGetGameEffectCount(root, "PROTECTION_POLYMORPH" )
            if protection_polymorph > 0 then
                EntityKill(ComponentGetEntity( GameGetGameEffect( root, "PROTECTION_POLYMORPH" ) ) )
            end
            LoadGameEffectEntityTo( root, "mods/Apotheosis/files/entities/misc/effect_polymorph_mimic_statue.xml" )
            GlobalsSetValue("apotheosis_mimic_perk_cd", tostring(current_frame + cooldown_frames))
            GameAddFlagRun("apotheosis_perk_mimic_reveal")
        end
    end
end

if has_flag_slowupdate == false or current_frame % 120 == 0 then
    local uicomp = EntityGetFirstComponentIncludingDisabled(entity_id,"UIIconComponent")
    local hotkey = ModSettingGet("Apotheosis.bind_disguise_translated")
    local desc
    if is_mimic then
        desc = GameTextGetTranslatedOrNot("$perk_apotheosis_mimic_tip_desc"):gsub("$0",hotkey)
    elseif not has_flag then
        desc = GameTextGetTranslatedOrNot("$perk_apotheosis_mimic_description"):gsub("$0",hotkey)
    else
        desc = GameTextGetTranslatedOrNot("$perk_apotheosis_mimic_revealed_description"):gsub("$0",hotkey)
        GameAddFlagRun("apotheosis_perk_mimic_slowupdate")
    end
    if uicomp == nil then
        local children = EntityGetAllChildren(root)
        for k=1,#children do
            if EntityHasTag(children[k],"perk_entity") then
                uicomp = EntityGetFirstComponentIncludingDisabled(children[k],"UIIconComponent")
                if uicomp ~= nil then
                    if ComponentGetValue2(uicomp,"description") == "$perk_apotheosis_mimic_description" or ComponentGetValue2(uicomp,"description") == "$perk_apotheosis_mimic_revealed_description" then
                        break
                    end
                end
            end
        end
    end

    ComponentSetValue2(uicomp,"description",desc)

    if is_mimic then
        ComponentSetValue2(uicomp,"name","$perk_apotheosis_mimic_tip")
    elseif has_flag then
        ComponentSetValue2(uicomp,"name","$perk_apotheosis_mimic_revealed")
        ComponentSetValue2(uicomp,"icon_sprite_file","mods/Apotheosis/files/ui_gfx/perk_icons/mimic_perk.png")
    end
end