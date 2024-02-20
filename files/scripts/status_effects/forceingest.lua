local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"IngestionComponent")

if comp then
    local stomach = ComponentGetValue2(comp, "ingestion_size")
    ComponentSetValue2(comp, "ingestion_size", stomach + 3000)
end