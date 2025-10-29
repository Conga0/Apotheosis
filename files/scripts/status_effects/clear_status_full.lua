dofile_once("data/scripts/status_effects/status_list.lua")

local entity_id = EntityGetParent(GetUpdatedEntityID())

for k=1,#status_effects
do local v = status_effects[k]
    if v.is_harmful == true then
        EntityRemoveIngestionStatusEffect( entity_id, v.id )
    end
end

local children = EntityGetAllChildren(entity_id)
for k=1,#children
do local v = children[k]
    if EntityHasTag(v,"harmful_status") then
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
end
