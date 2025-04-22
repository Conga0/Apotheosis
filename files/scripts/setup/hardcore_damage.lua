function damage_received( damage, desc, entity_who_caused, is_fatal )
    local entity_id = GetUpdatedEntityID()
    local healthcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local hp_max = ComponentGetValue2(healthcomp,"max_hp")
    local hp_min = hp_max * 0.01 --1% hp damage = 2s of wounded
    local wounded_time = math.min(10,math.floor(damage / hp_min) * 2)
    if wounded_time > 0 then
        local children = EntityGetAllChildren(entity_id) or {}
        local found = false
        for k=1,#children do
            if EntityGetName(children[k]) == "apotheosis_wounded" and ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(children[k],"UIIconComponent"),"icon_sprite_file") == "mods/Apotheosis/files/ui_gfx/status_indicators/nohealing_hardcore.png" then
                found = true
                local comp = EntityGetFirstComponentIncludingDisabled(children[k],"GameEffectComponent")
                ComponentSetValue2(comp,"frames",math.min(60 * 60,ComponentGetValue2(comp,"frames") + 60 * wounded_time))
                break
            end
        end
        if found == false then
            local child = EntityLoad("mods/Apotheosis/files/entities/misc/hitfx_nohealing_variable.xml",0,0)
            EntityAddComponent2(
                child,
                "GameEffectComponent",
                {
                    effect = "NONE",
                    frames = 60 * wounded_time
                }
		    )
            EntityAddChild(entity_id,child)
        end
    end
end