dofile_once("data/scripts/status_effects/status_list.lua")

local entity_id = EntityGetParent(GetUpdatedEntityID())

function removeStatusAilments(player_id)
    local children = EntityGetAllChildren(player_id)
    for k=1,#children
    do local v = children[k]
        if EntityHasTag(v,"harmful_status") or EntityHasTag(v,"very_harmful_status") then
            local comp = EntityGetFirstComponentIncludingDisabled(v,"LifetimeComponent") or 0
            if comp ~= 0 then
                ComponentSetValue2(comp,"lifetime",2)
                ComponentSetValue2(comp,"kill_frame",GameGetFrameNum() + 2)
            end
            local comp2 = EntityGetFirstComponentIncludingDisabled(v,"GameEffectComponent") or 0
            if comp2 ~= 0 then
                ComponentSetValue2(comp2,"frames",2)
            end
        end

        local comp = EntityGetFirstComponent(v,"GameEffectComponent") or 0
        if comp ~= 0 then
            local cause_id = ComponentGetValue2(comp,"causing_status_effect")
            local cause_is_ingestion = ComponentGetValue2(comp,"caused_by_ingestion_status_effect")
            local is_harmful = false

            if cause_id > 0 then
                for z=1,#status_effects
                do local s = status_effects[z]
                    if s.is_harmful == true and s.id == status_effects[cause_id].id then
                        is_harmful = true
                        break
                    end
                end
            end

            if cause_is_ingestion and is_harmful then
                EntityRemoveIngestionStatusEffect( player_id, status_effects[cause_id].id )
                ComponentSetValue2(comp,"frames",2)
            end
        end
    end
end

removeStatusAilments(player_id)