local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
if EntityHasTag(root,"player_unit") then
    local comps = EntityGetAllComponents(entity_id)
    for k=1,#comps do
        if ComponentHasTag(comps[k],"wand_glow") then
            EntityRemoveComponent( entity_id, comps[k] )
        end
    end
end